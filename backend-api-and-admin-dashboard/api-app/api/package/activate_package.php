<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $cleanData = new CleanData($con);
        
        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';

        $token_result = $auth->verifyToken($token);

        if($token_result['status'] !== 'success') {
            $response = [
                'status' => 'error',
                'message' => $token_result['message']
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }

        $user_id = $token_result['user_id'];

        $ad_id = isset($_POST['ad_id']) ? $cleanData->clean($_POST['ad_id']) : '';
        $package_id = isset($_POST['package_id']) ? $cleanData->clean($_POST['package_id']) : '';

        $errors = [];

        // Validation for AD ID
        if (empty($ad_id)) {
            $errors['ad_id'] = "AD ID is required";
        } elseif (!ctype_digit($ad_id)) {
            $errors['ad_id'] = "AD ID must be a positive integer";
        }

        // Validation for Package ID
        if (empty($package_id)) {
            $errors['package_id'] = "Package ID is required";
        } elseif (!ctype_digit($package_id)) {
            $errors['package_id'] = "Package ID must be a positive integer";
        }

        if (!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $errors
            ];
        } else {
            // Verify the existence of the advertisement and its ownership by the user
            $adQuery = new Models($con, "ads");
            $ad = $adQuery->getByField('id', $ad_id);
            
            if(!$ad || empty($ad)) {
                $response = [
                    'status' => 'error',
                    'message' => 'Advertisement not found with this ID'
                ];
            } elseif($ad[0]['user_id'] != $user_id) {
                $response = [
                    'status' => 'error',
                    'message' => 'You do not own this advertisement'
                ];
            } else {
                // تحقق من حالة الإعلان (إذا كان نشطاً)
                if(isset($ad[0]['status']) && $ad[0]['status'] != 'published') {
                    $response = [
                        'status' => 'error',
                        'message' => 'Cannot feature an unpublished advertisement'
                    ];
                    echo json_encode($response, JSON_PRETTY_PRINT);
                    exit;
                }
                
                // Check if the package is available
                $packageQuery = new Models($con, "packages");
                $package = $packageQuery->getByField('id', $package_id);
                
                if(!$package || empty($package)) {
                    $response = [
                        'status' => 'error',
                        'message' => 'Package not found with this ID'
                    ];
                } else {
                    $package = $package[0];
                    
                    // Check if the ad is already featured
                    $featuredQuery = new Models($con, "featured_ads");
                    $current_featured = $featuredQuery->get("ad_id = $ad_id AND end_date >= CURDATE()");
                    
                    if($current_featured && !empty($current_featured)) {
                        $current = $current_featured[0];
                        $remaining_days = max(0, floor((strtotime($current['end_date']) - time()) / (60 * 60 * 24)));
                        
                        // الحصول على اسم الباقة الحالية
                        $current_package = $packageQuery->getByField('id', $current['package_id']);
                        $current_package_name = $current_package && !empty($current_package) ? $current_package[0]['name'] : 'Unknown';
                        
                        $response = [
                            'status' => 'error',
                            'message' => 'This advertisement is already featured',
                            'data' => [
                                'remaining_days' => $remaining_days,
                                'current_package_id' => $current['package_id'],
                                'current_package_name' => $current_package_name,
                                'end_date' => $current['end_date']
                            ]
                        ];
                    } else {
                        // Calculate start and end dates
                        $start_date = date('Y-m-d');
                        $end_date = date('Y-m-d', strtotime("+" . $package['duration_days'] . " days"));
                        
                        // Add featured ad
                        $featuredData = [
                            'ad_id' => $ad_id,
                            'package_id' => $package_id,
                            'start_date' => $start_date,
                            'end_date' => $end_date
                        ];
                        
                        $status_query = $featuredQuery->create($featuredData);
                        
                        if($status_query === true){
                            $featured_id = (string)mysqli_insert_id($con);
                            
                            $response = [
                                'status' => 'success',
                                'message' => 'Package activated successfully',
                                'data' => [
                                    'featured_id' => $featured_id,
                                    'ad_id' => $ad_id,
                                    'package_id' => $package_id,
                                    'package_name' => $package['name'],
                                    'start_date' => $start_date,
                                    'end_date' => $end_date,
                                    'duration_days' => $package['duration_days'],
                                    'remaining_days' => $package['duration_days']
                                ]
                            ];
                        } else {
                            $response = [
                                'status' => 'error',
                                'message' => 'Failed to activate package: ' . $status_query
                            ];
                        }
                    }
                }
            }
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
        'message' => "error in method request must be POST"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);