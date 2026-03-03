<?php
include "../../config/Database.php";
include "../../helpers/OTPHelper.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();

$response = [];

if($_SERVER['REQUEST_METHOD']=='POST'){
    if($con===true || is_object($con)){
        $otp = new OTPHelper($con);

        $phone = $_POST['phone'] ?? '';
        $code = $_POST['code'] ?? '';

        if(empty($phone) || empty($code)){
            $response = ['status' => 'error', 'message' => 'Phone and code are required'];
        } else {
            $errors = [];
            
            if(!preg_match('/^[0-9]{9}$/', $phone)) {
                $errors[] = "Phone number must be 9 numbers";
            }
            
            
            if(!preg_match('/^[0-9]{5}$/', $code)) {
                $errors[] = "Verification code must be 5 numbers";
            }
            
            if(!empty($errors)) {
                $response = [
                    'status' => 'error',
                    'message' => implode(" - ", $errors)
                ];
            } else {
                if($otp->verifyCode($phone, $code)){
                    $response = ['status' => 'success', 'message' => 'Phone verified successfully'];
                } else {
                    $response = ['status' => 'error', 'message' => 'Invalid or expired code'];
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
}

echo json_encode($response, JSON_PRETTY_PRINT);
