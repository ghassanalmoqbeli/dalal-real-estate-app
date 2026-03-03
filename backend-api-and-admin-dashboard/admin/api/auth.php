<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

require_once '../config/Database.php';
require_once '../config/RBAC.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$db = new Database();
$conn = $db->connect();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($data['username']) || !isset($data['password'])) {
        echo json_encode(['success' => false, 'message' => 'اسم المستخدم وكلمة المرور مطلوبان']);
        exit();
    }
    
    $username = mysqli_real_escape_string($conn, $data['username']);
    $password = $data['password'];
    
    $query = "SELECT * FROM admins WHERE username = '$username' AND status = 'active'";
    $result = mysqli_query($conn, $query);
    
    if ($result && mysqli_num_rows($result) > 0) {
        $admin = mysqli_fetch_assoc($result);
        
        if (password_verify($password, $admin['password_hash'])) {
            // Generate JWT token (simplified - in production use proper JWT library)
            $token = bin2hex(random_bytes(32));
            
            // Update token in database
            $updateQuery = "UPDATE admins SET token = '$token' WHERE id = " . $admin['id'];
            mysqli_query($conn, $updateQuery);
            
            // الحصول على معلومات الصلاحيات
            $permissions = RBAC::getPermissionsInfo($admin['role']);
            
            echo json_encode([
                'success' => true,
                'message' => 'تم تسجيل الدخول بنجاح',
                'token' => $token,
                'admin' => [
                    'id' => $admin['id'],
                    'username' => $admin['username'],
                    'role' => $admin['role']
                ],
                'permissions' => $permissions
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'كلمة المرور غير صحيحة']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'اسم المستخدم غير موجود أو الحساب معطل']);
    }
} else if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Verify token
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : null;
    
    if (!$token) {
        $token = isset($_GET['token']) ? $_GET['token'] : null;
    }
    
    if (!$token) {
        echo json_encode(['success' => false, 'message' => 'رمز الوصول مطلوب']);
        exit();
    }
    
    $token = mysqli_real_escape_string($conn, $token);
    $query = "SELECT * FROM admins WHERE token = '$token' AND status = 'active'";
    $result = mysqli_query($conn, $query);
    
    if ($result && mysqli_num_rows($result) > 0) {
        $admin = mysqli_fetch_assoc($result);
        
        // الحصول على معلومات الصلاحيات
        $permissions = RBAC::getPermissionsInfo($admin['role']);
        
        echo json_encode([
            'success' => true,
            'admin' => [
                'id' => $admin['id'],
                'username' => $admin['username'],
                'role' => $admin['role']
            ],
            'permissions' => $permissions
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'رمز الوصول غير صحيح']);
    }
}

$db->close();
?>

