<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, PUT, OPTIONS');
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

// التحقق من صلاحية إدارة الملف الشخصي
$permissionCheck = RBAC::verifyPermission($admin, 'manage_profile');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get admin profile
    echo json_encode([
        'success' => true,
        'data' => [
            'id' => $admin['id'],
            'username' => $admin['username'],
            'role' => $admin['role']
        ]
    ]);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Update admin profile
    $data = json_decode(file_get_contents('php://input'), true);
    
    $username = mysqli_real_escape_string($conn, $data['username']);
    $currentPassword = isset($data['current_password']) ? $data['current_password'] : null;
    $newPassword = isset($data['new_password']) ? $data['new_password'] : null;
    
    // Check if username already exists (if changed)
    if ($username !== $admin['username']) {
        $checkQuery = "SELECT id FROM admins WHERE username = '$username' AND id != {$admin['id']}";
        $checkResult = mysqli_query($conn, $checkQuery);
        
        if ($checkResult && mysqli_num_rows($checkResult) > 0) {
            echo json_encode(['success' => false, 'message' => 'اسم المستخدم موجود بالفعل']);
            exit();
        }
    }
    
    // If password change is requested
    if ($newPassword) {
        if (!$currentPassword) {
            echo json_encode(['success' => false, 'message' => 'كلمة المرور الحالية مطلوبة']);
            exit();
        }
        
        if (!password_verify($currentPassword, $admin['password_hash'])) {
            echo json_encode(['success' => false, 'message' => 'كلمة المرور الحالية غير صحيحة']);
            exit();
        }
        
        $passwordHash = password_hash($newPassword, PASSWORD_DEFAULT);
        $updateQuery = "UPDATE admins SET username = '$username', password_hash = '$passwordHash' WHERE id = {$admin['id']}";
    } else {
        $updateQuery = "UPDATE admins SET username = '$username' WHERE id = {$admin['id']}";
    }
    
    if (mysqli_query($conn, $updateQuery)) {
        // Generate new token
        $newToken = bin2hex(random_bytes(32));
        $tokenQuery = "UPDATE admins SET token = '$newToken' WHERE id = {$admin['id']}";
        mysqli_query($conn, $tokenQuery);
        
        // Get updated admin data
        $updatedQuery = "SELECT * FROM admins WHERE id = {$admin['id']}";
        $updatedResult = mysqli_query($conn, $updatedQuery);
        $updatedAdmin = mysqli_fetch_assoc($updatedResult);
        
        echo json_encode([
            'success' => true,
            'message' => 'تم تحديث البيانات بنجاح',
            'token' => $newToken,
            'admin' => [
                'id' => $updatedAdmin['id'],
                'username' => $updatedAdmin['username'],
                'role' => $updatedAdmin['role']
            ]
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل تحديث البيانات: ' . mysqli_error($conn)]);
    }
}

$db->close();
?>

