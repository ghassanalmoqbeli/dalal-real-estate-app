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
        $query = new Models($con, "ad_media");
        $cleanData = new CleanData($con);
        $media = new MediaHelper();
        
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

        // Get media_id from GET parameters
        $media_id = isset($_GET['media_id']) ? $cleanData->clean($_GET['media_id']) : '';

        $errors = [];

        // Media ID validation - must be numeric
        if (empty($media_id)) {
            $errors['media_id'] = "Media ID is required";
        } elseif (!is_numeric($media_id) || $media_id <= 0) {
            $errors['media_id'] = "Media ID must be a positive number";
        } else {
            // Permission check - verify user owns the advertisement associated with the media
            $mediaRecord = $query->getByField('id', $media_id);
            
            if($mediaRecord && !empty($mediaRecord)) {
                $mediaRecord = $mediaRecord[0];
                $ad_id = $mediaRecord['ad_id'];
                
                // Check if user owns the advertisement
                $adCheck = new Models($con, "ads");
                $ad = $adCheck->getByField('id', $ad_id);
                
                if($ad && !empty($ad)) {
                    $adOwnerId = $ad[0]['user_id'];
                    
                    if($adOwnerId != $user_id) {
                        $errors['media_id'] = 'You do not have permission to delete this media';
                    }
                } else {
                    $errors['media_id'] = 'Associated advertisement not found';
                }
            } else {
                $errors['media_id'] = 'Media not found with this ID';
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
            // Get media record to delete file
            $mediaRecord = $query->getByField('id', $media_id);
            $mediaRecord = $mediaRecord[0];
            

            $where_condition="id=".$media_id;
            
            // Delete media record from database
            $status_query = $query->delete($where_condition);

            if($status_query === true) {

                // Delete media file from storage
                if(isset($mediaRecord['file_path'])) {
                    $file_path = $mediaRecord['file_path'];
                    
                    // Extract filename from full path
                    $path_info = pathinfo($file_path);
                    $file_name = isset($path_info['basename']) ? $path_info['basename'] : '';
                    $path = "../../storage/ad_media";
                    
                    if($file_name) {
                        $deleteFile = $media->deleteMedia($path, $file_name);
                    }
                }

                $response = [
                    'status' => 'success',
                    'message' => 'Advertisement media deleted successfully.',
                    'data' => [
                        'deleted_media_id' => $file_name,
                        'ad_id' => isset($mediaRecord['ad_id']) ? $mediaRecord['ad_id'] : ''
                    ]
                ];

            } else {
                $response = [
                    'status' => 'error',
                    'message' => "Error deleting media: " . $status_query
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