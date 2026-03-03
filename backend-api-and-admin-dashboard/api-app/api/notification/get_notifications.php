<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

function normalize_text($s) {
    if (!is_string($s)) return $s;
    // Undo common escaping issues (e.g. \" or \\ stored as literal text)
    $s = stripslashes($s);
    // If value itself is a JSON string, decode it (e.g. "\"Hello\"" -> Hello)
    if (strlen($s) >= 2 && $s[0] === '"' && $s[strlen($s) - 1] === '"') {
        $decoded = json_decode($s, true);
        if (is_string($decoded)) return $decoded;
        $s = trim($s, '"');
    }
    return $s;
}

if($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($con === true || is_object($con)) {
        
        $auth = new TokenAuth($con);
        $cleanData = new CleanData($con);
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';
        
        // Token is required for notifications
        if(empty($token)) {
            $response = [
                'status' => 'error',
                'message' => 'Authentication token is required'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            exit;
        }
        
        $token_result = $auth->verifyToken($token);
        
        if($token_result['status'] !== 'success') {
            $response = [
                'status' => 'error',
                'message' => $token_result['message']
            ];
            echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            exit;
        }
        
        $user_id = $token_result['user_id'];
        
        // Get filter parameters
        $read = isset($_GET['read']) ? $cleanData->clean($_GET['read']) : null; // 'true', 'false', or null for all
        $limit = isset($_GET['limit']) && is_numeric($_GET['limit']) && $_GET['limit'] > 0 ? intval($_GET['limit']) : 50;
        $offset = isset($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] >= 0 ? intval($_GET['offset']) : 0;
        
        // Get last notification ID for real-time updates (polling)
        $last_id = isset($_GET['last_id']) && is_numeric($_GET['last_id']) && $_GET['last_id'] > 0 ? intval($_GET['last_id']) : 0;
        
        // Build query
        $query = new Models($con, "notifications");
        
        $whereCondition = "user_id = $user_id";
        
        // Filter by read status
        if($read === 'true' || $read === '1') {
            $whereCondition .= " AND is_read = 1";
        } elseif($read === 'false' || $read === '0') {
            $whereCondition .= " AND is_read = 0";
        }
        
        // For real-time: get only new notifications (after last_id)
        if($last_id > 0) {
            $whereCondition .= " AND id > $last_id";
        }
        
        $whereCondition .= " ORDER BY created_at DESC";
        
        if($limit > 0) {
            $whereCondition .= " LIMIT $limit";
            if($offset > 0) {
                $whereCondition .= " OFFSET $offset";
            }
        }
        
        $notifications = $query->get($whereCondition);
        if ($notifications && !empty($notifications)) {
            foreach ($notifications as &$n) {
                if (isset($n['message'])) {
                    $n['message'] = normalize_text($n['message']);
                }
            }
            unset($n);
        }
        
        // Count unread notifications
        $unreadQuery = new Models($con, "notifications");
        $unreadNotifications = $unreadQuery->get("user_id = $user_id AND is_read = 0");
        $unread_count = $unreadNotifications ? count($unreadNotifications) : 0;
        
        // Get total count
        $totalQuery = new Models($con, "notifications");
        $allNotifications = $totalQuery->get("user_id = $user_id");
        $total_count = $allNotifications ? count($allNotifications) : 0;
        
        // Get highest ID for next polling
        $max_id = 0;
        if($notifications && !empty($notifications)) {
            foreach($notifications as $notif) {
                if(intval($notif['id']) > $max_id) {
                    $max_id = intval($notif['id']);
                }
            }
        }
        
        // If no notifications, get max ID from all user notifications
        if($max_id == 0) {
            $maxQueryResult = $con->query("SELECT MAX(id) as max_id FROM notifications WHERE user_id = $user_id");
            if($maxQueryResult && $row = $maxQueryResult->fetch_assoc()) {
                $max_id = intval($row['max_id'] ?? 0);
            }
        }
        
        $response = [
            'status' => 'success',
            'data' => [
                'notifications' => $notifications ?: [],
                'unread_count' => $unread_count,
                'total_count' => $total_count,
                'last_id' => $max_id, // Use this for next polling
                'has_new' => ($last_id > 0 && $notifications && count($notifications) > 0) ? true : false
            ]
        ];
        
    } else {
        $response = [
            'status' => 'error',
            'message' => $con
        ]; 
    }
    $con->close();

} else {
    $response = [
        "status" => 'error',
        'message' => "error in method request must be GET"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

