<?php
include "../../config/Database.php";
include "../../helpers/TokenAuth.php";

// Server-Sent Events (SSE) endpoint for real-time notifications.
// Flutter can connect and receive new notifications as they are inserted by admin.

header('Content-Type: text/event-stream; charset=utf-8');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Connection: keep-alive');
header('X-Accel-Buffering: no'); // for nginx (if used)

// CORS (mobile عادة لا يحتاج، لكن مفيد للويب)
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Authorization, Content-Type');

@ini_set('output_buffering', 'off');
@ini_set('zlib.output_compression', '0');
while (ob_get_level() > 0) {
    @ob_end_flush();
}
@ob_implicit_flush(true);

ignore_user_abort(true);
set_time_limit(0);

$db = new Database();
$con = $db->connect();

function normalize_text($s) {
    if (!is_string($s)) return $s;
    $s = stripslashes($s);
    if (strlen($s) >= 2 && $s[0] === '"' && $s[strlen($s) - 1] === '"') {
        $decoded = json_decode($s, true);
        if (is_string($decoded)) return $decoded;
        $s = trim($s, '"');
    }
    return $s;
}

function sse_send($event, $data) {
    echo "event: {$event}\n";
    echo "data: " . json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n\n";
    @flush();
}

if (!($con === true || is_object($con))) {
    sse_send('error', ['message' => 'DB connection failed']);
    exit;
}

$auth = new TokenAuth($con);
$headers = getallheaders();
$token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

if (empty($token)) {
    sse_send('error', ['message' => 'Authentication token is required']);
    $con->close();
    exit;
}

$token_result = $auth->verifyToken($token);
if (($token_result['status'] ?? '') !== 'success') {
    sse_send('error', ['message' => $token_result['message'] ?? 'Invalid token']);
    $con->close();
    exit;
}

$user_id = intval($token_result['user_id']);

// last_id: start point (client can pass last known id)
$last_id = isset($_GET['last_id']) && is_numeric($_GET['last_id']) ? intval($_GET['last_id']) : 0;

// timeout seconds for this SSE request (client should reconnect automatically)
$timeout = isset($_GET['timeout']) && is_numeric($_GET['timeout']) ? intval($_GET['timeout']) : 25;
if ($timeout < 5) $timeout = 5;
if ($timeout > 120) $timeout = 120;

// polling interval (seconds) inside SSE connection
$interval = isset($_GET['interval']) && is_numeric($_GET['interval']) ? floatval($_GET['interval']) : 1.0;
if ($interval < 0.5) $interval = 0.5;
if ($interval > 5) $interval = 5;

sse_send('hello', [
    'user_id' => $user_id,
    'last_id' => $last_id,
    'timeout' => $timeout
]);

$start = time();
$last_ping = 0;

while (true) {
    if (connection_aborted()) {
        break;
    }

    $now = time();
    if (($now - $start) >= $timeout) {
        sse_send('close', ['reason' => 'timeout']);
        break;
    }

    // Heartbeat كل 10 ثواني
    if ($now - $last_ping >= 10) {
        $last_ping = $now;
        $unreadResult = $con->query("SELECT COUNT(*) as cnt FROM notifications WHERE user_id = $user_id AND is_read = 0");
        $unread_count = 0;
        if ($unreadResult && ($row = $unreadResult->fetch_assoc())) {
            $unread_count = intval($row['cnt'] ?? 0);
        }
        sse_send('ping', ['time' => date('c'), 'unread_count' => $unread_count, 'last_id' => $last_id]);
    }

    // Fetch new notifications after last_id (ascending)
    $result = $con->query("SELECT * FROM notifications WHERE user_id = $user_id AND id > $last_id ORDER BY id ASC LIMIT 50");
    if ($result) {
        $sent_any = false;
        while ($row = $result->fetch_assoc()) {
            $sent_any = true;
            $nid = intval($row['id'] ?? 0);
            if ($nid > $last_id) $last_id = $nid;

            if (isset($row['message'])) {
                $row['message'] = normalize_text($row['message']);
            }

            sse_send('notification', [
                'notification' => $row,
                'last_id' => $last_id
            ]);
        }

        if ($sent_any) {
            // After pushing notifications, also push updated unread_count
            $unreadResult = $con->query("SELECT COUNT(*) as cnt FROM notifications WHERE user_id = $user_id AND is_read = 0");
            $unread_count = 0;
            if ($unreadResult && ($row = $unreadResult->fetch_assoc())) {
                $unread_count = intval($row['cnt'] ?? 0);
            }
            sse_send('unread_count', ['unread_count' => $unread_count, 'last_id' => $last_id]);
        }
    }

    usleep((int)($interval * 1000000));
}

$con->close();


