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

// التحقق من صلاحية إدارة المحتوى الثابت
$permissionCheck = RBAC::verifyPermission($admin, 'manage_static_content');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $page = isset($_GET['page']) ? mysqli_real_escape_string($conn, $_GET['page']) : null;
    
    if ($page) {
        // Get specific page content
        $query = "SELECT * FROM static_content WHERE page = '$page'";
        $result = mysqli_query($conn, $query);
        
        if ($result && mysqli_num_rows($result) > 0) {
            echo json_encode(['success' => true, 'data' => mysqli_fetch_assoc($result)]);
        } else {
            echo json_encode(['success' => false, 'message' => 'الصفحة غير موجودة']);
        }
    } else {
        // Get all pages
        $query = "SELECT * FROM static_content ORDER BY page";
        $result = mysqli_query($conn, $query);
        $pages = [];
        
        while ($row = mysqli_fetch_assoc($result)) {
            $pages[] = $row;
        }
        
        echo json_encode(['success' => true, 'data' => $pages]);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'POST' || $_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Create or update static content
    $data = json_decode(file_get_contents('php://input'), true);
    
    $page = mysqli_real_escape_string($conn, $data['page']);
    $content = mysqli_real_escape_string($conn, $data['content']);
    
    // Check if page exists
    $checkQuery = "SELECT id FROM static_content WHERE page = '$page'";
    $checkResult = mysqli_query($conn, $checkQuery);
    
    if ($checkResult && mysqli_num_rows($checkResult) > 0) {
        // Update existing
        $existing = mysqli_fetch_assoc($checkResult);
        $query = "UPDATE static_content SET content = '$content', admin_id = {$admin['id']} WHERE id = {$existing['id']}";
    } else {
        // Insert new
        $query = "INSERT INTO static_content (admin_id, page, content) VALUES ({$admin['id']}, '$page', '$content')";
    }
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['success' => true, 'message' => 'تم حفظ المحتوى بنجاح']);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل حفظ المحتوى: ' . mysqli_error($conn)]);
    }
}

$db->close();
?>

