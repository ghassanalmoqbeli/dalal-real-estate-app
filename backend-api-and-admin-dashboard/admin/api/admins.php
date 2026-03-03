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

// التحقق من صلاحية إدارة الأدمن - super_admin فقط
$permissionCheck = RBAC::verifyPermission($admin, 'manage_admins');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

// GET - الحصول على قائمة الأدمن
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $search = isset($_GET['search']) ? mysqli_real_escape_string($conn, $_GET['search']) : '';
    $status = isset($_GET['status']) ? mysqli_real_escape_string($conn, $_GET['status']) : '';
    $role = isset($_GET['role']) ? mysqli_real_escape_string($conn, $_GET['role']) : '';
    
    $adminId = intval($admin['id']);
    
    $query = "SELECT id, username, role, status, created_at, updated_at FROM admins WHERE id != $adminId";
    
    if (!empty($search)) {
        $query .= " AND username LIKE '%$search%'";
    }
    
    if (!empty($status) && in_array($status, ['active', 'disabled'])) {
        $query .= " AND status = '$status'";
    }
    
    if (!empty($role) && in_array($role, ['super_admin', 'editor', 'moderator'])) {
        $query .= " AND role = '$role'";
    }
    
    $query .= " ORDER BY created_at DESC";
    
    $result = mysqli_query($conn, $query);
    $admins = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        $admins[] = $row;
    }
    
    echo json_encode([
        'success' => true,
        'data' => $admins
    ]);
}

// POST - إضافة أدمن جديد
else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($data['username']) || !isset($data['password']) || !isset($data['role'])) {
        echo json_encode(['success' => false, 'message' => 'جميع الحقول مطلوبة: username, password, role']);
        exit();
    }
    
    $username = mysqli_real_escape_string($conn, $data['username']);
    $password = $data['password'];
    $role = mysqli_real_escape_string($conn, $data['role']);
    $status = isset($data['status']) ? mysqli_real_escape_string($conn, $data['status']) : 'active';
    
    // التحقق من صحة البيانات
    if (!in_array($role, ['super_admin', 'editor', 'moderator'])) {
        echo json_encode(['success' => false, 'message' => 'الدور المحدد غير صحيح']);
        exit();
    }
    
    if (!in_array($status, ['active', 'disabled'])) {
        echo json_encode(['success' => false, 'message' => 'الحالة المحددة غير صحيحة']);
        exit();
    }
    
    if (strlen($password) < 8) {
        echo json_encode(['success' => false, 'message' => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل']);
        exit();
    }
    
    // التحقق من عدم وجود اسم مستخدم مكرر
    $checkQuery = "SELECT id FROM admins WHERE username = '$username'";
    $checkResult = mysqli_query($conn, $checkQuery);
    
    if ($checkResult && mysqli_num_rows($checkResult) > 0) {
        echo json_encode(['success' => false, 'message' => 'اسم المستخدم موجود بالفعل']);
        exit();
    }
    
    // إنشاء hash لكلمة المرور
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    
    // إضافة الأدمن
    $insertQuery = "INSERT INTO admins (username, password_hash, role, status) 
                    VALUES ('$username', '$passwordHash', '$role', '$status')";
    
    if (mysqli_query($conn, $insertQuery)) {
        $newAdminId = mysqli_insert_id($conn);
        
        // الحصول على بيانات الأدمن الجديد
        $getQuery = "SELECT id, username, role, status, created_at, updated_at FROM admins WHERE id = $newAdminId";
        $getResult = mysqli_query($conn, $getQuery);
        $newAdmin = mysqli_fetch_assoc($getResult);
        
        echo json_encode([
            'success' => true,
            'message' => 'تم إضافة الأدمن بنجاح',
            'data' => $newAdmin
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'حدث خطأ أثناء إضافة الأدمن']);
    }
}

// PUT - تحديث أدمن
else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($data['id'])) {
        echo json_encode(['success' => false, 'message' => 'معرف الأدمن مطلوب']);
        exit();
    }
    
    $id = intval($data['id']);
    
    // منع تعديل الأدمن لنفسه (لحماية الحساب من التلاعب)
    // يمكن السماح بذلك إذا أردت، لكن من الأفضل تقييد بعض التغييرات
    
    $updateFields = [];
    
    if (isset($data['username']) && !empty(trim($data['username']))) {
        $username = mysqli_real_escape_string($conn, trim($data['username']));
        
        // التحقق من عدم وجود اسم مستخدم مكرر (باستثناء الأدمن الحالي)
        $checkQuery = "SELECT id FROM admins WHERE username = '$username' AND id != $id";
        $checkResult = mysqli_query($conn, $checkQuery);
        
        if ($checkResult && mysqli_num_rows($checkResult) > 0) {
            echo json_encode(['success' => false, 'message' => 'اسم المستخدم موجود بالفعل']);
            exit();
        }
        
        $updateFields[] = "username = '$username'";
    }
    
    if (isset($data['password']) && !empty($data['password'])) {
        if (strlen($data['password']) < 8) {
            echo json_encode(['success' => false, 'message' => 'كلمة المرور يجب أن تكون 8 أحرف على الأقل']);
            exit();
        }
        $passwordHash = password_hash($data['password'], PASSWORD_DEFAULT);
        $updateFields[] = "password_hash = '$passwordHash'";
    }
    
    if (isset($data['role']) && !empty(trim($data['role']))) {
        $role = mysqli_real_escape_string($conn, trim($data['role']));
        if (!in_array($role, ['super_admin', 'editor', 'moderator'])) {
            echo json_encode(['success' => false, 'message' => 'الدور المحدد غير صحيح']);
            exit();
        }
        $updateFields[] = "role = '$role'";
    }
    
    if (isset($data['status']) && !empty(trim($data['status']))) {
        $status = mysqli_real_escape_string($conn, trim($data['status']));
        if (!in_array($status, ['active', 'disabled'])) {
            echo json_encode(['success' => false, 'message' => 'الحالة المحددة غير صحيحة']);
            exit();
        }
        $updateFields[] = "status = '$status'";
    }
    
    if (empty($updateFields)) {
        echo json_encode(['success' => false, 'message' => 'لا توجد بيانات للتحديث']);
        exit();
    }
    
    $updateQuery = "UPDATE admins SET " . implode(', ', $updateFields) . " WHERE id = $id";
    
    if (mysqli_query($conn, $updateQuery)) {
        // الحصول على بيانات الأدمن المحدث
        $getQuery = "SELECT id, username, role, status, created_at, updated_at FROM admins WHERE id = $id";
        $getResult = mysqli_query($conn, $getQuery);
        $updatedAdmin = mysqli_fetch_assoc($getResult);
        
        echo json_encode([
            'success' => true,
            'message' => 'تم تحديث الأدمن بنجاح',
            'data' => $updatedAdmin
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'حدث خطأ أثناء تحديث الأدمن']);
    }
}

// DELETE - حذف أدمن
else if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($data['id'])) {
        echo json_encode(['success' => false, 'message' => 'معرف الأدمن مطلوب']);
        exit();
    }
    
    $id = intval($data['id']);
    
    // منع حذف نفسه
    if ($id == $admin['id']) {
        echo json_encode(['success' => false, 'message' => 'لا يمكنك حذف حسابك الخاص']);
        exit();
    }
    
    // التحقق من وجود الأدمن
    $checkQuery = "SELECT id FROM admins WHERE id = $id";
    $checkResult = mysqli_query($conn, $checkQuery);
    
    if (!$checkResult || mysqli_num_rows($checkResult) == 0) {
        echo json_encode(['success' => false, 'message' => 'الأدمن غير موجود']);
        exit();
    }
    
    // حذف الأدمن
    $deleteQuery = "DELETE FROM admins WHERE id = $id";
    
    if (mysqli_query($conn, $deleteQuery)) {
        echo json_encode([
            'success' => true,
            'message' => 'تم حذف الأدمن بنجاح'
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'حدث خطأ أثناء حذف الأدمن']);
    }
}

$db->close();
?>

