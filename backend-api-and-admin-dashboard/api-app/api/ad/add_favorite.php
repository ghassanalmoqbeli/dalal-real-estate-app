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
        $query = new Models($con, "favorites");
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

        $favoriteData = [];

        $requiredFields = ['ad_id'];
        foreach ($requiredFields as $field) {
            if (isset($_POST[$field])) {
                $favoriteData[$field] = $cleanData->clean($_POST[$field]);
            }
        }   

        $errors = [];

        // Required fields validation
        foreach ($requiredFields as $field) {
            if (empty($favoriteData[$field])) {
                $errors[$field] = "$field is required";
            }
        }

        // AD ID validation - must be numeric
        if (isset($favoriteData['ad_id']) && !empty($favoriteData['ad_id'])) {
            if (!is_numeric($favoriteData['ad_id']) || $favoriteData['ad_id'] <= 0) {
                $errors['ad_id'] = "AD ID must be a positive number";
            } else {
                // Check if advertisement exists
                $adCheck = new Models($con, "ads");
                $ad = $adCheck->getByField('id', $favoriteData['ad_id']);
                
                if(!$ad || empty($ad)) {
                    $errors['ad_id'] = 'Advertisement not found with this ID';
                }
                
                // Check if user already favorited this ad
                $where_condition = "user_id = " . $user_id . " AND ad_id = " . $favoriteData['ad_id'];
                $existingFavorite = $query->get($where_condition);
                if($existingFavorite && !empty($existingFavorite)) {
                    $errors['ad_id'] = 'You have already added this advertisement to favorites';
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
            // Add user_id to favoriteData
            $favoriteData['user_id'] = $user_id;
            
            $status_query = $query->create($favoriteData);

            if($status_query === true){
                $last_id = (string)mysqli_insert_id($con);
                
                $response = [
                    'status' => 'success',
                    'message' => 'Advertisement added to favorites successfully.',
                    'data' => [
                        'id' => $last_id,
                        'user_id' => $user_id,
                        'ad_id' => $favoriteData['ad_id']
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => "Error adding to favorites: " . $status_query
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