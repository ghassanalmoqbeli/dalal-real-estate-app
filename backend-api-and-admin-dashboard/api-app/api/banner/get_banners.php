<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/CleanData.php";
include "../../helpers/MediaHelper.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($con === true || is_object($con)) {
        $cleanData = new CleanData($con);
        $mediaHelper = new MediaHelper();
        
        // Get current date
        $currentDate = date('Y-m-d');
        
        $query = new Models($con, "banners");
        
        // Get only active banners that are within their date range
        // active = 1 AND start_date <= current_date AND end_date >= current_date
        $whereCondition = "active = 1 ORDER BY created_at DESC";
        
        $banners = $query->get($whereCondition);
        
        // Process banners to generate image URLs using MediaHelper
        if($banners && count($banners) > 0) {
            foreach($banners as &$banner) {
                if(!empty($banner['image_url'])) {
                    // Image URLs are stored as: admin/storage/admin_uploads/filename.jpg or storage/admin_uploads/filename.jpg
                    $imageUrl = $banner['image_url'];
                    
                    // Normalize path - remove '../' prefix if exists
                    if(strpos($imageUrl, '../') === 0) {
                        $imageUrl = substr($imageUrl, 3);
                    }
                    
                    // Extract filename from path (e.g., "banner_67835e4f89abc.jpg")
                    $fileName = basename($imageUrl);
                    
                    // Use MediaHelper to generate URL
                    // The URL will be: /api-app/api/media/get_media.php?type=admin_uploads&file=filename.jpg
                    // MediaHelper will detect admin_uploads from the path
                    $urlResult = $mediaHelper->getMediaUrl('admin/storage/admin_uploads/' . $fileName);
                    if($urlResult['status']) {
                        $banner['image_url'] = $urlResult['url'];
                    } else {
                        // Fallback: if MediaHelper fails, set to null
                        $banner['image_url'] = null;
                    }
                }
            }
        }
        
        $response = [
            'status' => 'success',
            'data' => [
                'banners' => $banners ?: []
            ]
        ];
    
    } else {
        $response = [
            'status' => 'error',
            'message' => $con
        ]; 
    }
    $con->close();

} else {
    $response = [
        "status" => 'error',
        'message' => "error in method request must be GET"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);

