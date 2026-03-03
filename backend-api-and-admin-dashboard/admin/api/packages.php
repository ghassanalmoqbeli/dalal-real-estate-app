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

// التحقق من صلاحية إدارة الباقات
$permissionCheck = RBAC::verifyPermission($admin, 'manage_packages');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get all packages
    $query = "SELECT * FROM packages ORDER BY duration_days ASC";
    $result = mysqli_query($conn, $query);
    $packages = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        $packages[] = $row;
    }
    
    echo json_encode(['success' => true, 'data' => $packages]);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Create new package
    $data = json_decode(file_get_contents('php://input'), true);
    
    $name = mysqli_real_escape_string($conn, $data['name']);
    $durationDays = intval($data['duration_days']);
    $price = intval($data['price']);
    
    // Check if name already exists
    $checkQuery = "SELECT id FROM packages WHERE name = '$name'";
    $checkResult = mysqli_query($conn, $checkQuery);
    
    if ($checkResult && mysqli_num_rows($checkResult) > 0) {
        echo json_encode(['success' => false, 'message' => 'اسم الباقة موجود بالفعل']);
        exit();
    }
    
    $query = "INSERT INTO packages (admin_id, name, duration_days, price) 
              VALUES ({$admin['id']}, '$name', $durationDays, $price)";
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['success' => true, 'message' => 'تم إضافة الباقة بنجاح', 'id' => mysqli_insert_id($conn)]);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل إضافة الباقة: ' . mysqli_error($conn)]);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Update package
    $data = json_decode(file_get_contents('php://input'), true);
    $packageId = intval($data['id']);
    
    $name = mysqli_real_escape_string($conn, $data['name']);
    $durationDays = intval($data['duration_days']);
    $price = intval($data['price']);
    
    // Check if name already exists for another package
    $checkQuery = "SELECT id FROM packages WHERE name = '$name' AND id != $packageId";
    $checkResult = mysqli_query($conn, $checkQuery);
    
    if ($checkResult && mysqli_num_rows($checkResult) > 0) {
        echo json_encode(['success' => false, 'message' => 'اسم الباقة موجود بالفعل']);
        exit();
    }
    
    $query = "UPDATE packages SET 
              name = '$name',
              duration_days = $durationDays,
              price = $price,
              admin_id = {$admin['id']}
              WHERE id = $packageId";
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['success' => true, 'message' => 'تم تحديث الباقة بنجاح']);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل تحديث الباقة: ' . mysqli_error($conn)]);
    }
    
} else if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Delete package
    $packageId = intval($_GET['id']);
    
    // Check if package is in use
    $checkQuery = "SELECT COUNT(*) as count FROM featured_ads WHERE package_id = $packageId";
    $checkResult = mysqli_query($conn, $checkQuery);
    $count = mysqli_fetch_assoc($checkResult)['count'];
    
    if ($count > 0) {
        echo json_encode(['success' => false, 'message' => 'لا يمكن حذف الباقة لأنها مستخدمة في إعلانات مميزة']);
        exit();
    }
    
    $query = "DELETE FROM packages WHERE id = $packageId";
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['success' => true, 'message' => 'تم حذف الباقة بنجاح']);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل حذف الباقة: ' . mysqli_error($conn)]);
    }
}

$db->close();
?>

