<?php
/**
 * API endpoint to serve media files (images/videos) from storage
 * Usage: /api/media/get_media.php?type=ad_media&file=filename.jpg
 *        /api/media/get_media.php?type=user_profiles&file=filename.jpg
 */

// Get parameters
$type = isset($_GET['type']) ? $_GET['type'] : '';
$file = isset($_GET['file']) ? $_GET['file'] : '';

// Validate parameters
if (empty($type) || empty($file)) {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => 'Missing required parameters: type and file'
    ]);
    exit;
}

// Allowed types
$allowedTypes = ['ad_media', 'user_profiles', 'admin_uploads'];

if (!in_array($type, $allowedTypes)) {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => 'Invalid type. Allowed types: ' . implode(', ', $allowedTypes)
    ]);
    exit;
}

// Security: prevent directory traversal
$file = basename($file);
if (empty($file) || strpos($file, '..') !== false) {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => 'Invalid file name'
    ]);
    exit;
}

// Build file path
$baseDir = dirname(dirname(dirname(__DIR__)));
// admin_uploads is in admin/storage/admin_uploads/, others are in api-app/storage/
if ($type === 'admin_uploads') {
    $filePath = $baseDir . '/admin/storage/admin_uploads/' . $file;
} else {
    $filePath = $baseDir . '/api-app/storage/' . $type . '/' . $file;
}
$filePath = str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $filePath);

// Check if file exists
if (!file_exists($filePath) || !is_file($filePath)) {
    http_response_code(404);
    echo json_encode([
        'status' => 'error',
        'message' => 'File not found'
    ]);
    exit;
}

// Get file info
$fileInfo = pathinfo($filePath);
$extension = strtolower($fileInfo['extension'] ?? '');

// Determine MIME type
$mimeTypes = [
    'jpg' => 'image/jpeg',
    'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'gif' => 'image/gif',
    'webp' => 'image/webp',
    'mp4' => 'video/mp4',
    'avi' => 'video/x-msvideo',
    'mov' => 'video/quicktime',
    'wmv' => 'video/x-ms-wmv',
    'flv' => 'video/x-flv',
    'webm' => 'video/webm'
];

$mimeType = $mimeTypes[$extension] ?? 'application/octet-stream';

// Set headers
header('Content-Type: ' . $mimeType);
header('Content-Length: ' . filesize($filePath));
header('Cache-Control: public, max-age=31536000'); // Cache for 1 year
header('Expires: ' . gmdate('D, d M Y H:i:s', time() + 31536000) . ' GMT');

// Output file
readfile($filePath);
exit;

