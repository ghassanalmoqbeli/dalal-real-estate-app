<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/BodyReader.php";
include "../../helpers/OTPHelper.php";

header("Content-Type: application/json");

$input = readData();
$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'PUT') {
    if($con === true || is_object($con)) {
        $auth = new TokenAuth($con);
        $cleanData = new CleanData($con);

        // التحقق من التوكن
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
        
        // التحقق من الحقول المطلوبة
        $errors = [];
        
        if(!isset($input['new_phone']) || empty($input['new_phone'])) {
            $errors[] = "New phone number is required";
        }
        
        if(!isset($input['otp_code']) || empty($input['otp_code'])) {
            $errors[] = "OTP code is required";
        }
        
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        $new_phone = $cleanData->clean($input['new_phone']);
        $otp_code = $cleanData->clean($input['otp_code']);
        
        // التحقق من صحة رقم الهاتف
        if(!preg_match('/^[0-9]{9}$/', $new_phone)) {
            $errors[] = "New phone number must be 9 numbers";
        }
        
        // التحقق من صحة كود OTP
        if(!is_numeric($otp_code) || strlen($otp_code) != 5) {
            $errors[] = "OTP code must be 5 digits";
        }
        
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // التحقق من كود OTP مع التأكد من أن user_id متطابق
        $clean_phone = mysqli_real_escape_string($con, $new_phone);
        $clean_code = mysqli_real_escape_string($con, $otp_code);
        $clean_user_id = mysqli_real_escape_string($con, $user_id);
        
        // التحقق من وجود الكود مع user_id الصحيح
        $checkSql = "SELECT * FROM otp_codes 
                    WHERE user_id = '$clean_user_id' 
                    AND phone = '$clean_phone' 
                    AND otp_code = '$clean_code'
                    AND created_at > DATE_SUB(NOW(), INTERVAL 5 MINUTE)";
        
        $result = mysqli_query($con, $checkSql);
        
        if(mysqli_num_rows($result) == 0) {
            // إذا لم يكن هناك كود، نتحقق مما إذا كان منتهي الصلاحية أو غير موجود
            $expiredSql = "SELECT * FROM otp_codes 
                          WHERE user_id = '$clean_user_id' 
                          AND phone = '$clean_phone' 
                          AND otp_code = '$clean_code'
                          AND created_at <= DATE_SUB(NOW(), INTERVAL 5 MINUTE)";
            
            $expiredResult = mysqli_query($con, $expiredSql);
            
            if(mysqli_num_rows($expiredResult) > 0) {
                $response = [
                    'status' => 'error',
                    'message' => 'OTP code has expired. Please request a new code.'
                ];
            } else {
                // تحقق إذا كان هناك كود لهذا المستخدم ولكن برمز أو رقم مختلف
                $wrongCodeSql = "SELECT * FROM otp_codes WHERE user_id = '$clean_user_id'";
                $wrongCodeResult = mysqli_query($con, $wrongCodeSql);
                
                if(mysqli_num_rows($wrongCodeResult) > 0) {
                    $row = mysqli_fetch_assoc($wrongCodeResult);
                    if($row['phone'] != $clean_phone) {
                        $response = [
                            'status' => 'error',
                            'message' => 'This OTP code is for a different phone number.'
                        ];
                    } else {
                        $response = [
                            'status' => 'error',
                            'message' => 'Incorrect OTP code. Please enter the correct code.'
                        ];
                    }
                } else {
                    $response = [
                        'status' => 'error',
                        'message' => 'No OTP code found. Please request a new code.'
                    ];
                }
            }
        } else {
            // الكود صحيح - حذفه وتحديث رقم الهاتف
            $delete_sql = "DELETE FROM otp_codes WHERE user_id = '$clean_user_id' AND phone = '$clean_phone' AND otp_code = '$clean_code'";
            mysqli_query($con, $delete_sql);
            
            // تحديث رقم الهاتف في قاعدة البيانات
            $sql = "UPDATE users SET phone = '$clean_phone' WHERE id = $user_id";
            
            if(mysqli_query($con, $sql)) {
                // تحديث حالة التحقق
                $update_sql = "UPDATE users SET is_phone_verified = TRUE WHERE id = $user_id";
                mysqli_query($con, $update_sql);
                
                // الحصول على البيانات المحدثة
                $userSql = "SELECT id, name, phone, whatsapp FROM users WHERE id = $user_id";
                $userResult = mysqli_query($con, $userSql);
                $userData = mysqli_fetch_assoc($userResult);
                
                $response = [
                    'status' => 'success',
                    'message' => 'Phone number changed successfully',
                    'data' => [
                        'id' => $userData['id'],
                        'name' => $userData['name'],
                        'phone' => $userData['phone'],
                        'whatsapp' => $userData['whatsapp'],
                        'phone_verified' => true,
                        'token_valid' => true,
                        'note' => 'Your current authentication token remains valid'
                    ]
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => 'Failed to update phone number: ' . mysqli_error($con)
                ];
            }
        }
        
    } else {
        $response = [
            'status' => 'error',
            'message' => 'Database connection error: ' . $con
        ];
    }
    
    if(is_object($con)) {
        $con->close();
    }
    
} else {
    $response = [
        'status' => 'error',
        'message' => 'Request method must be PUT'
    ];
}

echo json_encode($response, JSON_PRETTY_PRINT);