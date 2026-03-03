<?php
class MediaHelper {
    /**
     * Detect the "project base path" prefix when the project is hosted in a subfolder.
     * Examples:
     * - SCRIPT_NAME: /v2/api-app/api/user/register.php  => prefix: /v2
     * - SCRIPT_NAME: /dalal/api-app/api/user/register.php => prefix: /dalal
     * - SCRIPT_NAME: /api-app/api/user/register.php => prefix: (empty string)
     *
     * This helps generate correct root-relative URLs regardless of installation folder.
     */
    private function detectBasePathPrefix() {
        $script = $_SERVER['SCRIPT_NAME'] ?? '';
        if (empty($script)) return '';

        $script = str_replace('\\', '/', $script);

        // Prefer detecting where api-app sits in the URL.
        $pos = strpos($script, '/api-app/');
        if ($pos !== false) {
            $prefix = substr($script, 0, $pos);
            return rtrim($prefix, '/');
        }

        // Fallback: detect admin folder if MediaHelper is used from admin side.
        $pos = strpos($script, '/admin/');
        if ($pos !== false) {
            $prefix = substr($script, 0, $pos);
            return rtrim($prefix, '/');
        }

        return '';
    }
    
    private function isValidBase64($base64String) {
        // Check if string contains ;base64,
        if (strpos($base64String, ';base64,') === false) {
            return false;
        }
        
        // Split the string
        $parts = explode(";base64,", $base64String);
        
        // There should be 2 parts
        if (count($parts) !== 2) {
            return false;
        }
        
        // Check if first part contains data:image/ or data:video/
        if (strpos($parts[0], 'data:image/') !== 0 && strpos($parts[0], 'data:video/') !== 0) {
            return false;
        }
        
        // Check if second part is valid base64
        $base64Data = $parts[1];
        $base64Data = str_replace(' ', '+', $base64Data);
        
        if (!base64_decode($base64Data, true)) {
            return false;
        }
        
        return true;
    }
    
    /**
     * Save base64 image to specified path with validation first
     */
    public function saveBase64Image($base64String, $savePath, $prefix = '') {
        
        // Check if string is valid base64
        if (!$this->isValidBase64($base64String)) {
            return [
                'status' => false,
                'message' => 'Invalid base64 format or not an image/video'
            ];
        }
        
        // Extract data from base64
        $parts = explode(";base64,", $base64String);
        
        // Check if file is an image
        if (strpos($parts[0], 'data:image/') !== 0) {
            return [
                'status' => false,
                'message' => 'File is not an image'
            ];
        }
        
        $image_type = explode("data:image/", $parts[0])[1];
        $image_data = base64_decode($parts[1]);
        
        // Create file name: prefix_uniqid.extension
        $fileName = (!empty($prefix) ? $prefix . '_' : '') . uniqid() . '.' . $image_type;
        
        // Full file path
        $fullPath = $savePath . '/' . $fileName;
        
        // Create directory if it doesn't exist
        if (!is_dir($savePath)) {
            mkdir($savePath, 0755, true);
        }
        
        // Save image
        if (file_put_contents($fullPath, $image_data)) {
            return [
                'status' => true,
                'file_path' => $fullPath,
                'file_name' => $fileName,
                'type' => $image_type
            ];
        } else {
            return [
                'status' => false,
                'message' => 'Failed to save image'
            ];
        }
    }
    
    /**
     * Save base64 video to specified path with validation first
     */
    public function saveBase64Video($base64String, $savePath, $prefix = '') {
        
        // Check if string is valid base64
        if (!$this->isValidBase64($base64String)) {
            return [
                'status' => false,
                'message' => 'Invalid base64 format or not an image/video'
            ];
        }
        
        // Extract data from base64
        $parts = explode(";base64,", $base64String);
        
        // Check if file is a video
        if (strpos($parts[0], 'data:video/') !== 0) {
            return [
                'status' => false,
                'message' => 'File is not a video'
            ];
        }
        
        $video_type = explode("data:video/", $parts[0])[1];
        $video_data = base64_decode($parts[1]);
        
        // Create file name: prefix_uniqid.extension
        $fileName = (!empty($prefix) ? $prefix . '_' : '') . uniqid() . '.' . $video_type;
        
        // Full file path
        $fullPath = $savePath . '/' . $fileName;
        
        // Create directory if it doesn't exist
        if (!is_dir($savePath)) {
            mkdir($savePath, 0755, true);
        }
        
        // Save video
        if (file_put_contents($fullPath, $video_data)) {
            return [
                'status' => true,
                'file_path' => $fullPath,
                'file_name' => $fileName,
                'type' => $video_type
            ];
        } else {
            return [
                'status' => false,
                'message' => 'Failed to save video'
            ];
        }
    }
    
    /**
     * Save any base64 file with validation first
     */
    public function saveBase64File($base64String, $savePath, $prefix = '') {
        
        // Check if string is valid base64
        if (!$this->isValidBase64($base64String)) {
            return [
                'status' => false,
                'message' => 'Invalid base64 format. Must start with data:image/ or data:video/'
            ];
        }
        
        // Extract data from base64
        $parts = explode(";base64,", $base64String);
        
        // Determine file type
        if (strpos($parts[0], 'data:image/') === 0) {
            $file_type = explode("data:image/", $parts[0])[1];
        } elseif (strpos($parts[0], 'data:video/') === 0) {
            $file_type = explode("data:video/", $parts[0])[1];
        } else {
            return [
                'status' => false,
                'message' => 'Unsupported file type. Only images and videos are supported'
            ];
        }
        
        $file_data = base64_decode($parts[1]);
        
        // Create file name: prefix_uniqid.extension
        $fileName = (!empty($prefix) ? $prefix . '_' : '') . uniqid() . '.' . $file_type;
        
        // Full file path
        $fullPath = $savePath . '/' . $fileName;
        
        // Create directory if it doesn't exist
        if (!is_dir($savePath)) {
            mkdir($savePath, 0755, true);
        }
        
        // Save file
        if (file_put_contents($fullPath, $file_data)) {
            return [
                'status' => true,
                'file_path' => $fullPath,
                'file_name' => $fileName,
                'type' => $file_type,
                'media_type' => (strpos($parts[0], 'data:image/') === 0) ? 'image' : 'video'
            ];
        } else {
            return [
                'status' => false,
                'message' => 'Failed to save file'
            ];
        }
    }
    
    /**
     * Validate only if it's valid base64
     */
    public function validateBase64($base64String) {
        return $this->isValidBase64($base64String);
    }



     // Delete media file by file name from a directory
     public function deleteMedia($directory, $fileName) {
        // Clean directory path (remove trailing slash)
        $directory = rtrim($directory, '/\\');
        
        // Create full file path
        $filePath = $directory . '/' . $fileName;
        
        // Check if file exists
        if (!file_exists($filePath)) {
            return [
                'status' => false,
                'message' => 'File does not exist: ' . $fileName
            ];
        }
        
        // Check if it's a file (not a directory)
        if (!is_file($filePath)) {
            return [
                'status' => false,
                'message' => 'Path is not a file: ' . $fileName
            ];
        }
        
        // Attempt to delete the file
        if (unlink($filePath)) {
            return [
                'status' => true,
                'message' => 'File deleted successfully: ' . $fileName,
                'file_name' => $fileName,
                'file_path' => $filePath
            ];
        } else {
            return [
                'status' => false,
                'message' => 'Failed to delete file: ' . $fileName,
                'file_name' => $fileName,
                'file_path' => $filePath
            ];
        }
    }
    
    
    

 /**
     * Convert media file to base64 data URL
     */
    public function convertToBase64($file_path) {
        // Check if file exists
        if (!file_exists($file_path)) {
            return [
                'status' => false,
                'message' => 'File does not exist: ' . $file_path
            ];
        }
        
        // Check if it's a file
        if (!is_file($file_path)) {
            return [
                'status' => false,
                'message' => 'Path is not a file: ' . $file_path
            ];
        }
        
        // Get file info
        $file_info = pathinfo($file_path);
        $file_name = $file_info['basename'];
        $file_extension = strtolower($file_info['extension']);
        
        // Determine MIME type
        $mime_types = [
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
        
        $mime_type = $mime_types[$file_extension] ?? 'application/octet-stream';
        
        // Check if it's image or video
        $media_type = (strpos($mime_type, 'image/') === 0) ? 'image' : 'video';
        
        // Read file content
        $file_content = file_get_contents($file_path);
        
        if ($file_content === false) {
            return [
                'status' => false,
                'message' => 'Failed to read file: ' . $file_path
            ];
        }
        
        // Convert to base64
        $base64_data = base64_encode($file_content);
        
        // Create data URL
        $data_url = 'data:' . $mime_type . ';base64,' . $base64_data;
        
        return [
            'status' => true,
            'file_name' => $file_name,
            'file_path' => $file_path,
            'file_extension' => $file_extension,
            'mime_type' => $mime_type,
            'media_type' => $media_type,
            'base64_data' => $base64_data,
            'data_url' => $data_url,
            'size' => filesize($file_path)
        ];
    }
    
    /**
     * Convert multiple media files to base64
     */
    public function convertMultipleToBase64($files_array) {
        $result = [
            'status' => true,
            'files' => []
        ];
        
        foreach ($files_array as $file) {
            if (isset($file['file_path'])) {
                $conversion = $this->convertToBase64($file['file_path']);
                
                if ($conversion['status']) {
                    // Merge file info with base64 data
                    $file_data = array_merge($file, $conversion);
                    $result['files'][] = $file_data;
                } else {
                    $result['status'] = false;
                    $result['errors'][] = [
                        'file' => $file['file_path'] ?? 'unknown',
                        'message' => $conversion['message']
                    ];
                }
            }
        }
        
        return $result;
    }
    
    /**
     * Get base64 data without full data URL (just the base64 string)
     */
    public function getBase64Data($file_path) {
        $result = $this->convertToBase64($file_path);
        
        if ($result['status']) {
            return [
                'status' => true,
                'base64_data' => $result['base64_data'],
                'mime_type' => $result['mime_type']
            ];
        } else {
            return $result;
        }
    }
    
    /**
     * Generate media URL from file path
     * Returns URL that can be used to access the media file
     */
    public function getMediaUrl($file_path) {
        // Extract filename from path
        $fileName = basename($file_path);
        
        // Determine storage type based on path
        $storageType = 'ad_media'; // default
        if (strpos($file_path, 'user_profiles') !== false || strpos($file_path, 'user_profiles') !== false) {
            $storageType = 'user_profiles';
        } elseif (strpos($file_path, 'admin_uploads') !== false) {
            $storageType = 'admin_uploads';
        } elseif (strpos($file_path, 'ad_media') !== false) {
            $storageType = 'ad_media';
        }
        
        // Build URL (root-relative) with detected base prefix (e.g. /v2, /dalal)
        $basePrefix = $this->detectBasePathPrefix();
        // Assuming API base URL structure: {basePrefix}/api-app/api/media/get_media.php
        $url = $basePrefix . '/api-app/api/media/get_media.php?type=' . urlencode($storageType) . '&file=' . urlencode($fileName);
        
        return [
            'status' => true,
            'url' => $url,
            'file_name' => $fileName,
            'storage_type' => $storageType
        ];
    }
    
    /**
     * Get media info (URL and metadata) without base64 conversion
     * This is more efficient for API responses
     */
    public function getMediaInfo($file_path) {
        // Check if file exists
        if (!file_exists($file_path)) {
            return [
                'status' => false,
                'message' => 'File does not exist: ' . $file_path
            ];
        }
        
        // Check if it's a file
        if (!is_file($file_path)) {
            return [
                'status' => false,
                'message' => 'Path is not a file: ' . $file_path
            ];
        }
        
        // Get file info
        $file_info = pathinfo($file_path);
        $file_name = $file_info['basename'];
        $file_extension = strtolower($file_info['extension']);
        
        // Determine MIME type
        $mime_types = [
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
        
        $mime_type = $mime_types[$file_extension] ?? 'application/octet-stream';
        
        // Check if it's image or video
        $media_type = (strpos($mime_type, 'image/') === 0) ? 'image' : 'video';
        
        // Generate URL
        $urlResult = $this->getMediaUrl($file_path);
        
        return [
            'status' => true,
            'file_name' => $file_name,
            'file_path' => $file_path,
            'file_extension' => $file_extension,
            'mime_type' => $mime_type,
            'media_type' => $media_type,
            'url' => $urlResult['url'],
            'size' => filesize($file_path)
        ];
    }

    /**
     * Delete media file from storage by file name and storage type
     * @param string $fileName - The file name (e.g., "40_693c45ef61296.png")
     * @param string $storageType - Storage type: 'ad_media', 'user_profiles', or 'admin_uploads'
     * @return array - Result with status and message
     */
    public function deleteFileFromStorage($fileName, $storageType = 'ad_media') {
        // Security: prevent directory traversal
        $fileName = basename($fileName);
        if (empty($fileName) || strpos($fileName, '..') !== false) {
            return [
                'status' => false,
                'message' => 'Invalid file name'
            ];
        }

        // Get base directory (project root)
        // MediaHelper is in api-app/helpers/, so we go up 2 levels to get project root
        // __DIR__ = C:\xampp\htdocs\v2\api-app\helpers
        // dirname(__DIR__) = C:\xampp\htdocs\v2\api-app
        // dirname(dirname(__DIR__)) = C:\xampp\htdocs\v2 (project root)
        $baseDir = dirname(dirname(__DIR__));
        
        // Build file path based on storage type
        if ($storageType === 'admin_uploads') {
            // admin_uploads is in v2/admin/storage/admin_uploads/
            $filePath = $baseDir . DIRECTORY_SEPARATOR . 'admin' . DIRECTORY_SEPARATOR . 'storage' . DIRECTORY_SEPARATOR . 'admin_uploads' . DIRECTORY_SEPARATOR . $fileName;
        } else {
            // For ad_media and user_profiles, they are in api-app/storage/
            $filePath = $baseDir . DIRECTORY_SEPARATOR . 'api-app' . DIRECTORY_SEPARATOR . 'storage' . DIRECTORY_SEPARATOR . $storageType . DIRECTORY_SEPARATOR . $fileName;
        }
        
        // Check if file exists
        if (!file_exists($filePath)) {
            // Try alternative path structure in case the file path structure is different
            $altPath = $baseDir . DIRECTORY_SEPARATOR . 'admin' . DIRECTORY_SEPARATOR . 'storage' . DIRECTORY_SEPARATOR . 'admin_uploads' . DIRECTORY_SEPARATOR . $fileName;
            if (file_exists($altPath)) {
                $filePath = $altPath;
            } else {
                return [
                    'status' => false,
                    'message' => 'File does not exist: ' . $fileName . ' (Checked: ' . $filePath . ')'
                ];
            }
        }
        
        // Check if it's a file (not a directory)
        if (!is_file($filePath)) {
            return [
                'status' => false,
                'message' => 'Path is not a file: ' . $fileName
            ];
        }
        
        // Attempt to delete the file
        if (@unlink($filePath)) {
            return [
                'status' => true,
                'message' => 'File deleted successfully: ' . $fileName,
                'file_name' => $fileName,
                'file_path' => $filePath
            ];
        } else {
            return [
                'status' => false,
                'message' => 'Failed to delete file: ' . $fileName . ' (Path: ' . $filePath . ')',
                'file_name' => $fileName,
                'file_path' => $filePath
            ];
        }
    }

    /**
     * Delete media file from storage by file path (automatically detects storage type)
     * Works with relative paths like "../../storage/ad_media/filename.jpg" or absolute paths
     * @param string $filePath - The full file path stored in database (can be relative or absolute)
     * @return array - Result with status and message
     */
    public function deleteFileByPath($filePath) {
        if (empty($filePath)) {
            return [
                'status' => false,
                'message' => 'File path is empty'
            ];
        }
        
        // Extract file name from path (works with both relative and absolute paths)
        $fileName = basename($filePath);
        
        // If file name is empty, return error
        if (empty($fileName)) {
            return [
                'status' => false,
                'message' => 'Could not extract file name from path: ' . $filePath
            ];
        }
        
        // Normalize path for comparison (convert to lowercase for case-insensitive comparison)
        $normalizedPath = strtolower($filePath);
        
        // Determine storage type based on path
        // Check in order: user_profiles, admin_uploads, then default to ad_media
        $storageType = 'ad_media'; // default
        if (strpos($normalizedPath, 'user_profiles') !== false) {
            $storageType = 'user_profiles';
        } elseif (strpos($normalizedPath, 'admin_uploads') !== false) {
            $storageType = 'admin_uploads';
        } elseif (strpos($normalizedPath, 'ad_media') !== false) {
            $storageType = 'ad_media';
        }
        
        // Call deleteFileFromStorage with the extracted file name and detected storage type
        return $this->deleteFileFromStorage($fileName, $storageType);
    }

}
