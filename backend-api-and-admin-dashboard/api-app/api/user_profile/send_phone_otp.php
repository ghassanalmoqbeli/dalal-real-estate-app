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

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {
        $auth = new TokenAuth($con);
        $cleanData = new CleanData($con);
        $otpHelper = new OTPHelper($con);

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
        
        if(!isset($input['current_phone']) || empty($input['current_phone'])) {
            $errors[] = "Current phone number is required";
        }
        
        if(!isset($input['new_phone']) || empty($input['new_phone'])) {
            $errors[] = "New phone number is required";
        }
        
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        $current_phone = $cleanData->clean($input['current_phone']);
        $new_phone = $cleanData->clean($input['new_phone']);
        
        // نفس التحقق المستخدم في التسجيل (9 أرقام بدون +)
        if(!preg_match('/^[0-9]{9}$/', $current_phone)) {
            $errors[] = "Current phone number must be 9 numbers";
        }
        
        if(!preg_match('/^[0-9]{9}$/', $new_phone)) {
            $errors[] = "New phone number must be 9 numbers";
        }
        
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // الحصول على بيانات المستخدم
        $sql = "SELECT phone FROM users WHERE id = $user_id";
        $result = mysqli_query($con, $sql);
        $currentUser = mysqli_fetch_assoc($result);
        
        if(!$currentUser) {
            $response = [
                'status' => 'error',
                'message' => "User not found"
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // التحقق إذا كان الرقم الحالي صحيح
        if($currentUser['phone'] != $current_phone) {
            $response = [
                'status' => 'error',
                'message' => "Current phone number does not match"
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // التحقق إذا كان الرقم الجديد مختلف
        if($current_phone == $new_phone) {
            $response = [
                'status' => 'error',
                'message' => "New phone number must be different from current number"
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // التحقق إذا كان الرقم الجديد مستخدم
        $checkSql = "SELECT id FROM users WHERE phone = '$new_phone' AND id != $user_id";
        $checkResult = mysqli_query($con, $checkSql);
        if(mysqli_num_rows($checkResult) > 0) {
            $response = [
                'status' => 'error',
                'message' => "New phone number already registered with another account"
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // توليد وإرسال كود OTP - مع تخزين user_id في جدول OTP
        $otp_code = $otpHelper->generateCode();
        
        // استخدام الدالة المعدلة لتخزين user_id
        $clean_user_id = mysqli_real_escape_string($con, $user_id);
        $clean_phone = mysqli_real_escape_string($con, $new_phone);
        $clean_code = mysqli_real_escape_string($con, $otp_code);
        
        // حذف الكود القديم أولاً
        $delete_sql = "DELETE FROM otp_codes WHERE user_id = '$clean_user_id' OR phone = '$clean_phone'";
        mysqli_query($con, $delete_sql);
        
        // إدخال الكود الجديد مع user_id
        $sql = "INSERT INTO otp_codes (user_id, phone, otp_code) 
                VALUES ('$clean_user_id', '$clean_phone', '$clean_code')";
        
        $saveResult = mysqli_query($con, $sql);
        
        if($saveResult) {
            $response = [
                'status' => 'success',
                'message' => 'OTP code sent to new phone number',
                'data' => [
                    'otp_sent' => true,
                    'new_phone' => $new_phone,
                    'otp_code' => $otp_code, // لأغراض الاختبار فقط
                    'expires_in' => '5 minutes'
                ]
            ];
        } else {
            $response = [
                'status' => 'error',
                'message' => 'Failed to send OTP code: ' . mysqli_error($con)
            ];
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
        'message' => 'Request method must be POST'
    ];
}

echo json_encode($response, JSON_PRETTY_PRINT);