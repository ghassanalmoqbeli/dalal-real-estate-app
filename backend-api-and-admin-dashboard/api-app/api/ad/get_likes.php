<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "likes");
        $cleanData = new CleanData($con);
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

        $token_result = $auth->verifyToken($token);

        // Token is optional for this endpoint
        $user_id = $token_result['status'] === 'success' ? $token_result['user_id'] : null;

        // Get ad_id from GET parameters
        $ad_id = isset($_GET['ad_id']) ? $cleanData->clean($_GET['ad_id']) : '';

        $errors = [];

        // AD ID validation - must be numeric
        if (empty($ad_id)) {
            $errors['ad_id'] = "AD ID is required";
        } elseif (!is_numeric($ad_id) || $ad_id <= 0) {
            $errors['ad_id'] = "AD ID must be a positive number";
        } else {
            // Check if advertisement exists
            $adCheck = new Models($con, "ads");
            $ad = $adCheck->getByField('id', $ad_id);
            
            if(!$ad || empty($ad)) {
                $errors['ad_id'] = 'Advertisement not found with this ID';
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
            // Get likes count
            $likes = $query->getByField('ad_id', $ad_id);
            $total_likes = $likes ? count($likes) : 0;
            
            // Check if current user liked this ad
            $user_liked = false;
            if($user_id) {
                $where_condition = "user_id = " . $user_id . " AND ad_id = " . $ad_id;
                $user_like = $query->get($where_condition);
                $user_liked = ($user_like && !empty($user_like));
            }
            
            $response = [
                'status' => 'success',
                'data' => [
                    'ad_id' =>$ad_id,
                    'total_likes' => $total_likes,
                    'user_liked' => $user_liked,
                    'likes' => $likes ?: []
                ]
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
        'message' => "error in method request must be GET"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);