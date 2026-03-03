<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/BodyReader.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'POST') {
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
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        $token_result = $auth->verifyToken($token);
        
        if($token_result['status'] !== 'success') {
            $response = [
                'status' => 'error',
                'message' => $token_result['message']
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        $user_id = $token_result['user_id'];
        

        
        // Check if user already has a pending deletion request
        $userQuery = new Models($con, "users");
        $user = $userQuery->getByField('id', $user_id);
        
        if($user && !empty($user)) {
            $userData = $user[0];
            
            // Check current status
            if(isset($userData['status']) && $userData['status'] === 'pending_deletion') {
                $response = [
                    'status' => 'error',
                    'message' => 'You already have a pending deletion request'
                ];
                echo json_encode($response, JSON_PRETTY_PRINT);
                exit;
            }
            
            // Update user status to pending_deletion
            $updateData = [
                'status' => 'pending_deletion'
            ];
            
            $updateResult = $userQuery->update($updateData, "id = $user_id");
            
            if($updateResult === true) {
                // Optionally save deletion reason in a separate table or in user notes
                // For now, we'll just update the status
                
                // Send notification to admin (optional)
                // You can implement admin notification here if needed
                
                $response = [
                    'status' => 'success',
                    'message' => 'Account deletion request sent successfully. It will be reviewed by the administration soon.',
                    'data' => [
                        'user_id' => $user_id,
                        'status' => 'pending_deletion'
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => 'Failed to send deletion request: ' . $updateResult
                ];
            }
        } else {
            $response = [
                'status' => 'error',
                'message' => 'User not found'
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
        'message' => "error in method request must be POST"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);

