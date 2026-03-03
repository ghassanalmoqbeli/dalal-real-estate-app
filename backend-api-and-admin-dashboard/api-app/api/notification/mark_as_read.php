<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'PUT' || $_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {
        
        $auth = new TokenAuth($con);
        $cleanData = new CleanData($con);
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';
        
        // Token is required
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
        
        // Get notification ID from body or GET
        $input = file_get_contents('php://input');
        $data = json_decode($input, true);
        
        $notification_id = null;
        
        if($_SERVER['REQUEST_METHOD'] == 'PUT' && $data) {
            $notification_id = isset($data['notification_id']) ? intval($data['notification_id']) : null;
        } elseif($_SERVER['REQUEST_METHOD'] == 'POST') {
            $notification_id = isset($_POST['notification_id']) ? intval($_POST['notification_id']) : null;
        }
        
        // If notification_id is 0 or 'all', mark all as read
        if($notification_id === 0 || (isset($data['all']) && $data['all'] === true)) {
            // Mark all user notifications as read
            $updateQuery = "UPDATE notifications SET is_read = 1 WHERE user_id = $user_id AND is_read = 0";
            if(mysqli_query($con, $updateQuery)) {
                $affected = mysqli_affected_rows($con);
                $response = [
                    'status' => 'success',
                    'message' => "Marked $affected notifications as read",
                    'data' => [
                        'marked_count' => $affected
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => 'Failed to update notifications: ' . mysqli_error($con)
                ];
            }
        } elseif($notification_id && $notification_id > 0) {
            // Mark specific notification as read
            // Verify notification belongs to user
            $checkQuery = new Models($con, "notifications");
            $notification = $checkQuery->get("id = $notification_id AND user_id = $user_id");
            
            if($notification && !empty($notification)) {
                $updateData = ['is_read' => 1];
                $updateResult = $checkQuery->update($updateData, "id = $notification_id AND user_id = $user_id");
                
                if($updateResult === true) {
                    $response = [
                        'status' => 'success',
                        'message' => 'Notification marked as read',
                        'data' => [
                            'notification_id' => $notification_id
                        ]
                    ];
                } else {
                    $response = [
                        'status' => 'error',
                        'message' => 'Failed to update notification: ' . $updateResult
                    ];
                }
            } else {
                $response = [
                    'status' => 'error',
                    'message' => 'Notification not found or does not belong to user'
                ];
            }
        } else {
            $response = [
                'status' => 'error',
                'message' => 'Invalid notification ID. Use notification_id or set all=true to mark all as read'
            ];
        }
        
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
        'message' => "error in method request must be PUT or POST"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

