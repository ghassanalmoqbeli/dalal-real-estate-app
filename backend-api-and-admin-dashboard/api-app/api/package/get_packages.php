<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($con === true || is_object($con)) {

        $query = new Models($con, "packages");
        
        
        $packages = $query->get("1 ORDER BY price ASC");
        
        $response = [
            'status' => 'success',
            'data' => [
                'packages' => $packages ?: []
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