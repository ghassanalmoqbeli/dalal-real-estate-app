<?php
// featured_ads.php
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
        $cleanData = new CleanData($con);
        $mediaHelper = new MediaHelper();
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

        $token_result = $auth->verifyToken($token);
        $user_id = $token_result['status'] === 'success' ? $token_result['user_id'] : null;

        // Get current date
        $current_date = date('Y-m-d');
        
        // Get featured ads that are still active (end_date >= current date) with join to check user status
        $sql = "SELECT fa.*, ads.*, users.status as user_status 
                FROM featured_ads fa 
                INNER JOIN ads ON fa.ad_id = ads.id 
                INNER JOIN users ON ads.user_id = users.id 
                WHERE fa.end_date >= '$current_date' 
                AND ads.status = 'published'
                AND users.status != 'blocked'
                ORDER BY fa.start_date DESC";
        
        $result = $con->query($sql);
        
        $enriched_featured_ads = [];
        
        if($result && $result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $featured = [
                    'id' => $row['id'],
                    'ad_id' => $row['ad_id'],
                    'start_date' => $row['start_date'],
                    'end_date' => $row['end_date'],
                    'created_at' => $row['created_at'] ?? null,
                    'updated_at' => $row['updated_at'] ?? null
                ];
                
                $ad = [
                    'id' => $row['ad_id'],
                    'user_id' => $row['user_id'],
                    'admin_id' => $row['admin_id'] ?? null,
                    'type' => $row['type'] ?? '',
                    'offer_type' => $row['offer_type'] ?? '',
                    'title' => $row['title'] ?? '',
                    'description' => $row['description'] ?? '',
                    'city' => $row['city'] ?? '',
                    'location_text' => $row['location_text'] ?? '',
                    'google_map_url' => $row['google_map_url'] ?? null,
                    'latitude' => $row['latitude'] ?? null,
                    'longitude' => $row['longitude'] ?? null,
                    'price' => $row['price'],
                    'currency' => $row['currency'] ?? 'YER',
                    'negotiable' => $row['negotiable'],
                    'area' => $row['area'],
                    'extra_details' => $row['extra_details'] ?? null,
                    'rooms' => $row['rooms'] ?? null,
                    'living_rooms' => $row['living_rooms'] ?? null,
                    'bathrooms' => $row['bathrooms'] ?? null,
                    'kitchens' => $row['kitchens'] ?? null,
                    'floors' => $row['floors'] ?? null,
                    'status' => $row['status'] ?? 'published',
                    'reject_reason' => $row['reject_reason'] ?? null,
                    'created_at' => $row['created_at'] ?? '',
                    'updated_at' => $row['updated_at'] ?? ''
                ];
                
                $ad_id = $ad['id'];
                
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
                
                // Get likes count
                $likesQuery = new Models($con, "likes");
                $likes = $likesQuery->getByField('ad_id', $ad_id);
                $total_likes = $likes ? count($likes) : 0;
                
                // Get favorites count
                $favoritesQuery = new Models($con, "favorites");
                $favorites = $favoritesQuery->getByField('ad_id', $ad_id);
                $total_favorites = $favorites ? count($favorites) : 0;
                
                // Check if user liked/favorited
                $user_liked = false;
                $user_favorited = false;
                
                if($user_id) {
                    $user_like = $likesQuery->get("user_id = $user_id AND ad_id = $ad_id");
                    $user_liked = ($user_like && !empty($user_like));
                    
                    $user_favorite = $favoritesQuery->get("user_id = $user_id AND ad_id = $ad_id");
                    $user_favorited = ($user_favorite && !empty($user_favorite));
                }
                
                // Get user info (نعلم أن المستخدم غير محظور لأننا فلترنا في SQL)
                $userQuery = new Models($con, "users");
                $user = $userQuery->getByField('id', $ad['user_id']);
                
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
                        'whatsapp' => $user_data['whatsapp'] ?? null,
                        'date_of_birth' => $user_data['date_of_birth'] ?? null,
                        'profile_image' => $profile_image_url,
                        'status' => $user_data['status'] ?? 'active',
                        'admin_id' => $user_data['admin_id'] ?? null,
                        'created_at' => $user_data['created_at'] ?? '',
                        'updated_at' => $user_data['updated_at'] ?? ''
                    ];
                }
                
                // Calculate remaining days for featured status
                $remaining_days = max(0, floor((strtotime($featured['end_date']) - time()) / (60 * 60 * 24)));
                
                // جميع بيانات الإعلان من جدول ads
                $ad_full_details = [
                    // المعلومات الأساسية
                    'id' => $ad['id'],
                    'user_id' => $ad['user_id'],
                    'admin_id' => $ad['admin_id'] ?? null,
                    
                    // نوع العقار والعرض
                    'type' => $ad['type'] ?? '',
                    'offer_type' => $ad['offer_type'] ?? '',
                    
                    // المعلومات العامة
                    'title' => $ad['title'] ?? '',
                    'description' => $ad['description'] ?? '',
                    
                    // الموقع
                    'city' => $ad['city'] ?? '',
                    'location_text' => $ad['location_text'] ?? '',
                    'google_map_url' => $ad['google_map_url'] ?? null,
                    'latitude' => $ad['latitude'] ?? null,
                    'longitude' => $ad['longitude'] ?? null,
                    
                    // السعر والعملة
                    'price' => $ad['price'],
                    'currency' => $ad['currency'] ?? 'YER',
                    'negotiable' => $ad['negotiable'],
                    
                    // المساحة
                    'area' => $ad['area'],
                    
                    // التفاصيل الإضافية
                    'extra_details' => $ad['extra_details'] ?? null,
                    
                    // تفاصيل الغرف
                    'rooms' => $ad['rooms'] ?? null,
                    'living_rooms' => $ad['living_rooms'] ?? null,
                    'bathrooms' => $ad['bathrooms'] ?? null,
                    'kitchens' => $ad['kitchens'] ?? null,
                    'floors' => $ad['floors'] ?? null,
                    
                    // الحالة
                    'status' => $ad['status'] ?? 'published',
                    'reject_reason' => $ad['reject_reason'] ?? null,
                    
                    // التواريخ
                    'created_at' => $ad['created_at'] ?? '',
                    'updated_at' => $ad['updated_at'] ?? ''
                ];
                
                // Featured information
                $featured_info = [
                    'featured_id' => $featured['id'],
                    'start_date' => $featured['start_date'],
                    'end_date' => $featured['end_date'],
                    'remaining_days' => $remaining_days
                ];
                
                $enriched_featured_ads[] = [
                    'ad' => $ad_full_details,
                    'user' => $user_info,
                    'media' => $all_media,
                    'main_image' => $first_media_url,
                    'is_featured' => true,
                    'featured_info' => $featured_info,
                    'statistics' => [
                        'likes_count' => $total_likes,
                        'favorites_count' => $total_favorites,
                        'media_count' => count($all_media)
                    ],
                    'user_interaction' => [
                        'liked' => $user_liked,
                        'favorited' => $user_favorited,
                        'is_owner' => ($user_id && $ad['user_id'] == $user_id)
                    ]
                ];
            }
        }
        
        $response = [
            'status' => 'success',
            'data' => [
                'total_featured_ads' => count($enriched_featured_ads),
                'current_date' => $current_date,
                'featured_ads' => $enriched_featured_ads ?: []
            ]
        ];
    
    } else {
        $response = ['status' => 'error', 'message' => $con];
    }
    $con->close();

} else {
    $response = ['status' => 'error', 'message' => "Request must be GET"];
}

echo json_encode($response, JSON_PRETTY_PRINT);