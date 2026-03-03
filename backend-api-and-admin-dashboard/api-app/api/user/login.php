<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/OTPHelper.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {
        $auth = new TokenAuth($con);
        $query = new Models($con, "users");
        $otp = new OTPHelper($con);

        $phone = isset($_POST['phone']) ? $_POST['phone'] : '';
        $password = isset($_POST['password']) ? $_POST['password'] : '';

        if(empty($phone) || empty($password)) {
            $response = [
                'status' => 'error',
                'message' => 'All fields are required: phone, password'
            ];
        } else {
            $errors = [];
            
            if(!preg_match('/^[0-9]{9}$/', $phone)) {
                $errors[] = "Phone number must be 9 numbers";
            }
            
            if(strlen($password) < 8) {
                $errors[] = "Password must be minimum 8 characters";
            }
            
            if(!empty($errors)) {
                $response = [
                    'status' => 'error',
                    'message' => implode(" - ", $errors)
                ];
            } else {
                $user = $query->getByField('phone', $phone);
                    
                if($user && !empty($user)) {
                    foreach ($user as $row) {
                        $data = [
                            'user_id' => $row['id'],
                            'password_hash' => $row['password_hash'],
                            'status' => $row['status'],
                            'name' => $row['name'],
                            'phone' => $row['phone'],
                            'whatsapp' => $row['whatsapp'],
                            'profile_image' => $row['profile_image'],
                            'created_at' => $row['created_at'] 
                        ];
                    }

                    if(!password_verify($password, $data['password_hash'])) {
                        $response = [
                            'status' => 'error',
                            'message' => 'Invalid password'
                        ];
                    } else {
                        
                        if($data['status'] === 'blocked') {
                            $response = [
                                'status' => 'error',
                                'message' => 'Your account has been blocked. Please contact support.',
                                'account_blocked' => true
                            ];
                        } else if(!$otp->isVerified($phone)) {
                            $response = [
                                'status' => 'error',
                                'message' => 'Phone not verified. Please verify your phone first.',
                                'need_verification' => true
                            ];
                        } else {
                            $new_token = $auth->generateToken();
                            $auth->updateUserToken($data['user_id'], $new_token);

                            $response = [
                                'status' => 'success',
                                'message' => 'Login successful',
                                'data'=>['token' => $new_token,
                                'user_id' => $data['user_id'],
                                'name' => $data['name'],
                                'phone' => $data['phone'],
                                'whatsapp' => $data['whatsapp'],
                                'profile_image' => $data['profile_image'],
                                'created_at' => $data['created_at'] ]
                                
                            ];
                        }
                    }
                } else {
                    $response = [
                        'status' => 'error',
                        'message' => 'Account not found with this phone number'
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
        'message' => "error in method request must be POST"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);