<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS');
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

// التحقق من صلاحية إدارة البلاغات
$permissionCheck = RBAC::verifyPermission($admin, 'manage_reports');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

$adminId = intval($admin['id']);

// GET - List reports or single report
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        // Get single report details
        $reportId = intval($_GET['id']);
        
        $query = "SELECT 
                    r.id as report_id, 
                    r.user_id, 
                    r.ad_id, 
                    r.admin_id, 
                    r.reason, 
                    r.description, 
                    r.status, 
                    r.created_at, 
                    r.updated_at,
                    u.name as reporter_name, 
                    u.phone as reporter_phone,
                    a.id as ad_exists,
                    a.title as ad_title,
                    a.status as ad_status,
                    a.user_id as ad_owner_id,
                    a_owner.name as ad_owner_name, 
                    a_owner.phone as ad_owner_phone
                  FROM reports r
                  LEFT JOIN users u ON r.user_id = u.id
                  LEFT JOIN ads a ON r.ad_id = a.id
                  LEFT JOIN users a_owner ON a.user_id = a_owner.id
                  WHERE r.id = $reportId";
        
        $result = mysqli_query($conn, $query);
        
        if (!$result) {
            echo json_encode(['success' => false, 'message' => 'خطأ في الاستعلام: ' . mysqli_error($conn)]);
            exit();
        }
        
        if (mysqli_num_rows($result) === 0) {
            echo json_encode(['success' => false, 'message' => 'البلاغ غير موجود']);
            exit();
        }
        
        $report = mysqli_fetch_assoc($result);
        
        // Set report ID correctly
        $report['id'] = intval($report['report_id']);
        
        // Check if ad is deleted
        $adDeleted = $report['ad_id'] && !$report['ad_exists'];
        $report['ad_deleted'] = $adDeleted;
        
        // Auto-close if ad deleted and report is open
        if ($adDeleted && $report['status'] === 'open') {
            $closeQuery = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = {$report['id']}";
            mysqli_query($conn, $closeQuery);
            $report['status'] = 'closed';
        }
        
        // Get ad media if ad exists
        $report['ad_media'] = [];
        if ($report['ad_id'] && $report['ad_exists']) {
            $mediaQuery = "SELECT * FROM ad_media WHERE ad_id = {$report['ad_id']} ORDER BY type, id";
            $mediaResult = mysqli_query($conn, $mediaQuery);
            if ($mediaResult) {
                while ($m = mysqli_fetch_assoc($mediaResult)) {
                    $report['ad_media'][] = $m;
                }
            }
        }
        
        echo json_encode(['success' => true, 'data' => $report]);
        
    } else {
        // Get reports list
        $status = isset($_GET['status']) ? mysqli_real_escape_string($conn, $_GET['status']) : '';
        $page = isset($_GET['page']) ? intval($_GET['page']) : 1;
        $limit = isset($_GET['limit']) ? intval($_GET['limit']) : 20;
        $offset = ($page - 1) * $limit;
        
        $where = [];
        if ($status) {
            $where[] = "r.status = '$status'";
        }
        $whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';
        
        // Get total count
        $countQuery = "SELECT COUNT(*) as total FROM reports r $whereClause";
        $countResult = mysqli_query($conn, $countQuery);
        $total = mysqli_fetch_assoc($countResult)['total'];
        
        // Get reports
        $query = "SELECT 
                    r.id, 
                    r.user_id, 
                    r.ad_id, 
                    r.reason, 
                    r.description, 
                    r.status, 
                    r.created_at,
                    u.name as reporter_name, 
                    u.phone as reporter_phone,
                    a.title as ad_title, 
                    a.status as ad_status,
                    a.id as ad_exists,
                    a_owner.name as ad_owner_name, 
                    a_owner.phone as ad_owner_phone
                  FROM reports r
                  LEFT JOIN users u ON r.user_id = u.id
                  LEFT JOIN ads a ON r.ad_id = a.id
                  LEFT JOIN users a_owner ON a.user_id = a_owner.id
                  $whereClause
                  ORDER BY r.created_at DESC
                  LIMIT $limit OFFSET $offset";
        
        $result = mysqli_query($conn, $query);
        $reports = [];
        
        while ($row = mysqli_fetch_assoc($result)) {
            // Ensure id is report id
            $row['id'] = intval($row['id']);
            
            // Check if ad is deleted
            $adDeleted = $row['ad_id'] && !$row['ad_exists'];
            $row['ad_deleted'] = $adDeleted;
            
            // Auto-close if ad deleted and report is open
            if ($adDeleted && $row['status'] === 'open') {
                $reportId = $row['id'];
                $closeQuery = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = $reportId";
                mysqli_query($conn, $closeQuery);
                $row['status'] = 'closed';
            }
            
            $reports[] = $row;
        }
        
        echo json_encode([
            'success' => true,
            'data' => $reports,
            'pagination' => [
                'total' => intval($total),
                'page' => $page,
                'limit' => $limit,
                'pages' => ceil($total / $limit)
            ]
        ]);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Handle report actions
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    if (!$data || !isset($data['report_id']) || !isset($data['action'])) {
        echo json_encode(['success' => false, 'message' => 'بيانات غير صحيحة']);
        exit();
    }
    
    $reportId = intval($data['report_id']);
    $action = mysqli_real_escape_string($conn, $data['action']);
    
    if (!$reportId || !$action) {
        echo json_encode(['success' => false, 'message' => 'معرف البلاغ أو الإجراء غير صحيح']);
        exit();
    }
    
    // Get report details
    $reportQuery = "SELECT r.*, u.id as reporter_id FROM reports r LEFT JOIN users u ON r.user_id = u.id WHERE r.id = $reportId";
    $reportResult = mysqli_query($conn, $reportQuery);
    
    if (!$reportResult || mysqli_num_rows($reportResult) === 0) {
        echo json_encode(['success' => false, 'message' => 'البلاغ غير موجود']);
        exit();
    }
    
    $report = mysqli_fetch_assoc($reportResult);
    $adId = isset($report['ad_id']) ? intval($report['ad_id']) : null;
    $reporterId = isset($report['reporter_id']) ? intval($report['reporter_id']) : null;
    
    // Get ad owner if ad exists
    $adOwnerId = null;
    if ($adId) {
        $adQuery = "SELECT user_id FROM ads WHERE id = $adId";
        $adResult = mysqli_query($conn, $adQuery);
        if ($adResult && mysqli_num_rows($adResult) > 0) {
            $ad = mysqli_fetch_assoc($adResult);
            $adOwnerId = intval($ad['user_id']);
        }
    }
    
    // Handle actions
    if ($action === 'close') {
        $query = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = $reportId";
        if (mysqli_query($conn, $query)) {
            echo json_encode(['success' => true, 'message' => 'تم إغلاق البلاغ بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل إغلاق البلاغ: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'delete_ad') {
        if (!$adId) {
            // Ad already deleted, just close the report
            $query = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = $reportId";
            if (mysqli_query($conn, $query)) {
                echo json_encode(['success' => true, 'message' => 'الإعلان محذوف مسبقاً. تم إغلاق البلاغ']);
            } else {
                echo json_encode(['success' => false, 'message' => 'فشل إغلاق البلاغ: ' . mysqli_error($conn)]);
            }
        } else {
            // Check if ad exists
            $checkAdQuery = "SELECT id FROM ads WHERE id = $adId";
            $checkAdResult = mysqli_query($conn, $checkAdQuery);
            
            if (!$checkAdResult || mysqli_num_rows($checkAdResult) === 0) {
                // Ad already deleted
                $query = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = $reportId";
                mysqli_query($conn, $query);
                echo json_encode(['success' => true, 'message' => 'الإعلان محذوف مسبقاً. تم إغلاق البلاغ']);
            } else {
                // Get ad title before deletion
                $adTitleQuery = "SELECT title FROM ads WHERE id = $adId";
                $adTitleResult = mysqli_query($conn, $adTitleQuery);
                $adTitle = 'إعلانك';
                if ($adTitleResult && mysqli_num_rows($adTitleResult) > 0) {
                    $adData = mysqli_fetch_assoc($adTitleResult);
                    $adTitle = mysqli_real_escape_string($conn, $adData['title']);
                }
                
                // Get and delete ad media files before deleting records
                $mediaQuery = "SELECT file_path FROM ad_media WHERE ad_id = $adId";
                $mediaResult = mysqli_query($conn, $mediaQuery);
                while ($media = mysqli_fetch_assoc($mediaResult)) {
                    if (!empty($media['file_path'])) {
                        $filePath = $media['file_path'];
                        $fileName = basename($filePath);
                        
                        // Try multiple possible paths
                        $possiblePaths = [
                            __DIR__ . '/../storage/ad_media/' . $fileName,
                            __DIR__ . '/../../storage/ad_media/' . $fileName,
                            dirname(__DIR__) . '/storage/ad_media/' . $fileName
                        ];
                        
                        foreach ($possiblePaths as $mediaStoragePath) {
                            if (file_exists($mediaStoragePath)) {
                                @unlink($mediaStoragePath);
                                break;
                            }
                        }
                    }
                }
                
                // Delete ad media records
                mysqli_query($conn, "DELETE FROM ad_media WHERE ad_id = $adId");
                mysqli_query($conn, "DELETE FROM featured_ads WHERE ad_id = $adId");
                mysqli_query($conn, "DELETE FROM favorites WHERE ad_id = $adId");
                
                // Delete the ad
                $deleteAdQuery = "DELETE FROM ads WHERE id = $adId";
                if (mysqli_query($conn, $deleteAdQuery)) {
                    // Close the report
                    $query = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = $reportId";
                    mysqli_query($conn, $query);
                    
                    // Send notification to ad owner with ad title
                    if ($adOwnerId) {
                        $notificationMessage = "تم حذف إعلانك \"$adTitle\" بسبب البلاغ المقدم";
                        $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                                      VALUES ($adOwnerId, $adminId, '$notificationMessage')";
                        mysqli_query($conn, $notifQuery);
                    }
                    
                    echo json_encode(['success' => true, 'message' => 'تم حذف الإعلان وإغلاق البلاغ بنجاح']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'فشل حذف الإعلان: ' . mysqli_error($conn)]);
                }
            }
        }
        
    } else if ($action === 'warn_owner') {
        if (!$adOwnerId) {
            echo json_encode(['success' => false, 'message' => 'الإعلان غير موجود']);
            exit();
        }
        
        // Get ad title
        $adTitleQuery = "SELECT title FROM ads WHERE id = $adId";
        $adTitleResult = mysqli_query($conn, $adTitleQuery);
        $adTitle = 'إعلانك';
        if ($adTitleResult && mysqli_num_rows($adTitleResult) > 0) {
            $adData = mysqli_fetch_assoc($adTitleResult);
            $adTitle = mysqli_real_escape_string($conn, $adData['title']);
        }
        
        $warningMessage = isset($data['warning_message']) && !empty(trim($data['warning_message'])) 
            ? mysqli_real_escape_string($conn, trim($data['warning_message'])) 
            : 'تم توجيه إنذار لك بسبب البلاغ المقدم على إعلانك';
        
        // Add ad title to message if not already included
        if (strpos($warningMessage, $adTitle) === false) {
            $warningMessage = "بخصوص إعلانك \"$adTitle\": $warningMessage";
        }
        
        // Close the report
        $query = "UPDATE reports SET status = 'closed', admin_id = $adminId WHERE id = $reportId";
        if (mysqli_query($conn, $query)) {
            // Send warning notification
            $notifQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                          VALUES ($adOwnerId, $adminId, '$warningMessage')";
            mysqli_query($conn, $notifQuery);
            
            echo json_encode(['success' => true, 'message' => 'تم إرسال إنذار للمعلن وإغلاق البلاغ بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل إغلاق البلاغ: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'delete_report') {
        $query = "DELETE FROM reports WHERE id = $reportId";
        if (mysqli_query($conn, $query)) {
            echo json_encode(['success' => true, 'message' => 'تم حذف البلاغ بنجاح']);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل حذف البلاغ: ' . mysqli_error($conn)]);
        }
        
    } else if ($action === 'update_status') {
        $newStatus = isset($data['status']) ? mysqli_real_escape_string($conn, $data['status']) : '';
        
        if (!in_array($newStatus, ['open', 'closed'])) {
            echo json_encode(['success' => false, 'message' => 'حالة غير صحيحة']);
            exit();
        }
        
        $query = "UPDATE reports SET status = '$newStatus', admin_id = $adminId WHERE id = $reportId";
        if (mysqli_query($conn, $query)) {
            $statusText = $newStatus === 'open' ? 'مفتوح' : 'مغلق';
            echo json_encode(['success' => true, 'message' => "تم تغيير حالة البلاغ إلى: $statusText"]);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل تحديث حالة البلاغ: ' . mysqli_error($conn)]);
        }
        
    } else {
        echo json_encode(['success' => false, 'message' => 'إجراء غير صحيح']);
    }
}

$db->close();
?>
