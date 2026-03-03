<?php
/**
 * Media API Index
 */
header("Content-Type: application/json");
echo json_encode([
    'status' => 'success',
    'message' => 'Media API',
    'endpoints' => [
        'get_media' => '/api/media/get_media.php?type={ad_media|user_profiles|admin_uploads}&file={filename}'
    ]
]);






