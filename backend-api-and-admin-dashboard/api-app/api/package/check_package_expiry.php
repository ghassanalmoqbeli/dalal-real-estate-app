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

        // الحصول على ad_id من الباراميترات
        $ad_id = isset($_GET['ad_id']) ? $cleanData->clean($_GET['ad_id']) : '';

        $errors = [];

        // التحقق من ad_id مع Validation مبسط
        if (empty($ad_id)) {
            $errors['ad_id'] = "AD ID is required";
        } elseif (!ctype_digit($ad_id)) {
            $errors['ad_id'] = "AD ID must be a positive integer";
        }

        if (!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $errors
            ];
        } else {
            // التحقق من وجود الإعلان وملكيته
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
                // التحقق من حالة التمييز
                $featuredQuery = new Models($con, "featured_ads");
                $featured = $featuredQuery->get("ad_id = $ad_id ORDER BY end_date DESC LIMIT 1");
                
                if(!$featured || empty($featured)) {
                    $response = [
                        'status' => 'success',
                        'data' => [
                            'ad_id' => $ad_id,
                            'is_featured' => false,
                            'message' => 'This advertisement is not featured',
                            'can_activate' => true
                        ]
                    ];
                } else {
                    $featured = $featured[0];
                    
                    // حساب الأيام المتبقية
                    $end_timestamp = strtotime($featured['end_date']);
                    $current_timestamp = time();
                    $remaining_days = max(0, floor(($end_timestamp - $current_timestamp) / (60 * 60 * 24)));
                    
                    // الحصول على معلومات الباقة
                    $packageQuery = new Models($con, "packages");
                    $package = $packageQuery->getByField('id', $featured['package_id']);
                    
                    $package_name = 'Unknown';
                    $package_duration = 0;
                    
                    if($package && !empty($package)) {
                        $package_name = $package[0]['name'];
                        $package_duration = $package[0]['duration_days'];
                    }
                    
                    $is_active = ($remaining_days > 0);
                    
                    $response = [
                        'status' => 'success',
                        'data' => [
                            'ad_id' => $ad_id,
                            'is_featured' => true,
                            'is_active' => $is_active,
                            'featured_id' => $featured['id'],
                            'package_id' => $featured['package_id'],
                            'package_name' => $package_name,
                            'package_duration' => $package_duration,
                            'start_date' => $featured['start_date'],
                            'end_date' => $featured['end_date'],
                            'remaining_days' => $remaining_days,
                            'can_activate' => !$is_active, // يمكن التفعيل إذا انتهت الباقة
                            'message' => $is_active ? 
                                "Package active with $remaining_days days remaining" : 
                                "Package expired on " . $featured['end_date']
                        ]
                    ];
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
        'message' => "error in method request must be GET"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);