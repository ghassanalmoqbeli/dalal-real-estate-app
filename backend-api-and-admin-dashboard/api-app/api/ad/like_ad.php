<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "likes");
        $cleanData = new CleanData($con);
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

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

        $likeData = [];

        $requiredFields = ['ad_id'];
        foreach ($requiredFields as $field) {
            if (isset($_POST[$field])) {
                $likeData[$field] = $cleanData->clean($_POST[$field]);
            }
        }   

        $errors = [];

        // Required fields validation
        foreach ($requiredFields as $field) {
            if (empty($likeData[$field])) {
                $errors[$field] = "$field is required";
            }
        }

        // AD ID validation - must be numeric
        if (isset($likeData['ad_id']) && !empty($likeData['ad_id'])) {
            if (!is_numeric($likeData['ad_id']) || $likeData['ad_id'] <= 0) {
                $errors['ad_id'] = "AD ID must be a positive number";
            } else {
                // Check if advertisement exists
                $adCheck = new Models($con, "ads");
                $ad = $adCheck->getByField('id', $likeData['ad_id']);
                
                if(!$ad || empty($ad)) {
                    $errors['ad_id'] = 'Advertisement not found with this ID';
                }
                
                // Check if user already liked this ad
                $where_condition = "user_id = " . $user_id . " AND ad_id = " . $likeData['ad_id'];
                $existingLike = $query->get($where_condition);
                if($existingLike && !empty($existingLike)) {
                    $errors['ad_id'] = 'You have already liked this advertisement';
                }
            }
        }

        // If there are validation errors
        if (!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $errors
            ];
        } else {
            // Add user_id to likeData
            $likeData['user_id'] = $user_id;
            
            $status_query = $query->create($likeData);

            if($status_query === true){
                $last_id = (string)mysqli_insert_id($con);
                
                $response = [
                    'status' => 'success',
                    'message' => 'Advertisement liked successfully.',
                    'data' => [
                        'id' => $last_id,
                        'user_id' => $user_id,
                        'ad_id' => $likeData['ad_id']
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => "Error liking advertisement: " . $status_query
                ];
            }
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