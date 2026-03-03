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

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "ad_media");
        $adQuery = new Models($con, "ads");
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

        $mediaData = [];

        $requiredFields = ['ad_id','type','media_base64'];
        foreach ($requiredFields as $field) {
            if (isset($_POST[$field])) {
                $mediaData[$field] = $cleanData->clean($_POST[$field]);
            }
        }   

        $errors = [];

        // Required fields validation
        foreach ($requiredFields as $field) {
            if (empty($mediaData[$field])) {
                $errors[$field] = "$field is required";
            }
        }

        // Type validation
        $validTypes = ['image', 'video'];
        if (isset($mediaData['type']) && !empty($mediaData['type']) && !in_array($mediaData['type'], $validTypes)) {
            $errors['type'] = "Invalid media type: only (image, video)";
        }

        // AD ID validation - must be numeric
        if (isset($mediaData['ad_id']) && !empty($mediaData['ad_id'])) {
            if (!is_numeric($mediaData['ad_id']) || $mediaData['ad_id'] <= 0) {
                $errors['ad_id'] = "AD ID must be a positive number";
            } else {
                // Permission check - verify user owns the advertisement
                $adCheck = new Models($con, "ads");
                $ad = $adCheck->getByField('id', $mediaData['ad_id']);
                
                if($ad && !empty($ad)) {
                    $adOwnerId = $ad[0]['user_id']; // Get first result's user_id
                    
                    if($adOwnerId != $user_id) {
                        $errors['ad_id'] = 'You do not have permission to add media to this advertisement';
                    }
                } else {
                    $errors['ad_id'] = 'Advertisement not found with this ID';
                }
            }
        }
        // Media validation - must be valid base64
        if (isset($mediaData['media_base64']) && !empty($mediaData['media_base64'])) {
            if(!$media->validateBase64($mediaData['media_base64'])){
                $errors['media_base64'] = "Invalid media format. The base64 string must start with a Data URL prefix: 'data:image/' for images or 'data:video/' for videos.";

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

            $path="../../storage/ad_media";
            $status_media=$media->saveBase64File($mediaData['media_base64'],$path,$mediaData['ad_id']);
            
            if($status_media['status']===false){
                $response = [
                'status' => 'error',
                'message' => $status_media['message']
            ];

            }
            else{
                unset($mediaData['media_base64']);
                $mediaData['file_path'] = $status_media['file_path'];

                $status_query = $query->create($mediaData);

                if($status_query===true){
                    $last_id = (string)mysqli_insert_id($con);
                    $mediaData['id'] = $last_id;
                    
                    $response = [
                        'status' => 'success',
                        'message' => 'Advertisement media created successfully.',
                        'data' => ['id'=>$mediaData['id'],
                                    'ad_id'=>$mediaData['ad_id'],
                                    'type'=>$mediaData['type']]
                    ];
                } else {
                    $media->deleteMedia($path,$status_media['file_name']);

                    $response = [
                        'status' => 'error',
                        'message' => "Error creating media: " . $status_query
                    ];
                }


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