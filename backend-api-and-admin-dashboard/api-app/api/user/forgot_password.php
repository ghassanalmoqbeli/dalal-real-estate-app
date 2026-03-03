<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {
        $auth = new TokenAuth($con);
        $query = new Models($con, "users");

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
                $data = [];
                $user = $query->getByField('phone', $phone);
                
                if($user && !empty($user)) {
                    foreach ($user as $row) {
                        $data = [
                            'user_id' => $row['id'],
                            'status' => $row['status'] 
                        ];
                    }

                    
                    if($data['status'] === 'blocked') {
                        $response = [
                            'status' => 'error',
                            'message' => 'Your account has been blocked. You cannot reset your password.',
                            'account_blocked' => true
                        ];
                    } else {
                        $new_token = $auth->generateToken();
                        $auth->updateUserToken($data['user_id'], $new_token);

                        $update_data = [
                            'password_hash' => password_hash($password, PASSWORD_DEFAULT)
                        ];

                        $where_condition = "phone=" . $phone;
                        $updata_status = $query->update($update_data, $where_condition);

                        if($updata_status === true) {
                            $response = [
                                'status' => 'success',
                                'message' => 'Password reset successfully',
                                'token' => $new_token,
                                'user_id' => $data['user_id']
                            ];
                        } else {
                            $response = [
                                'status' => 'error',
                                'message' => 'Problem in updating data: ' . $updata_status,
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