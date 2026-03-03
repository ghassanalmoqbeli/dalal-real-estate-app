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

        if(empty($phone)){
            $response = ['status' => 'error', 'message' => 'Phone is required'];
        } else {
            $errors = [];
            
            if(!preg_match('/^[0-9]{9}$/', $phone)) {
                $errors[] = "Phone number must be 9 numbers";
            }
            
            if(!empty($errors)) {
                $response = [
                    'status' => 'error',
                    'message' => implode(" - ", $errors)
                ];
            } else {
                $phone=mysqli_real_escape_string($con, $phone);
                $sql = "SELECT id FROM users WHERE phone = '$phone'";
                $result = mysqli_query($con, $sql);
                $user = mysqli_fetch_assoc($result);

                if($user){
                    $code = $otp->generateCode();
                    $otp->saveCode($user['id'], $phone, $code);
                
                    $response = ['status' => 'success', 'message' => 'Verification code sent','expires_in' => '5 minutes'];
                } else {
                    $response = ['status' => 'error', 'message' => 'Account not found'];
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








