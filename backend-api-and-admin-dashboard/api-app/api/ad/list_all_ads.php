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
        $cleanData = new CleanData($con);
        $mediaHelper = new MediaHelper();
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

        $token_result = $auth->verifyToken($token);
        $user_id = $token_result['status'] === 'success' ? $token_result['user_id'] : null;

        // Get only published ads where user is not blocked
        $adQuery = new Models($con, "ads");
        
        // استخدم JOIN لجلب الإعلانات مع المستخدمين الغير محظورين
        $sql = "SELECT ads.* FROM ads 
                INNER JOIN users ON ads.user_id = users.id 
                WHERE ads.status = 'published' 
                AND users.status != 'blocked'
                ORDER BY ads.created_at DESC";
        
        $result = $con->query($sql);
        
        if($result) {
            $ads = [];
            while($row = $result->fetch_assoc()) {
                $ads[] = $row;
            }
        } else {
            $ads = [];
        }
        
        // Enrich ads with additional data
        $enriched_ads = [];
        if($ads && !empty($ads)) {
            foreach($ads as $ad) {
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
                
                // Check if featured
                $featuredQuery = new Models($con, "featured_ads");
                $featured = $featuredQuery->get("ad_id = $ad_id AND end_date >= CURDATE()");
                $is_featured = ($featured && !empty($featured));
                
                // Get featured info
                $featured_info = null;
                if($is_featured && !empty($featured)) {
                    $featured_data = $featured[0];
                    $remaining_days = max(0, floor((strtotime($featured_data['end_date']) - time()) / (60 * 60 * 24)));
                    
                    $featured_info = [
                        'featured_id' => $featured_data['id'],
                        'start_date' => $featured_data['start_date'],
                        'end_date' => $featured_data['end_date'],
                        'remaining_days' => $remaining_days
                    ];
                }
                
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
                
                $enriched_ads[] = [
                    'ad' => $ad_full_details,
                    'user' => $user_info,
                    'media' => $all_media,
                    'main_image' => $first_media_url,
                    'is_featured' => $is_featured,
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
                'total_ads' => count($enriched_ads),
                'ads' => $enriched_ads ?: []
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