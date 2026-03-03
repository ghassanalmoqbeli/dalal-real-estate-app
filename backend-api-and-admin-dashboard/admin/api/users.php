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

// Verify admin token
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

// التحقق من صلاحية إدارة المستخدمين
$permissionCheck = RBAC::verifyPermission($admin, 'manage_users');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

// Get single user details first to avoid being shadowed by list endpoint
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
    // Get single user details
    $userId = intval($_GET['id']);
    
    // Include MediaHelper for profile image URL
    require_once __DIR__ . '/../../api-app/helpers/MediaHelper.php';
    $mediaHelper = new MediaHelper();
    
    $query = "SELECT u.*, 
              (SELECT COUNT(*) FROM ads WHERE user_id = u.id) as ads_count,
              (SELECT COUNT(*) FROM reports WHERE user_id = u.id) as reports_count
              FROM users u WHERE u.id = $userId";
    $result = mysqli_query($conn, $query);
    
    if ($result && mysqli_num_rows($result) > 0) {
        $user = mysqli_fetch_assoc($result);
        
        // Get profile_image URL if exists - SOLUTION FINALE
        $profile_image_url = null;
        if (!empty($user['profile_image'])) {
            // Extract filename only from stored path
            $filename = basename($user['profile_image']);
            
            // Build absolute file path
            $absolute_path = __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'api-app' . DIRECTORY_SEPARATOR . 'storage' . DIRECTORY_SEPARATOR . 'user_profiles' . DIRECTORY_SEPARATOR . $filename;
            
            // Check if file exists
            if (file_exists($absolute_path) && is_file($absolute_path)) {
                // Build absolute URL with protocol and host
                $protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https' : 'http';
                $host = $_SERVER['HTTP_HOST'];
                $urlResult = $mediaHelper->getMediaUrl('storage/user_profiles/' . $filename);
                $profile_image_url = $protocol . '://' . $host . $urlResult['url'];
            }
        }
        $user['profile_image'] = $profile_image_url;
        
        // Get user ads
        $adsQuery = "SELECT * FROM ads WHERE user_id = $userId ORDER BY created_at DESC";
        $adsResult = mysqli_query($conn, $adsQuery);
        $ads = [];
        while ($ad = mysqli_fetch_assoc($adsResult)) {
            $ads[] = $ad;
        }
        $user['ads'] = $ads;
        
        // Get user reports
        $reportsQuery = "SELECT r.*, a.title as ad_title FROM reports r 
                        LEFT JOIN ads a ON r.ad_id = a.id 
                        WHERE r.user_id = $userId ORDER BY r.created_at DESC";
        $reportsResult = mysqli_query($conn, $reportsQuery);
        $reports = [];
        while ($report = mysqli_fetch_assoc($reportsResult)) {
            $reports[] = $report;
        }
        $user['reports'] = $reports;
        
        echo json_encode(['success' => true, 'data' => $user]);
    } else {
        echo json_encode(['success' => false, 'message' => 'المستخدم غير موجود']);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get users list with filters
    $search = isset($_GET['search']) ? mysqli_real_escape_string($conn, $_GET['search']) : '';
    $status = isset($_GET['status']) ? mysqli_real_escape_string($conn, $_GET['status']) : '';
    $sortBy = isset($_GET['sort_by']) ? mysqli_real_escape_string($conn, $_GET['sort_by']) : 'created_at';
    $sortOrder = isset($_GET['sort_order']) ? mysqli_real_escape_string($conn, $_GET['sort_order']) : 'DESC';
    $page = isset($_GET['page']) ? intval($_GET['page']) : 1;
    $limit = isset($_GET['limit']) ? intval($_GET['limit']) : 20;
    $offset = ($page - 1) * $limit;
    
    $where = [];
    if ($search) {
        // Support search by name, phone, or numeric ID (strip non-digits for ID)
        $searchNumeric = preg_replace('/\D/', '', $search);
        $idCondition = $searchNumeric !== '' ? " OR u.id = " . intval($searchNumeric) : '';
        $where[] = "(name LIKE '%$search%' OR phone LIKE '%$search%'$idCondition)";
    }
    if ($status) {
        if ($status === 'pending_deletion') {
            $where[] = "status = 'pending_deletion'";
        } elseif ($status === 'active') {
            $where[] = "status = 'active'";
        } elseif ($status === 'blocked') {
            $where[] = "status = 'blocked'";
        }
    }
    
    // Show pending deletion requests by default if no status filter
    if (!isset($_GET['status']) && isset($_GET['show_deletion_requests']) && $_GET['show_deletion_requests'] == '1') {
        $where[] = "status = 'pending_deletion'";
    }
    
    $whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';
    
    // Get total count (use same alias to keep whereClause consistent)
    $countQuery = "SELECT COUNT(*) as total FROM users u $whereClause";
    $countResult = mysqli_query($conn, $countQuery);
    $total = mysqli_fetch_assoc($countResult)['total'];
    
    // Get users
    $query = "SELECT u.*, 
              (SELECT COUNT(*) FROM ads WHERE user_id = u.id) as ads_count,
              (SELECT COUNT(*) FROM reports WHERE user_id = u.id) as reports_count
              FROM users u 
              $whereClause 
              ORDER BY $sortBy $sortOrder 
              LIMIT $limit OFFSET $offset";
    
    $result = mysqli_query($conn, $query);
    $users = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        $users[] = $row;
    }
    
    echo json_encode([
        'success' => true,
        'data' => $users,
        'pagination' => [
            'total' => intval($total),
            'page' => $page,
            'limit' => $limit,
            'pages' => ceil($total / $limit)
        ]
    ]);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Block/Unblock/Delete user
    $data = json_decode(file_get_contents('php://input'), true);
    $userId = intval($data['user_id']);
    $action = $data['action']; // block, unblock, delete
    
    if ($action === 'block') {
        $query = "UPDATE users SET status = 'blocked', admin_id = {$admin['id']} WHERE id = $userId";
        if (mysqli_query($conn, $query)) {
            // Send notification
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($userId, {$admin['id']}, 'تم إيقاف حسابك من قبل الإدارة')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تم إيقاف المستخدم بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل إيقاف المستخدم: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'unblock') {
        $query = "UPDATE users SET status = 'active', admin_id = {$admin['id']} WHERE id = $userId";
        if (mysqli_query($conn, $query)) {
            // Send notification
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($userId, {$admin['id']}, 'تم إعادة تفعيل حسابك')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تمت إعادة تفعيل المستخدم بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل إعادة تفعيل المستخدم: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'delete') {
        // Include MediaHelper for file deletion from storage
        require_once __DIR__ . '/../../api-app/helpers/MediaHelper.php';
        $mediaHelper = new MediaHelper();
        
        // Get user data before deletion to delete profile image from storage
        $userDataQuery = "SELECT profile_image FROM users WHERE id = $userId";
        $userDataResult = mysqli_query($conn, $userDataQuery);
        $userData = mysqli_fetch_assoc($userDataResult);
        
        // Delete user profile image from storage (api-app/storage/user_profiles/)
        if ($userData && !empty($userData['profile_image'])) {
            $mediaHelper->deleteFileByPath($userData['profile_image']);
        }
        
        // Delete user related data first
        // Delete user notifications
        $deleteNotifQuery = "DELETE FROM notifications WHERE user_id = $userId";
        mysqli_query($conn, $deleteNotifQuery);
        
        // Delete user reports
        $deleteReportsQuery = "DELETE FROM reports WHERE user_id = $userId";
        mysqli_query($conn, $deleteReportsQuery);
        
        // Delete all user ads and their media files (images and videos)
        $userAdsQuery = "SELECT id FROM ads WHERE user_id = $userId";
        $userAdsResult = mysqli_query($conn, $userAdsQuery);
        while ($ad = mysqli_fetch_assoc($userAdsResult)) {
            $adId = $ad['id'];
            
            // Get all media files (images and videos) for this ad
            $mediaQuery = "SELECT file_path FROM ad_media WHERE ad_id = $adId";
            $mediaResult = mysqli_query($conn, $mediaQuery);
            
            // Delete all physical media files from storage (api-app/storage/ad_media/)
            while ($media = mysqli_fetch_assoc($mediaResult)) {
                if (!empty($media['file_path'])) {
                    // Delete file from storage (works for both images and videos)
                    $mediaHelper->deleteFileByPath($media['file_path']);
                }
            }
            
            // Delete related records for each ad from database
            mysqli_query($conn, "DELETE FROM ad_media WHERE ad_id = $adId");
            mysqli_query($conn, "DELETE FROM featured_ads WHERE ad_id = $adId");
            mysqli_query($conn, "DELETE FROM favorites WHERE ad_id = $adId");
            mysqli_query($conn, "DELETE FROM likes WHERE ad_id = $adId");
        }
        
        // Delete user ads
        $deleteAdsQuery = "DELETE FROM ads WHERE user_id = $userId";
        mysqli_query($conn, $deleteAdsQuery);
        
        // Delete user favorites and likes
        mysqli_query($conn, "DELETE FROM favorites WHERE user_id = $userId");
        mysqli_query($conn, "DELETE FROM likes WHERE user_id = $userId");
        
        // Delete user
        $query = "DELETE FROM users WHERE id = $userId";
        if (mysqli_query($conn, $query)) {
            echo json_encode(['success' => true, 'message' => 'تم حذف المستخدم بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل حذف المستخدم: ' . mysqli_error($conn)]);
        }
    } else if ($action === 'approve_deletion') {
        // Approve user deletion request - actually delete the account
        // Check if user has pending deletion request
        $userCheckQuery = "SELECT status FROM users WHERE id = $userId";
        $userCheckResult = mysqli_query($conn, $userCheckQuery);
        $userData = mysqli_fetch_assoc($userCheckResult);
        
        if (!$userData || $userData['status'] !== 'pending_deletion') {
            echo json_encode(['success' => false, 'message' => 'المستخدم ليس لديه طلب حذف قيد المراجعة']);
            exit();
        }
        
        // Include MediaHelper for file deletion from storage
        require_once __DIR__ . '/../../api-app/helpers/MediaHelper.php';
        $mediaHelper = new MediaHelper();
        
        // Get user data before deletion to delete profile image from storage
        $userDataQuery = "SELECT profile_image FROM users WHERE id = $userId";
        $userDataResult = mysqli_query($conn, $userDataQuery);
        $userData = mysqli_fetch_assoc($userDataResult);
        
        // Delete user profile image from storage (api-app/storage/user_profiles/)
        if ($userData && !empty($userData['profile_image'])) {
            $mediaHelper->deleteFileByPath($userData['profile_image']);
        }
        
        // Delete user related data first
        // Delete user notifications
        $deleteNotifQuery = "DELETE FROM notifications WHERE user_id = $userId";
        mysqli_query($conn, $deleteNotifQuery);
        
        // Delete user reports
        $deleteReportsQuery = "DELETE FROM reports WHERE user_id = $userId";
        mysqli_query($conn, $deleteReportsQuery);
        
        // Delete all user ads and their media files (images and videos)
        $userAdsQuery = "SELECT id FROM ads WHERE user_id = $userId";
        $userAdsResult = mysqli_query($conn, $userAdsQuery);
        while ($ad = mysqli_fetch_assoc($userAdsResult)) {
            $adId = $ad['id'];
            
            // Get all media files (images and videos) for this ad
            $mediaQuery = "SELECT file_path FROM ad_media WHERE ad_id = $adId";
            $mediaResult = mysqli_query($conn, $mediaQuery);
            
            // Delete all physical media files from storage (api-app/storage/ad_media/)
            while ($media = mysqli_fetch_assoc($mediaResult)) {
                if (!empty($media['file_path'])) {
                    // Delete file from storage (works for both images and videos)
                    $mediaHelper->deleteFileByPath($media['file_path']);
                }
            }
            
            // Delete related records for each ad from database
            mysqli_query($conn, "DELETE FROM ad_media WHERE ad_id = $adId");
            mysqli_query($conn, "DELETE FROM featured_ads WHERE ad_id = $adId");
            mysqli_query($conn, "DELETE FROM favorites WHERE ad_id = $adId");
            mysqli_query($conn, "DELETE FROM likes WHERE ad_id = $adId");
        }
        
        // Delete user ads
        $deleteAdsQuery = "DELETE FROM ads WHERE user_id = $userId";
        mysqli_query($conn, $deleteAdsQuery);
        
        // Delete user favorites and likes
        mysqli_query($conn, "DELETE FROM favorites WHERE user_id = $userId");
        mysqli_query($conn, "DELETE FROM likes WHERE user_id = $userId");
        
        // Delete user
        $query = "DELETE FROM users WHERE id = $userId";
        if (mysqli_query($conn, $query)) {
            echo json_encode(['success' => true, 'message' => 'تم الموافقة على حذف الحساب وحذف المستخدم بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل حذف المستخدم: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'reject_deletion') {
        // Reject user deletion request - restore account to active
        $query = "UPDATE users SET status = 'active', admin_id = {$admin['id']} WHERE id = $userId";
        if (mysqli_query($conn, $query)) {
            // Send notification to user
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($userId, {$admin['id']}, 'تم رفض طلب حذف حسابك. حسابك نشط الآن')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تم رفض طلب الحذف وإعادة تفعيل الحساب بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل تحديث الحساب: ' . mysqli_error($conn)]);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'إجراء غير صحيح']);
    }
}

$db->close();
?>

