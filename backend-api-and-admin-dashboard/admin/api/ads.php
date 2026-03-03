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

// التحقق من صلاحية إدارة الإعلانات
$permissionCheck = RBAC::verifyPermission($admin, 'manage_ads');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && !isset($_GET['id'])) {
    // Get ads list with filters
    $status = isset($_GET['status']) ? mysqli_real_escape_string($conn, $_GET['status']) : '';
    $type = isset($_GET['type']) ? mysqli_real_escape_string($conn, $_GET['type']) : '';
    $city = isset($_GET['city']) ? mysqli_real_escape_string($conn, $_GET['city']) : '';
    $featured = isset($_GET['featured']) ? intval($_GET['featured']) : -1;
    $search = isset($_GET['search']) ? mysqli_real_escape_string($conn, $_GET['search']) : '';
    $page = isset($_GET['page']) ? intval($_GET['page']) : 1;
    $limit = isset($_GET['limit']) ? intval($_GET['limit']) : 20;
    $offset = ($page - 1) * $limit;
    
    $where = [];
    if ($status) {
        $where[] = "a.status = '$status'";
    }
    if ($type) {
        $where[] = "a.type = '$type'";
    }
    if ($city) {
        $where[] = "a.city = '$city'";
    }
    if ($search) {
        // Check if search is numeric (searching by ID)
        if (is_numeric($search)) {
            $where[] = "(a.id = $search OR a.title LIKE '%$search%' OR a.location_text LIKE '%$search%')";
        } else {
            $where[] = "(a.title LIKE '%$search%' OR a.location_text LIKE '%$search%')";
        }
    }
    
    $whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';
    
    // Handle featured filter
    if ($featured === 1) {
        $whereClause .= ($whereClause ? ' AND ' : 'WHERE ') . "EXISTS (SELECT 1 FROM featured_ads fa WHERE fa.ad_id = a.id AND fa.end_date >= CURDATE())";
    } else if ($featured === 0) {
        $whereClause .= ($whereClause ? ' AND ' : 'WHERE ') . "NOT EXISTS (SELECT 1 FROM featured_ads fa WHERE fa.ad_id = a.id AND fa.end_date >= CURDATE())";
    }
    
    // Get total count
    $countQuery = "SELECT COUNT(*) as total FROM ads a $whereClause";
    $countResult = mysqli_query($conn, $countQuery);
    $total = mysqli_fetch_assoc($countResult)['total'];
    
    // Get ads
    $query = "SELECT a.*, u.name as user_name, u.phone as user_phone,
              (SELECT COUNT(*) FROM ad_media WHERE ad_id = a.id AND type = 'image') as images_count,
              (SELECT COUNT(*) FROM ad_media WHERE ad_id = a.id AND type = 'video') as videos_count,
              CASE WHEN EXISTS (SELECT 1 FROM featured_ads WHERE ad_id = a.id AND end_date >= CURDATE()) THEN 1 ELSE 0 END as is_featured
              FROM ads a
              LEFT JOIN users u ON a.user_id = u.id
              $whereClause
              ORDER BY a.created_at DESC
              LIMIT $limit OFFSET $offset";
    
    $result = mysqli_query($conn, $query);
    $ads = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        // Ensure is_featured is integer
        $row['is_featured'] = intval($row['is_featured']);
        $ads[] = $row;
    }
    
    echo json_encode([
        'success' => true,
        'data' => $ads,
        'pagination' => [
            'total' => intval($total),
            'page' => $page,
            'limit' => $limit,
            'pages' => ceil($total / $limit)
        ]
    ]);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
    // Get single ad details
    $adId = intval($_GET['id']);
    
    $query = "SELECT a.*, u.name as user_name, u.phone as user_phone, u.whatsapp as user_whatsapp
              FROM ads a
              LEFT JOIN users u ON a.user_id = u.id
              WHERE a.id = $adId";
    $result = mysqli_query($conn, $query);
    
    if ($result && mysqli_num_rows($result) > 0) {
        $ad = mysqli_fetch_assoc($result);
        
        // Get media
        $mediaQuery = "SELECT * FROM ad_media WHERE ad_id = $adId ORDER BY type, id";
        $mediaResult = mysqli_query($conn, $mediaQuery);
        $media = [];
        while ($m = mysqli_fetch_assoc($mediaResult)) {
            $media[] = $m;
        }
        $ad['media'] = $media;
        
        // Check if featured
        $featuredQuery = "SELECT fa.*, p.name as package_name 
                         FROM featured_ads fa 
                         LEFT JOIN packages p ON fa.package_id = p.id
                         WHERE fa.ad_id = $adId AND fa.end_date >= CURDATE()";
        $featuredResult = mysqli_query($conn, $featuredQuery);
        if ($featuredResult && mysqli_num_rows($featuredResult) > 0) {
            $ad['featured'] = mysqli_fetch_assoc($featuredResult);
        }
        
        echo json_encode(['success' => true, 'data' => $ad]);
    } else {
        echo json_encode(['success' => false, 'message' => 'الإعلان غير موجود']);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Approve/Reject/Delete ad
    $data = json_decode(file_get_contents('php://input'), true);
    $adId = intval($data['ad_id']);
    $action = $data['action']; // approve, reject, delete
    $rejectReason = isset($data['reject_reason']) ? mysqli_real_escape_string($conn, $data['reject_reason']) : '';
    
    // Get ad owner, title, and current status
    $adQuery = "SELECT user_id, title, status FROM ads WHERE id = $adId";
    $adResult = mysqli_query($conn, $adQuery);
    
    if (!$adResult || mysqli_num_rows($adResult) === 0) {
        echo json_encode(['success' => false, 'message' => 'الإعلان غير موجود']);
        exit();
    }
    
    $ad = mysqli_fetch_assoc($adResult);
    $userId = $ad['user_id'];
    $adTitle = mysqli_real_escape_string($conn, $ad['title']);
    $currentStatus = $ad['status'];
    
    if ($action === 'approve') {
        // Clear reject_reason when approving (whether from pending or rejected status)
        $query = "UPDATE ads SET status = 'published', reject_reason = NULL, admin_id = {$admin['id']} WHERE id = $adId";
        if (mysqli_query($conn, $query)) {
            // Customize notification based on previous status
            if ($currentStatus === 'rejected') {
                $notificationMessage = "تم إعادة قبول إعلانك \"$adTitle\" ونشره بنجاح";
            } else {
                $notificationMessage = "تم قبول إعلانك \"$adTitle\" ونشره بنجاح";
            }
            
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($userId, {$admin['id']}, '$notificationMessage')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تم نشر الإعلان بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل نشر الإعلان: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'reject') {
        if (empty($rejectReason)) {
            echo json_encode(['success' => false, 'message' => 'سبب الرفض مطلوب']);
            exit();
        }
        
        // Allow rejecting ads in any status (pending or published)
        $query = "UPDATE ads SET status = 'rejected', reject_reason = '$rejectReason', admin_id = {$admin['id']} WHERE id = $adId";
        if (mysqli_query($conn, $query)) {
            // Send notification with ad title
            $notificationMessage = "تم رفض إعلانك \"$adTitle\". السبب: $rejectReason";
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($userId, {$admin['id']}, '$notificationMessage')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تم رفض الإعلان']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل رفض الإعلان: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'delete') {
        // Include MediaHelper for file deletion from storage
        require_once __DIR__ . '/../../api-app/helpers/MediaHelper.php';
        $mediaHelper = new MediaHelper();
        
        // Get all media files (images and videos) associated with this ad
        $mediaQuery = "SELECT file_path FROM ad_media WHERE ad_id = $adId";
        $mediaResult = mysqli_query($conn, $mediaQuery);
        
        // Delete all physical media files (images and videos) from storage directory
        while ($media = mysqli_fetch_assoc($mediaResult)) {
            if (!empty($media['file_path'])) {
                // Delete file from storage (api-app/storage/ad_media/)
                // Works for both images (.jpg, .png, etc.) and videos (.mp4, .avi, etc.)
                $deleteResult = $mediaHelper->deleteFileByPath($media['file_path']);
                
                // Log if deletion failed (but continue to delete other files)
                if($deleteResult['status'] !== true) {
                    error_log("Failed to delete file: " . $media['file_path'] . " - " . $deleteResult['message']);
                }
            }
        }
        
        // Delete media records from database after physical files are deleted
        $deleteMediaQuery = "DELETE FROM ad_media WHERE ad_id = $adId";
        mysqli_query($conn, $deleteMediaQuery);
        
        // Delete featured ads
        $deleteFeaturedQuery = "DELETE FROM featured_ads WHERE ad_id = $adId";
        mysqli_query($conn, $deleteFeaturedQuery);
        
        // Delete favorites and likes for this ad
        mysqli_query($conn, "DELETE FROM favorites WHERE ad_id = $adId");
        mysqli_query($conn, "DELETE FROM likes WHERE ad_id = $adId");
        
        // Delete ad
        $query = "DELETE FROM ads WHERE id = $adId";
        if (mysqli_query($conn, $query)) {
            // Send notification with ad title
            $notificationMessage = "تم حذف إعلانك \"$adTitle\" من قبل الإدارة";
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($userId, {$admin['id']}, '$notificationMessage')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تم حذف الإعلان']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل حذف الإعلان: ' . mysqli_error($conn)]);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'إجراء غير صحيح']);
    }
}

$db->close();
?>

