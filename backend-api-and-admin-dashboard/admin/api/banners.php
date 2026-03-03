<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

require_once '../config/Database.php';
require_once '../config/RBAC.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$db = new Database();
$conn = $db->connect();

function verifyAdmin($conn) {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : null;
    
    if (!$token) {
        $token = isset($_GET['token']) ? $_GET['token'] : null;
    }
    
    if (!$token) {
        return null;
    }
    
    $token = mysqli_real_escape_string($conn, $token);
    $query = "SELECT * FROM admins WHERE token = '$token' AND status = 'active'";
    $result = mysqli_query($conn, $query);
    
    if ($result && mysqli_num_rows($result) > 0) {
        return mysqli_fetch_assoc($result);
    }
    
    return null;
}

$admin = verifyAdmin($conn);
if (!$admin) {
    echo json_encode(['success' => false, 'message' => 'غير مصرح']);
    exit();
}

// التحقق من صلاحية إدارة البانرات
$permissionCheck = RBAC::verifyPermission($admin, 'manage_banners');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get all banners
    $query = "SELECT * FROM banners ORDER BY created_at DESC";
    $result = mysqli_query($conn, $query);
    $banners = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        $banners[] = $row;
    }
    
    echo json_encode(['success' => true, 'data' => $banners]);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Create new banner
    $data = json_decode(file_get_contents('php://input'), true);
    
    $imageUrl = mysqli_real_escape_string($conn, $data['image_url']);
    $linkUrl = isset($data['link_url']) ? mysqli_real_escape_string($conn, $data['link_url']) : null;
    $sponsorName = mysqli_real_escape_string($conn, $data['sponsor_name']);
    $sponsorPhone = mysqli_real_escape_string($conn, $data['sponsor_phone']);
    $cost = floatval($data['cost']);
    $startDate = mysqli_real_escape_string($conn, $data['start_date']);
    $endDate = mysqli_real_escape_string($conn, $data['end_date']);
    $active = isset($data['active']) ? intval($data['active']) : 1;
    
    $query = "INSERT INTO banners (admin_id, image_url, link_url, sponsor_name, sponsor_phone, cost, start_date, end_date, active) 
              VALUES ({$admin['id']}, '$imageUrl', " . ($linkUrl ? "'$linkUrl'" : "NULL") . ", '$sponsorName', '$sponsorPhone', $cost, '$startDate', '$endDate', $active)";
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['success' => true, 'message' => 'تم إضافة البانر بنجاح', 'id' => mysqli_insert_id($conn)]);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل إضافة البانر: ' . mysqli_error($conn)]);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Update banner
    $data = json_decode(file_get_contents('php://input'), true);
    $bannerId = intval($data['id']);
    
    // Get old image URL before update
    $oldImageQuery = "SELECT image_url FROM banners WHERE id = $bannerId";
    $oldImageResult = mysqli_query($conn, $oldImageQuery);
    $oldImageUrl = null;
    if ($oldImageResult && mysqli_num_rows($oldImageResult) > 0) {
        $oldBanner = mysqli_fetch_assoc($oldImageResult);
        $oldImageUrl = $oldBanner['image_url'];
    }
    
    $imageUrl = mysqli_real_escape_string($conn, $data['image_url']);
    $linkUrl = isset($data['link_url']) ? mysqli_real_escape_string($conn, $data['link_url']) : null;
    $sponsorName = mysqli_real_escape_string($conn, $data['sponsor_name']);
    $sponsorPhone = mysqli_real_escape_string($conn, $data['sponsor_phone']);
    $cost = floatval($data['cost']);
    $startDate = mysqli_real_escape_string($conn, $data['start_date']);
    $endDate = mysqli_real_escape_string($conn, $data['end_date']);
    $active = isset($data['active']) ? intval($data['active']) : 1;
    
    $query = "UPDATE banners SET 
              image_url = '$imageUrl',
              link_url = " . ($linkUrl ? "'$linkUrl'" : "NULL") . ",
              sponsor_name = '$sponsorName',
              sponsor_phone = '$sponsorPhone',
              cost = $cost,
              start_date = '$startDate',
              end_date = '$endDate',
              active = $active,
              admin_id = {$admin['id']}
              WHERE id = $bannerId";
    
    if (mysqli_query($conn, $query)) {
        // Delete old image if it's different from new one
        if ($oldImageUrl && $oldImageUrl !== $imageUrl) {
            // Include MediaHelper for file deletion from storage
            require_once __DIR__ . '/../../api-app/helpers/MediaHelper.php';
            $mediaHelper = new MediaHelper();
            
            // Delete old image file from storage using MediaHelper
            $deleteResult = $mediaHelper->deleteFileByPath($oldImageUrl);
            
            // Log if deletion failed (but continue)
            if ($deleteResult['status'] !== true) {
                error_log("Failed to delete old banner image: " . $oldImageUrl . " - " . $deleteResult['message']);
            }
        }
        
        echo json_encode(['success' => true, 'message' => 'تم تحديث البانر بنجاح']);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل تحديث البانر: ' . mysqli_error($conn)]);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Delete banner
    $bannerId = intval($_GET['id']);
    
    // Get image URL before deletion
    $imageQuery = "SELECT image_url FROM banners WHERE id = $bannerId";
    $imageResult = mysqli_query($conn, $imageQuery);
    $imageUrl = null;
    if ($imageResult && mysqli_num_rows($imageResult) > 0) {
        $banner = mysqli_fetch_assoc($imageResult);
        $imageUrl = $banner['image_url'];
    }
    
    $query = "DELETE FROM banners WHERE id = $bannerId";
    
    if (mysqli_query($conn, $query)) {
        // Delete image file from storage
        if ($imageUrl) {
            // Include MediaHelper for file deletion from storage
            require_once __DIR__ . '/../../api-app/helpers/MediaHelper.php';
            $mediaHelper = new MediaHelper();
            
            // Delete image file from storage using MediaHelper
            $deleteResult = $mediaHelper->deleteFileByPath($imageUrl);
            
            // Log if deletion failed (but continue)
            if ($deleteResult['status'] !== true) {
                error_log("Failed to delete banner image: " . $imageUrl . " - " . $deleteResult['message']);
            }
        }
        
        echo json_encode(['success' => true, 'message' => 'تم حذف البانر بنجاح']);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل حذف البانر: ' . mysqli_error($conn)]);
    }
}

$db->close();
?>

