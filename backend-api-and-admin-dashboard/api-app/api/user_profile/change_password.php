<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/BodyReader.php";

header("Content-Type: application/json");

$input = readData();
$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'PUT') {
    if($con === true || is_object($con)) {
        $auth = new TokenAuth($con);
        $query = new Models($con, "users");
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
        
        if(!isset($input['current_password']) || empty($input['current_password'])) {
            $errors[] = "Current password is required";
        }
        
        if(!isset($input['new_password']) || empty($input['new_password'])) {
            $errors[] = "New password is required";
        }
        
        if(!isset($input['confirm_password']) || empty($input['confirm_password'])) {
            $errors[] = "Confirm password is required";
        }
        
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        $current_password = $cleanData->clean($input['current_password']);
        $new_password = $cleanData->clean($input['new_password']);
        $confirm_password = $cleanData->clean($input['confirm_password']);
        
        // التحقق من صحة كلمات المرور
        if(strlen($new_password) < 8) {
            $errors[] = "New password must be at least 8 characters";
        }
        
        if($new_password !== $confirm_password) {
            $errors[] = "New password and confirm password do not match";
        }
        
        if($current_password === $new_password) {
            $errors[] = "New password must be different from current password";
        }
        
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // الحصول على بيانات المستخدم الحالية
        $user = $query->getByField('id', $user_id);
        
        if(empty($user)) {
            $response = [
                'status' => 'error',
                'message' => 'User not found'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        $user = $user[0];
        
        // التحقق من كلمة المرور الحالية
        if(!password_verify($current_password, $user['password_hash'])) {
            $response = [
                'status' => 'error',
                'message' => 'Current password is incorrect'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // إنشاء hash لكلمة المرور الجديدة
        $new_password_hash = password_hash($new_password, PASSWORD_DEFAULT);
        
        // تحديث كلمة المرور في قاعدة البيانات فقط
        $updateData = ['password_hash' => $new_password_hash];
        $where_condition = "id = " . $user_id;
        
        $updateResult = $query->update($updateData, $where_condition);
        
        if($updateResult === true) {
            $response = [
                'status' => 'success',
                'message' => 'Password changed successfully',
                'data' => [
                    'password_changed' => "true",
                    'token_unchanged' => "true",
                    'note' => 'Your authentication token remains valid'
                ]
            ];
        } else {
            $response = [
                'status' => 'error',
                'message' => 'Failed to update password: ' . $updateResult
            ];
        }
        
    } else {
        $response = [
            'status' => 'error',
            'message' => 'Database connection error: ' . $con
        ];
    }
    $con->close();

    
} else {
    $response = [
        'status' => 'error',
        'message' => 'Request method must be PUT'
    ];
}

echo json_encode($response, JSON_PRETTY_PRINT);