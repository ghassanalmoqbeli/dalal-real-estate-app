<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'DELETE') {
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

        // Get ad_id from GET parameters
        $ad_id = isset($_GET['ad_id']) ? $cleanData->clean($_GET['ad_id']) : '';

        $errors = [];

        // AD ID validation - must be numeric
        if (empty($ad_id)) {
            $errors['ad_id'] = "AD ID is required";
        } elseif (!is_numeric($ad_id) || $ad_id <= 0) {
            $errors['ad_id'] = "AD ID must be a positive number";
        } else {
            // Check if favorite exists
            $where_condition = "user_id = " . $user_id . " AND ad_id = " . $ad_id;
            $existingFavorite = $query->get($where_condition);
            if(!$existingFavorite || empty($existingFavorite)) {
                $errors['ad_id'] = 'This advertisement is not in your favorites';
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
            // Delete favorite
            $where_condition = "user_id = $user_id AND ad_id = $ad_id";
            $status_query = $query->delete($where_condition);

            if($status_query === true) {
                $response = [
                    'status' => 'success',
                    'message' => 'Advertisement removed from favorites successfully.',
                    'data' => [
                        'user_id' => $user_id,
                        'ad_id' => $ad_id
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => "Error removing from favorites: " . $status_query
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
        'message' => "error in method request must be DELETE"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);