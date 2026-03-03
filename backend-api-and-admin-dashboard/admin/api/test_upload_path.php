<?php
// ملف اختبار للتحقق من مسارات الرفع
header('Content-Type: application/json; charset=utf-8');

$uploadDir = '../storage/admin_uploads/';

$info = [
    'current_file' => __FILE__,
    'upload_dir_relative' => $uploadDir,
    'upload_dir_absolute' => realpath($uploadDir),
    'dir_exists' => file_exists($uploadDir),
    'is_writable' => is_writable($uploadDir),
    'parent_dir' => dirname(__FILE__),
    'permissions' => file_exists($uploadDir) ? substr(sprintf('%o', fileperms($uploadDir)), -4) : 'N/A'
];

// إنشاء المجلد إذا لم يكن موجوداً
if (!file_exists($uploadDir)) {
    $created = mkdir($uploadDir, 0777, true);
    $info['directory_created'] = $created;
    $info['is_writable_after_creation'] = is_writable($uploadDir);
}

echo json_encode($info, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
?>



