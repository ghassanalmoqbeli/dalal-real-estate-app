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
        $query = new Models($con, "reports");
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

        $reportData = [];

        $requiredFields = ['ad_id', 'reason'];
        foreach ($requiredFields as $field) {
            if (isset($_POST[$field])) {
                $reportData[$field] = $cleanData->clean($_POST[$field]);
            }
        }   

        $errors = [];

        // Required fields validation
        foreach ($requiredFields as $field) {
            if (empty($reportData[$field])) {
                $errors[$field] = "$field is required";
            }
        }

        // AD ID validation
        if (isset($reportData['ad_id']) && !empty($reportData['ad_id'])) {
            if (!is_numeric($reportData['ad_id']) || $reportData['ad_id'] <= 0) {
                $errors['ad_id'] = "AD ID must be a positive number";
            } else {
                // Check if advertisement exists
                $adCheck = new Models($con, "ads");
                $ad = $adCheck->getByField('id', $reportData['ad_id']);
                
                if(!$ad || empty($ad)) {
                    $errors['ad_id'] = 'Advertisement not found';
                } else {
                    // Check if user is not reporting his own ad
                    if($ad[0]['user_id'] == $user_id) {
                        $errors['ad_id'] = 'You cannot report your own advertisement';
                    }
                    
                    // Check if user already reported this ad
                    $existingReport = $query->get("user_id = $user_id AND ad_id = " . $reportData['ad_id']);
                    if($existingReport && !empty($existingReport)) {
                        $errors['ad_id'] = 'You have already reported this advertisement';
                    }
                }
            }
        }

        // Reason validation
        $validReasons = ['fake', 'wrong_info', 'fraud', 'other'];
        if (isset($reportData['reason']) && !empty($reportData['reason'])) {
            if (!in_array($reportData['reason'], $validReasons)) {
                $errors['reason'] = "Invalid reason. Valid reasons are: " . implode(', ', $validReasons);
            }
        }

        // Description validation (optional but required for 'other' reason)
        if (isset($reportData['reason']) && $reportData['reason'] == 'other') {
            if (empty($_POST['description'])) {
                $errors['description'] = "Description is required when reason is 'other'";
            } else {
                $reportData['description'] = $cleanData->clean($_POST['description']);
            }
        } elseif (isset($_POST['description']) && !empty($_POST['description'])) {
            $reportData['description'] = $cleanData->clean($_POST['description']);
        }

        // If there are validation errors
        if (!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $errors
            ];
        } else {
            // Add user_id to reportData
            $reportData['user_id'] = $user_id;
            $reportData['status'] = 'open';
            
            $status_query = $query->create($reportData);

            if($status_query === true){
                $last_id = (string)mysqli_insert_id($con);
                
                $response = [
                    'status' => 'success',
                    'message' => 'Advertisement reported successfully.',
                    'data' => [
                        'id' => $last_id,
                        'user_id' => $user_id,
                        'ad_id' => $reportData['ad_id'],
                        'reason' => $reportData['reason'],
                        'status' => 'open',
                        'created_at' => date('Y-m-d H:i:s')
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => "Error reporting advertisement: " . $status_query
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