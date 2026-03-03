<?php
// user_profile.php
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

        if($token_result['status'] !== 'success') {
            $response = [
                'status' => 'error',
                'message' => $token_result['message']
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }

        $user_id = $token_result['user_id'];
        
        // دالة مساعدة لجلب تفاصيل الإعلان
        function getAdDetails($con, $ad_id, $mediaHelper, $current_user_id = null) {
            $adQuery = new Models($con, "ads");
            $ad = $adQuery->getByField('id', $ad_id);
            
            if(!$ad || empty($ad)) {
                return null;
            }
            
            $ad = $ad[0];
            
            // جلب الميديا
            $mediaQuery = new Models($con, "ad_media");
            $media = $mediaQuery->getByField('ad_id', $ad_id);
            
            $all_media = [];
            if($media && !empty($media)) {
                foreach($media as $media_item) {
                    if(isset($media_item['file_path'])) {
                        $media_info = $mediaHelper->getMediaInfo($media_item['file_path']);
                        if($media_info['status']) {
                            $all_media[] = [
                                'id' => $media_item['id'],
                                'type' => $media_item['type'] ?? null,
                                'url' => $media_info['url'],
                                'media_type' => $media_info['media_type'],
                                'mime_type' => $media_info['mime_type']
                            ];
                        }
                    }
                }
            }
            
            // الصورة الرئيسية
            $first_media_url = !empty($all_media) ? $all_media[0]['url'] : null;
            
            // الإحصائيات
            $likesQuery = new Models($con, "likes");
            $likes = $likesQuery->getByField('ad_id', $ad_id);
            $total_likes = $likes ? count($likes) : 0;
            
            $favoritesQuery = new Models($con, "favorites");
            $favorites = $favoritesQuery->getByField('ad_id', $ad_id);
            $total_favorites = $favorites ? count($favorites) : 0;
            
            // التحقق من المميز
            $featuredQuery = new Models($con, "featured_ads");
            $featured = $featuredQuery->get("ad_id = $ad_id AND end_date >= CURDATE()");
            $is_featured = ($featured && !empty($featured));
            
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
            
            // تفاعل المستخدم الحالي
            $user_liked = false;
            $user_favorited = false;
            
            if($current_user_id) {
                $user_like = $likesQuery->get("user_id = $current_user_id AND ad_id = $ad_id");
                $user_liked = ($user_like && !empty($user_like));
                
                $user_favorite = $favoritesQuery->get("user_id = $current_user_id AND ad_id = $ad_id");
                $user_favorited = ($user_favorite && !empty($user_favorite));
            }
            
            // معلومات مالك الإعلان
            $userQuery = new Models($con, "users");
            $owner = $userQuery->getByField('id', $ad['user_id']);
            $owner_info = null;
            
            if($owner && !empty($owner)) {
                $owner_data = $owner[0];
                $profile_image_url = null;
                
                if(!empty($owner_data['profile_image'])) {
                    // Build correct path - profile_image might be stored as filename only or full path
                    $profile_image_path = $owner_data['profile_image'];
                    if(strpos($profile_image_path, 'storage/user_profiles') === false && strpos($profile_image_path, '../../storage/user_profiles') === false) {
                        // If it's just filename, add the path
                        $profile_image_path = "../../storage/user_profiles/" . $profile_image_path;
                    }
                    
                    $profile_image_result = $mediaHelper->getMediaInfo($profile_image_path);
                    if($profile_image_result['status']) {
                        $profile_image_url = $profile_image_result['url'];
                    }
                }
                
                $owner_info = [
                    'id' => $owner_data['id'],
                    'name' => $owner_data['name'] ?? '',
                    'phone' => $owner_data['phone'] ?? '',
                    'is_phone_verified' => $owner_data['is_phone_verified'] ?? false,
                    'profile_image' => $profile_image_url
                ];
            }
            
            // تفاصيل الإعلان الكاملة
            $ad_details = [
                'id' => $ad['id'],
                'user_id' => $ad['user_id'],
                'title' => $ad['title'] ?? '',
                'description' => $ad['description'] ?? '',
                'type' => $ad['type'] ?? '',
                'offer_type' => $ad['offer_type'] ?? '',
                'city' => $ad['city'] ?? '',
                'price' => $ad['price'],
                'currency' => $ad['currency'] ?? 'YER',
                'area' => $ad['area'],
                'negotiable' => $ad['negotiable'],
                'rooms' => $ad['rooms'] ?? null,
                'living_rooms' => $ad['living_rooms'] ?? null,
                'bathrooms' => $ad['bathrooms'] ?? null,
                'status' => $ad['status'] ?? 'published',
                'created_at' => $ad['created_at'] ?? '',
                'updated_at' => $ad['updated_at'] ?? ''
            ];
            
            return [
                'ad' => $ad_details,
                'owner' => $owner_info,
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
                    'is_owner' => ($current_user_id && $ad['user_id'] == $current_user_id)
                ]
            ];
        }
        
        // 1. جلب معلومات المستخدم الأساسية
        $userQuery = new Models($con, "users");
        $user = $userQuery->getByField('id', $user_id);
        
        if(!$user || empty($user)) {
            $response = [
                'status' => 'error',
                'message' => 'User not found'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
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
        
        // 2. معلومات المستخدم الأساسية
        $user_info = [
            'id' => $user_data['id'],
            'name' => $user_data['name'] ?? '',
            'phone' => $user_data['phone'] ?? '',
            'whatsapp' => $user_data['whatsapp'] ?? '',
            'is_phone_verified' => $user_data['is_phone_verified'] ?? false,
            'date_of_birth' => $user_data['date_of_birth'] ?? '',
            'profile_image' => $profile_image_url,
            'status' => $user_data['status'] ?? 'active',
            'created_at' => $user_data['created_at'] ?? '',
            'updated_at' => $user_data['updated_at'] ?? ''
        ];
        
        // 3. جلب جميع إعلانات المستخدم
        $user_ads = [];
        $adQuery = new Models($con, "ads");
        $ads = $adQuery->getByField('user_id', $user_id);
        
        if($ads && !empty($ads)) {
            foreach($ads as $ad) {
                $ad_details = getAdDetails($con, $ad['id'], $mediaHelper, $user_id);
                if($ad_details) {
                    $user_ads[] = $ad_details;
                }
            }
        }
        
        // 4. جلب الإعلانات التي عمل لها لايك
        $liked_ads = [];
        $likesQuery = new Models($con, "likes");
        $likes = $likesQuery->getByField('user_id', $user_id);
        
        if($likes && !empty($likes)) {
            foreach($likes as $like) {
                $ad_details = getAdDetails($con, $like['ad_id'], $mediaHelper, $user_id);
                if($ad_details) {
                    $liked_ads[] = $ad_details;
                }
            }
        }
        
        // 5. جلب الإعلانات التي حفظها في المفضلة
        $favorite_ads = [];
        $favoritesQuery = new Models($con, "favorites");
        $favorites = $favoritesQuery->getByField('user_id', $user_id);
        
        if($favorites && !empty($favorites)) {
            foreach($favorites as $favorite) {
                $ad_details = getAdDetails($con, $favorite['ad_id'], $mediaHelper, $user_id);
                if($ad_details) {
                    $favorite_ads[] = $ad_details;
                }
            }
        }
        
        // 6. الإحصائيات الإجمالية
        $total_stats = [
            'ads_count' => count($user_ads),
            'liked_ads_count' => count($liked_ads),
            'favorite_ads_count' => count($favorite_ads),
            'total_likes_received' => 0,
            'total_favorites_received' => 0
        ];
        
        // حساب إجمالي اللايكات والفوافريتس المستلمة
        foreach($user_ads as $ad) {
            $total_stats['total_likes_received'] += $ad['statistics']['likes_count'];
            $total_stats['total_favorites_received'] += $ad['statistics']['favorites_count'];
        }
        
        // 7. جلب الإعلانات المميزة للمستخدم
        $featured_ads = array_filter($user_ads, function($ad) {
            return $ad['is_featured'] === true;
        });
        $featured_ads = array_values($featured_ads); // إعادة ترقيم المصفوفة
        
        $response = [
            'status' => 'success',
            'data' => [
                'user' => $user_info,
                'statistics' => $total_stats,
                'featured_ads_count' => count($featured_ads),
                'ads' => [
                    'my_ads' => [
                        'count' => count($user_ads),
                        'ads' => $user_ads
                    ],
                    'liked_ads' => [
                        'count' => count($liked_ads),
                        'ads' => $liked_ads
                    ],
                    'favorite_ads' => [
                        'count' => count($favorite_ads),
                        'ads' => $favorite_ads
                    ]
                ]
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
        'message' => "Request must be GET"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);