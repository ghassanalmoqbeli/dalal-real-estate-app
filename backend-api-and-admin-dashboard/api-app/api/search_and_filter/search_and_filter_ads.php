<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/MediaHelper.php";

header("Content-Type: application/json");

function getBearerTokenFromHeaders(): string {
    $headers = function_exists('getallheaders') ? getallheaders() : [];
    $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';
    if (!$authHeader) return '';
    if (stripos($authHeader, 'Bearer ') === 0) {
        return trim(substr($authHeader, 7));
    }
    return trim($authHeader);
}

/**
 * Accepts:
 * - ?param=value
 * - ?param=a,b,c
 * - ?param[]=a&param[]=b
 */
function parseMultiParam($raw): array {
    if ($raw === null) return [];
    if (is_array($raw)) {
        $values = $raw;
    } else {
        $raw = trim((string)$raw);
        if ($raw === '') return [];
        $values = explode(',', $raw);
    }

    $out = [];
    foreach ($values as $v) {
        $v = trim((string)$v);
        if ($v !== '') $out[] = $v;
    }
    // unique, preserve order
    $out = array_values(array_unique($out));
    return $out;
}

function validateEnumList(array $values, array $allowed, string $paramName, array &$errors): array {
    if (empty($values)) return [];
    $allowedSet = array_fill_keys($allowed, true);
    $valid = [];
    $invalid = [];
    foreach ($values as $v) {
        if (isset($allowedSet[$v])) $valid[] = $v;
        else $invalid[] = $v;
    }
    if (!empty($invalid)) {
        $errors[] = "Invalid value(s) for '$paramName': " . implode(', ', $invalid);
    }
    return $valid;
}

function validateNumber($raw, string $paramName, array &$errors) {
    if ($raw === null || $raw === '') return null;
    if (!is_numeric($raw)) {
        $errors[] = "Invalid number for '$paramName'";
        return null;
    }
    $n = $raw + 0;
    if ($n < 0) {
        $errors[] = "Value for '$paramName' must be >= 0";
        return null;
    }
    return $n;
}

$db = new Database();
$con = $db->connect();
$response = [];

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(['status' => 'error', 'message' => 'Request must be GET'], JSON_PRETTY_PRINT);
    exit;
}

if (!($con === true || is_object($con))) {
    echo json_encode(['status' => 'error', 'message' => $con], JSON_PRETTY_PRINT);
    exit;
}

$auth = new TokenAuth($con);
$cleanData = new CleanData($con);
$mediaHelper = new MediaHelper();

// Optional auth (do NOT fail if missing)
$user_id = null;
$token = getBearerTokenFromHeaders();
if (!empty($token)) {
    $token_result = $auth->verifyToken($token);
    if (($token_result['status'] ?? '') === 'success') {
        $user_id = $token_result['user_id'] ?? null;
    }
}

// --- Allowed values (from dalal_db.sql) ---
$allowed_property_types = ['apartment', 'house', 'land', 'shop'];
$allowed_offer_types = ['rent', 'sale_waqf', 'sale_freehold'];
$allowed_cities = [
    'sanaa','taiz','aden','ibb','dhamar','hodeidah','hadramout','yareem','saada','amran','raymah','mahweet',
    'haggah','lahj','mahrah','shabwa','marib','aljawf','albayda','aldhale','socotra','abian'
];
$allowed_currencies = ['YER', 'SAR', 'USD'];
$allowed_sort_by = ['newest', 'oldest', 'price_asc', 'price_desc'];

// --- Read query params ---
$errors = [];

$search = trim((string)($_GET['q'] ?? $_GET['search'] ?? ''));
$property_type = validateEnumList(parseMultiParam($_GET['property_type'] ?? null), $allowed_property_types, 'property_type', $errors);
$offer_type = validateEnumList(parseMultiParam($_GET['offer_type'] ?? null), $allowed_offer_types, 'offer_type', $errors);

$city_raw = trim((string)($_GET['city'] ?? ''));
$city = '';
if ($city_raw !== '') {
    if (!in_array($city_raw, $allowed_cities, true)) $errors[] = "Invalid value for 'city'";
    else $city = $city_raw;
}

$currency_raw = trim((string)($_GET['currency'] ?? ''));
$currency = '';
if ($currency_raw !== '') {
    if (!in_array($currency_raw, $allowed_currencies, true)) $errors[] = "Invalid value for 'currency'";
    else $currency = $currency_raw;
}

$min_price = validateNumber($_GET['min_price'] ?? null, 'min_price', $errors);
$max_price = validateNumber($_GET['max_price'] ?? null, 'max_price', $errors);
$min_area = validateNumber($_GET['min_area'] ?? null, 'min_area', $errors);
$max_area = validateNumber($_GET['max_area'] ?? null, 'max_area', $errors);

$sort_by = trim((string)($_GET['sort_by'] ?? 'newest'));
if ($sort_by === '') $sort_by = 'newest';
if (!in_array($sort_by, $allowed_sort_by, true)) $errors[] = "Invalid value for 'sort_by'";

$featured_only = trim((string)($_GET['featured_only'] ?? ''));
if ($featured_only !== '' && $featured_only !== '0' && $featured_only !== '1') {
    $errors[] = "Invalid value for 'featured_only' (allowed: 0,1)";
}

if (!empty($errors)) {
    $con->close();
    echo json_encode([
        'status' => 'error',
        'message' => 'Validation error',
        'errors' => $errors
    ], JSON_PRETTY_PRINT);
    exit;
}

// --- Build SQL ---
$conditions = [];
$conditions[] = "ads.status = 'published'";
$conditions[] = "users.status != 'blocked'";

if (!empty($search)) {
    $s = $cleanData->clean($search);
    $like = "%" . $s . "%";
    // $like already escaped via clean(), safe to embed in quoted string
    $conditions[] = "(ads.title LIKE '$like' OR ads.extra_details LIKE '$like' OR ads.location_text LIKE '$like')";
}

if (!empty($property_type)) {
    $escaped = [];
    foreach ($property_type as $v) $escaped[] = "'" . $cleanData->clean($v) . "'";
    $conditions[] = "ads.type IN (" . implode(',', $escaped) . ")";
}

if (!empty($offer_type)) {
    $escaped = [];
    foreach ($offer_type as $v) $escaped[] = "'" . $cleanData->clean($v) . "'";
    $conditions[] = "ads.offer_type IN (" . implode(',', $escaped) . ")";
}

if ($city !== '') {
    $conditions[] = "ads.city = '" . $cleanData->clean($city) . "'";
}

if ($currency !== '') {
    $conditions[] = "ads.currency = '" . $cleanData->clean($currency) . "'";
}

if ($min_price !== null) $conditions[] = "ads.price >= " . (float)$min_price;
if ($max_price !== null) $conditions[] = "ads.price <= " . (float)$max_price;
if ($min_area !== null) $conditions[] = "ads.area >= " . (float)$min_area;
if ($max_area !== null) $conditions[] = "ads.area <= " . (float)$max_area;

$orderBy = "ads.created_at DESC";
if ($sort_by === 'oldest') $orderBy = "ads.created_at ASC";
if ($sort_by === 'price_asc') $orderBy = "ads.price ASC, ads.created_at DESC";
if ($sort_by === 'price_desc') $orderBy = "ads.price DESC, ads.created_at DESC";

// Active featured join (pick the latest active end_date per ad)
$featuredJoin = "
    LEFT JOIN (
        SELECT f1.*
        FROM featured_ads f1
        INNER JOIN (
            SELECT ad_id, MAX(end_date) AS max_end_date
            FROM featured_ads
            WHERE end_date >= CURDATE()
            GROUP BY ad_id
        ) f2 ON f1.ad_id = f2.ad_id AND f1.end_date = f2.max_end_date
    ) fa ON fa.ad_id = ads.id
";

if ($featured_only === '1') {
    $conditions[] = "fa.id IS NOT NULL";
}

$whereSql = implode(" AND ", $conditions);
$sql = "
    SELECT
        ads.*,
        fa.id AS featured_id,
        fa.start_date AS featured_start_date,
        fa.end_date AS featured_end_date
    FROM ads
    INNER JOIN users ON ads.user_id = users.id
    $featuredJoin
    WHERE $whereSql
    ORDER BY $orderBy
";

$result = $con->query($sql);
$ads = [];
if ($result) {
    while ($row = $result->fetch_assoc()) $ads[] = $row;
}

// --- Enrich (same style as list_all_ads.php) ---
$enriched_ads = [];

if ($ads && !empty($ads)) {
    foreach ($ads as $ad) {
        $ad_id = $ad['id'];

        // Get all media with URLs
        $mediaQuery = new Models($con, "ad_media");
        $media = $mediaQuery->getByField('ad_id', $ad_id);

        $all_media = [];
        if ($media && !empty($media)) {
            foreach ($media as $media_item) {
                if (isset($media_item['file_path'])) {
                    $media_info = $mediaHelper->getMediaInfo($media_item['file_path']);
                    if ($media_info['status']) {
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

        // Featured status (from join)
        $is_featured = !empty($ad['featured_id']);
        $featured_info = null;
        if ($is_featured) {
            $remaining_days = max(0, floor((strtotime($ad['featured_end_date']) - time()) / (60 * 60 * 24)));
            $featured_info = [
                'featured_id' => $ad['featured_id'],
                'start_date' => $ad['featured_start_date'],
                'end_date' => $ad['featured_end_date'],
                'remaining_days' => $remaining_days
            ];
        }

        // Check if user liked/favorited
        $user_liked = false;
        $user_favorited = false;
        if ($user_id) {
            $user_like = $likesQuery->get("user_id = $user_id AND ad_id = $ad_id");
            $user_liked = ($user_like && !empty($user_like));

            $user_favorite = $favoritesQuery->get("user_id = $user_id AND ad_id = $ad_id");
            $user_favorited = ($user_favorite && !empty($user_favorite));
        }

        // Get user info
        $userQuery = new Models($con, "users");
        $user = $userQuery->getByField('id', $ad['user_id']);

        $user_info = null;
        if ($user && !empty($user)) {
            $user_data = $user[0];

            $profile_image_url = null;
            if (!empty($user_data['profile_image'])) {
                // Build correct path - profile_image might be stored as filename only or full path
                $profile_image_path = $user_data['profile_image'];
                if(strpos($profile_image_path, 'storage/user_profiles') === false && strpos($profile_image_path, '../../storage/user_profiles') === false) {
                    // If it's just filename, add the path
                    $profile_image_path = "../../storage/user_profiles/" . $profile_image_path;
                }
                
                $profile_image_result = $mediaHelper->getMediaInfo($profile_image_path);
                if ($profile_image_result['status']) $profile_image_url = $profile_image_result['url'];
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

        $ad_full_details = [
            'id' => $ad['id'],
            'user_id' => $ad['user_id'],
            'admin_id' => $ad['admin_id'] ?? null,
            'type' => $ad['type'] ?? '',
            'offer_type' => $ad['offer_type'] ?? '',
            'title' => $ad['title'] ?? '',
            'description' => $ad['description'] ?? '',
            'city' => $ad['city'] ?? '',
            'location_text' => $ad['location_text'] ?? '',
            'google_map_url' => $ad['google_map_url'] ?? null,
            'latitude' => $ad['latitude'] ?? null,
            'longitude' => $ad['longitude'] ?? null,
            'price' => $ad['price'],
            'currency' => $ad['currency'] ?? 'YER',
            'negotiable' => $ad['negotiable'],
            'area' => $ad['area'],
            'extra_details' => $ad['extra_details'] ?? null,
            'rooms' => $ad['rooms'] ?? null,
            'living_rooms' => $ad['living_rooms'] ?? null,
            'bathrooms' => $ad['bathrooms'] ?? null,
            'kitchens' => $ad['kitchens'] ?? null,
            'floors' => $ad['floors'] ?? null,
            'status' => $ad['status'] ?? 'published',
            'reject_reason' => $ad['reject_reason'] ?? null,
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
        'query' => [
            'search' => $search,
            'property_type' => $property_type,
            'offer_type' => $offer_type,
            'city' => $city !== '' ? $city : null,
            'min_price' => $min_price,
            'max_price' => $max_price,
            'currency' => $currency !== '' ? $currency : null,
            'min_area' => $min_area,
            'max_area' => $max_area,
            'sort_by' => $sort_by,
            'featured_only' => ($featured_only === '' ? null : $featured_only)
        ],
        'ads' => $enriched_ads ?: []
    ]
];

$con->close();
echo json_encode($response, JSON_PRETTY_PRINT);


