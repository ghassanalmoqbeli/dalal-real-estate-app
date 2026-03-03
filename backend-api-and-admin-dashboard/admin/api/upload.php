<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

require_once '../config/Database.php';

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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    $file = $_FILES['file'];
    $type = isset($_POST['type']) ? $_POST['type'] : 'banner'; // banner, static
    
    // Validate file
    $allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/jpg'];
    $maxSize = 5 * 1024 * 1024; // 5MB
    
    if (!in_array($file['type'], $allowedTypes)) {
        echo json_encode(['success' => false, 'message' => 'نوع الملف غير مدعوم. يرجى رفع صورة بصيغة JPEG, PNG, أو WEBP']);
        exit();
    }
    
    if ($file['size'] > $maxSize) {
        echo json_encode(['success' => false, 'message' => 'حجم الملف يتجاوز 5 ميجابايت']);
        exit();
    }
    
    // Create upload directory if it doesn't exist
    // المسار من admin/api/ إلى admin/storage/admin_uploads/
    $uploadDir = '../storage/admin_uploads/';
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }
    
    // Generate unique filename
    $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
    $filename = uniqid('banner_', true) . '.' . $extension;
    $filepath = $uploadDir . $filename;
    
    if (move_uploaded_file($file['tmp_name'], $filepath)) {
        $url = 'admin/storage/admin_uploads/' . $filename;
        echo json_encode([
            'success' => true,
            'message' => 'تم رفع الملف بنجاح',
            'url' => $url,
            'filename' => $filename,
            'filepath' => $filepath
        ]);
    } else {
        $error = error_get_last();
        $errorMessage = 'فشل رفع الملف';
        if ($error) {
            $errorMessage .= ': ' . $error['message'];
        }
        // التحقق من صلاحيات المجلد
        if (!is_writable($uploadDir)) {
            $errorMessage .= ' - المجلد غير قابل للكتابة';
        }
        echo json_encode([
            'success' => false, 
            'message' => $errorMessage,
            'debug' => [
                'uploadDir' => $uploadDir,
                'filepath' => $filepath,
                'dirExists' => file_exists($uploadDir),
                'isWritable' => is_writable($uploadDir)
            ]
        ]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'لم يتم رفع ملف']);
}

$db->close();
?>

