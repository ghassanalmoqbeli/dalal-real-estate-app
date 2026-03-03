<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/MediaHelper.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "ads");
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

        
        $adData = [];
        $requiredFields = ['id'];
        foreach ($requiredFields as $field) {

            if (isset($_GET[$field])) {
                $adData[$field] = $cleanData->clean($_GET[$field]);
            }
        }

        $errors = [];
        foreach ($requiredFields as $field) {
            if (empty($adData[$field])) {
                $errors[$field] = "$field is required";
            }
        }

        if (isset($adData['id']) && !empty($adData['id'])) {
            if (!is_numeric($adData['id']) || $adData['id'] <= 0) {
                $errors['id'] = "Advertisement ID must be a positive number";
            }
        }

        if (!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $errors
            ];
        } 
        else {
            $ad = $query->getByField('id', $adData['id']);
            
            if($ad && !empty($ad)) {
                
                foreach ($ad as $row) {
                    $data = [
                        'user_id' => $row['user_id'],
                    ];
                }
                
                if($data['user_id'] != $user_id) {
                    $response = [
                        'status' => 'error',
                        'message' => 'You do not have permission to delete this advertisement'
                    ];
                    echo json_encode($response, JSON_PRETTY_PRINT);
                    exit;
                }
                
                // Initialize MediaHelper for file deletion from storage
                $mediaHelper = new MediaHelper();
                
                // Get all media files (images and videos) associated with this ad
                $mediaQuery = new Models($con, "ad_media");
                $mediaRecords = $mediaQuery->getByField('ad_id', $adData['id']);
                
                // Delete all media files (images and videos) from storage directory
                if($mediaRecords && !empty($mediaRecords)) {
                    $deletedCount = 0;
                    $failedCount = 0;
                    
                    foreach($mediaRecords as $media) {
                        if(!empty($media['file_path'])) {
                            // Delete physical file from storage (api-app/storage/ad_media/)
                            // Works for both images (.jpg, .png, etc.) and videos (.mp4, .avi, etc.)
                            // deleteFileByPath automatically detects file type and storage location
                            $deleteResult = $mediaHelper->deleteFileByPath($media['file_path']);
                            
                            if($deleteResult['status'] === true) {
                                $deletedCount++;
                            } else {
                                $failedCount++;
                                // Log deletion failure but continue to delete other files
                                error_log("Failed to delete file: " . $media['file_path'] . " - " . $deleteResult['message']);
                            }
                        }
                    }
                    
                    // Delete media records from database after physical files are deleted (or attempted)
                    $mediaQuery->delete("ad_id = " . $adData['id']);
                }
                
                // Delete related records
                $favoritesQuery = new Models($con, "favorites");
                $favoritesQuery->delete("ad_id = " . $adData['id']);
                
                $likesQuery = new Models($con, "likes");
                $likesQuery->delete("ad_id = " . $adData['id']);
                
                $featuredQuery = new Models($con, "featured_ads");
                $featuredQuery->delete("ad_id = " . $adData['id']);
                
                $where_condition = "id = " . $adData['id'] . " AND user_id = " . $user_id;
                
                $delete_result = $query->delete($where_condition);
                
                if($delete_result === true) {
                    $response = [
                        'status' => 'success',
                        'message' => 'Advertisement deleted successfully.',
                        'data' => [
                            'id' => $adData['id'],
                            'user_id' => $user_id,
                        ]
                    ];
                } else {
                    $response = [
                        'status' => 'error',
                        'message' => 'Error deleting advertisement: ' . $delete_result
                    ];
                }
                
            } else {
                $response = [
                    'status' => 'error',
                    'message' => 'Advertisement not found with this ID'
                ];
            }
        }
    
    } 
    else {
        $response = [
            'status' => 'error',
            'message' => $con
        ]; 
    }
    $con->close();
    
    
}
else {
    $response = [
        "status" => 'error',
        'message' => "Invalid request method. Must be DELETE"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);

