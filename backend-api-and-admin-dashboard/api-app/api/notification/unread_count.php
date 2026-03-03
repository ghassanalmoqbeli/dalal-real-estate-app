<?php
include "../../config/Database.php";
include "../../helpers/TokenAuth.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();

$response = [];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($con === true || is_object($con)) {
        $auth = new TokenAuth($con);

        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

        if (empty($token)) {
            $response = [
                'status' => 'error',
                'message' => 'Authentication token is required'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            exit;
        }

        $token_result = $auth->verifyToken($token);
        if ($token_result['status'] !== 'success') {
            $response = [
                'status' => 'error',
                'message' => $token_result['message']
            ];
            echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            exit;
        }

        $user_id = intval($token_result['user_id']);

        $unreadResult = $con->query("SELECT COUNT(*) as cnt FROM notifications WHERE user_id = $user_id AND is_read = 0");
        $unread_count = 0;
        if ($unreadResult && ($row = $unreadResult->fetch_assoc())) {
            $unread_count = intval($row['cnt'] ?? 0);
        }

        $maxResult = $con->query("SELECT MAX(id) as max_id FROM notifications WHERE user_id = $user_id");
        $last_id = 0;
        if ($maxResult && ($row = $maxResult->fetch_assoc())) {
            $last_id = intval($row['max_id'] ?? 0);
        }

        $response = [
            'status' => 'success',
            'data' => [
                'unread_count' => $unread_count,
                'last_id' => $last_id
            ]
        ];
    } else {
        $response = [
            'status' => 'error',
            'message' => $con
        ];
    }

    if (is_object($con)) {
        $con->close();
    }
} else {
    $response = [
        'status' => 'error',
        'message' => 'error in method request must be GET'
    ];
}

echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);


