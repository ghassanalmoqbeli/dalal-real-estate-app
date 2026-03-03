<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($con === true || is_object($con)) {
        $cleanData = new CleanData($con);
        
        // Check if specific page is requested
        $page = isset($_GET['page']) ? $cleanData->clean($_GET['page']) : null;
        
        $query = new Models($con, "static_content");
        
        if($page) {
            // Get specific page
            $pages = $query->get("page = '$page'");
            
            if($pages && count($pages) > 0) {
                $response = [
                    'status' => 'success',
                    'data' => [
                        'page' => $pages[0]
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => 'Page not found'
                ];
            }
        } else {
            // Get all pages
            $pages = $query->get("1 ORDER BY page ASC");
            
            $response = [
                'status' => 'success',
                'data' => [
                    'pages' => $pages ?: []
                ]
            ];
        }
    
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






