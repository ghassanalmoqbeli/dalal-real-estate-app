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

if($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "favorites");
        $cleanData = new CleanData($con);
        $mediaHelper = new MediaHelper();
        
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
        
        $favorites = $query->getByField('user_id', $user_id);
        
        $favorites_with_ads = [];
        if($favorites && !empty($favorites)) {
            $adQuery = new Models($con, "ads");
            foreach($favorites as $favorite) {
                $ad = $adQuery->getByField('id', $favorite['ad_id']);
                if($ad && !empty($ad)) {
                    $ad_data = $ad[0];
                    $ad_id = $ad_data['id'];
                    
                    // Get all media with URLs
                    $mediaQuery = new Models($con, "ad_media");
                    $media = $mediaQuery->getByField('ad_id', $ad_id);
                    
                    $all_media = [];
                    if($media && !empty($media)) {
                        foreach($media as $media_item) {
                            if(isset($media_item['file_path'])) {
                                $media_info = $mediaHelper->getMediaInfo($media_item['file_path']);
                                if($media_info['status']) {
                                    $all_media[] = [
                                        'id' => $media_item['id'] ?? null,
                                        'type' => $media_item['type'] ?? null,
                                        'url' => $media_info['url'],
                                        'media_type' => $media_info['media_type'],
                                        'mime_type' => $media_info['mime_type']
                                    ];
                                }
                            }
                        }
                    }
                    
                    // Get first media for thumbnail
                    $first_media_url = !empty($all_media) ? $all_media[0]['url'] : null;
                    
                    // Get user info with profile image
                    $userQuery = new Models($con, "users");
                    $user = $userQuery->getByField('id', $ad_data['user_id']);
                    
                    $user_info = null;
                    if($user && !empty($user)) {
                        $user_data = $user[0];
                        
                        // Get profile_image URL if exists
                        $profile_image_url = null;
                        if(!empty($user_data['profile_image'])) {
                            // Build correct path - profile_image might be stored as filename only or full path
                            $profile_image_path = $user_data['profile_image'];
                            if(strpos($profile_image_path, 'storage/user_profiles') === false && strpos($profile_image_path, '../../storage/user_profiles') === false) {
                                // If it's just filename, add the path
                                $profile_image_path = "../../storage/user_profiles/" . $profile_image_path;
                            }
                            
                            $profile_image_result = $mediaHelper->getMediaInfo($profile_image_path);
                            if($profile_image_result['status']) {
                                $profile_image_url = $profile_image_result['url'];
                            }
                        }
                        
                        $user_info = [
                            'id' => $user_data['id'],
                            'name' => $user_data['name'] ?? '',
                            'phone' => $user_data['phone'] ?? '',
                            'is_phone_verified' => $user_data['is_phone_verified'] ?? false,
                            'profile_image' => $profile_image_url
                        ];
                    }
                    
                    // Build enriched ad details
                    $favorite['ad'] = $ad_data;
                    $favorite['media'] = $all_media;
                    $favorite['main_image'] = $first_media_url;
                    $favorite['user'] = $user_info;
                    
                    $favorites_with_ads[] = $favorite;
                }
            }
        }
        
        $response = [
            'status' => 'success',
            'data' => [
                'user_id' =>$user_id,
                'total_favorites' => count($favorites_with_ads),
                'favorites' => $favorites_with_ads ?: []
            ]
        ];
    
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