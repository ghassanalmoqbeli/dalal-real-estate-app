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

function normalize_text($s) {
    if (!is_string($s)) return $s;
    $s = stripslashes($s);
    if (strlen($s) >= 2 && $s[0] === '"' && $s[strlen($s) - 1] === '"') {
        $decoded = json_decode($s, true);
        if (is_string($decoded)) return $decoded;
        $s = trim($s, '"');
    }
    return $s;
}

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
    echo json_encode(['success' => false, 'message' => 'غير مصرح'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit();
}

// التحقق من صلاحية إدارة الإشعارات
$permissionCheck = RBAC::verifyPermission($admin, 'manage_notifications');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get notifications sent by admin
    // Get filter parameters
    $read = isset($_GET['read']) ? $_GET['read'] : null; // 'true', 'false', or null for all
    
    $query = "SELECT n.*, u.name as user_name, u.phone as user_phone 
              FROM notifications n
              LEFT JOIN users u ON n.user_id = u.id
              WHERE n.admin_id = {$admin['id']}";
    
    // Filter by read status
    if ($read === 'true' || $read === '1') {
        $query .= " AND n.is_read = 1";
    } elseif ($read === 'false' || $read === '0') {
        $query .= " AND n.is_read = 0";
    }
    
    $query .= " ORDER BY n.created_at DESC LIMIT 100";
    
    $result = mysqli_query($conn, $query);
    $notifications = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        if (isset($row['message'])) {
            $row['message'] = normalize_text($row['message']);
        }
        $notifications[] = $row;
    }
    
    // Get counts
    $unreadQuery = "SELECT COUNT(*) as count FROM notifications WHERE admin_id = {$admin['id']} AND is_read = 0";
    $unreadResult = mysqli_query($conn, $unreadQuery);
    $unreadCount = 0;
    if ($unreadResult && $row = mysqli_fetch_assoc($unreadResult)) {
        $unreadCount = intval($row['count']);
    }
    
    $totalQuery = "SELECT COUNT(*) as count FROM notifications WHERE admin_id = {$admin['id']}";
    $totalResult = mysqli_query($conn, $totalQuery);
    $totalCount = 0;
    if ($totalResult && $row = mysqli_fetch_assoc($totalResult)) {
        $totalCount = intval($row['count']);
    }
    
    echo json_encode([
        'success' => true, 
        'data' => $notifications,
        'unread_count' => $unreadCount,
        'total_count' => $totalCount
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Send notification
    $data = json_decode(file_get_contents('php://input'), true);
    
    $message = mysqli_real_escape_string($conn, $data['message']);
    $targetType = $data['target_type']; // 'user' or 'all'
    $userId = isset($data['user_id']) ? intval($data['user_id']) : null;
    
    if ($targetType === 'all') {
        // Send to all users
        $usersQuery = "SELECT id FROM users WHERE status = 'active'";
        $usersResult = mysqli_query($conn, $usersQuery);
        
        $sent = 0;
        $failed = 0;
        
        while ($user = mysqli_fetch_assoc($usersResult)) {
            $insertQuery = "INSERT INTO notifications (user_id, admin_id, message) 
                           VALUES ({$user['id']}, {$admin['id']}, '$message')";
            if (mysqli_query($conn, $insertQuery)) {
                $sent++;
            } else {
                $failed++;
            }
        }
        
        echo json_encode([
            'success' => true,
            'message' => "تم إرسال الإشعار لـ $sent مستخدم",
            'sent' => $sent,
            'failed' => $failed
        ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        
    } else if ($targetType === 'user' && $userId) {
        // Send to specific user
        $query = "INSERT INTO notifications (user_id, admin_id, message) 
                  VALUES ($userId, {$admin['id']}, '$message')";
        
        if (mysqli_query($conn, $query)) {
            echo json_encode(['success' => true, 'message' => 'تم إرسال الإشعار بنجاح'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        } else {
            echo json_encode(['success' => false, 'message' => 'فشل إرسال الإشعار: ' . mysqli_error($conn)], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'بيانات غير صحيحة'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Editing notifications is disabled for admins
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'تعديل الإشعارات غير مسموح'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
} else if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Delete notification (admin only)
    $notificationId = null;
    if (isset($_GET['id'])) {
        $notificationId = intval($_GET['id']);
    } else {
        $data = json_decode(file_get_contents('php://input'), true);
        if (isset($data['notification_id'])) {
            $notificationId = intval($data['notification_id']);
        }
    }

    if (!$notificationId || $notificationId <= 0) {
        echo json_encode(['success' => false, 'message' => 'معرف الإشعار مطلوب'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        exit();
    }

    $checkQuery = "SELECT id FROM notifications WHERE id = $notificationId AND admin_id = {$admin['id']}";
    $checkResult = mysqli_query($conn, $checkQuery);
    if (!$checkResult || mysqli_num_rows($checkResult) === 0) {
        echo json_encode(['success' => false, 'message' => 'الإشعار غير موجود أو لا يمكن الوصول إليه'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        exit();
    }

    $deleteQuery = "DELETE FROM notifications WHERE id = $notificationId AND admin_id = {$admin['id']}";
    if (mysqli_query($conn, $deleteQuery)) {
        echo json_encode(['success' => true, 'message' => 'تم حذف الإشعار بنجاح'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل حذف الإشعار: ' . mysqli_error($conn)], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
}

$db->close();
?>

