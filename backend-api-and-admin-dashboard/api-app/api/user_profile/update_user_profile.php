<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/BodyReader.php";
include "../../helpers/MediaHelper.php";

header("Content-Type: application/json");

$input = readData();
$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'PATCH') {
    if($con === true || is_object($con)) {
        $auth = new TokenAuth($con);
        $query = new Models($con, "users");
        $cleanData = new CleanData($con);
        $mediaHelper = new MediaHelper();

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
        
        // الحصول على بيانات المستخدم الحالية
        $currentUser = $query->getByField('id', $user_id);
        
        if(empty($currentUser)) {
            $response = [
                'status' => 'error',
                'message' => 'User not found'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }

        $currentUser = $currentUser[0];
        
        $updateData = [];
        $errors = [];
        
        // التحقق من الاسم
        if(isset($input['name']) && !empty($input['name'])) {
            $name = $cleanData->clean($input['name']);
            
            if(!preg_match('/^[\p{Arabic}a-zA-Z\s\-]+$/u', $name)) {
                $errors[] = "Name must contain only letters, spaces and hyphens";
            } else {
                $updateData['name'] = $name;
            }
        }
        
        // التحقق من الواتساب
        if(isset($input['whatsapp']) && !empty($input['whatsapp'])) {
            $whatsapp = $cleanData->clean($input['whatsapp']);
            
            // نفس التحقق المستخدم في التسجيل
            if(!preg_match('/^[0-9]{9}$/', $whatsapp)) {
                $errors[] = "WhatsApp number must be 9 numbers";
            } else {
                // التحقق إذا كان الرقم مستخدم من قبل مستخدم آخر
                $checkWhatsApp = $query->getByField('whatsapp', $whatsapp);
                if(!empty($checkWhatsApp) && $checkWhatsApp[0]['id'] != $user_id) {
                    $errors[] = "WhatsApp number already registered with another account";
                } else {
                    $updateData['whatsapp'] = $whatsapp;
                }
            }
        }
        
        // معالجة صورة البروفايل إذا كانت موجودة
        $profile_image_name = null;
        if(isset($input['profile_image']) && !empty($input['profile_image'])) {
            // نفس التحقق المستخدم في التسجيل
            if(!preg_match('/^data:image\/[a-zA-Z]+;base64,/', $input['profile_image'])) {
                $errors[] = "Image must be provided in base64 format with a Data URL prefix (e.g., 'data:image/jpeg;base64,...').";
            } else {
                // حفظ الصورة بنفس طريقة التسجيل
                $parts = explode(";base64,", $input['profile_image']);
                $image_type = explode("data:image/", $parts[0])[1];
                $image_data = base64_decode($parts[1]);
                
                // إنشاء اسم الملف بنفس نمط التسجيل
                $profile_image_name = $user_id . '_' . uniqid() . '.' . $image_type;
                $profile_image_path = "../../storage/user_profiles/" . $profile_image_name;
                
                
                // حفظ الصورة
                if(file_put_contents($profile_image_path, $image_data)) {
                    // حذف الصورة القديمة إذا كانت موجودة
                    if(!empty($currentUser['profile_image'])) {
                        $oldImagePath = "../../storage/user_profiles/" . basename($currentUser['profile_image']);
                        if(file_exists($oldImagePath)) {
                            unlink($oldImagePath);
                        }
                    }
                    
                    $updateData['profile_image'] = $profile_image_name;
                } else {
                    $errors[] = "Failed to save profile image";
                }
            }
        }
        
        // إذا كان هناك أخطاء
        if(!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => implode(" - ", $errors)
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // إذا لم تكن هناك بيانات للتحديث
        if(empty($updateData)) {
            $response = [
                'status' => 'error',
                'message' => 'No data provided for update'
            ];
            echo json_encode($response, JSON_PRETTY_PRINT);
            exit;
        }
        
        // تحديث البيانات في قاعدة البيانات باستخدام mysqli مباشرة
        $setClauses = [];
        foreach($updateData as $field => $value) {
            $escapedValue = mysqli_real_escape_string($con, $value);
            $setClauses[] = "$field = '$escapedValue'";
        }
        
        $sql = "UPDATE users SET " . implode(', ', $setClauses) . " WHERE id = $user_id";
        
        if(mysqli_query($con, $sql)) {
            // الحصول على البيانات المحدثة
            $sql = "SELECT id, name, phone, whatsapp, profile_image FROM users WHERE id = $user_id";
            $result = mysqli_query($con, $sql);
            $updatedUser = mysqli_fetch_assoc($result);
            
            // إعداد الرد
            $responseData = [
                'id' => $updatedUser['id'],
                'name' => $updatedUser['name'],
                'whatsapp' => $updatedUser['whatsapp']
            ];
            
            // إضافة رابط الصورة إذا كانت موجودة
            if(!empty($updatedUser['profile_image'])) {
                // بناء المسار الكامل للصورة
                $profile_image_path = $updatedUser['profile_image'];
                // إذا كان فقط اسم الملف، أضف المسار
                if(strpos($profile_image_path, 'storage/user_profiles') === false && strpos($profile_image_path, '../../storage/user_profiles') === false) {
                    $profile_image_path = "../../storage/user_profiles/" . $profile_image_path;
                }
                
                // الحصول على رابط الصورة
                $profile_image_result = $mediaHelper->getMediaInfo($profile_image_path);
                if($profile_image_result['status']) {
                    $responseData['profile_image'] = $profile_image_result['url'];
                } else {
                    $responseData['profile_image'] = null;
                }
            }
            
            $response = [
                'status' => 'success',
                'message' => 'Profile updated successfully',
                'data' => $responseData
            ];
        } else {
            // إذا فشل التحديث، حذف الصورة الجديدة إذا تم حفظها
            if($profile_image_name && file_exists("../../storage/user_profiles/" . $profile_image_name)) {
                unlink("../../storage/user_profiles/" . $profile_image_name);
            }
            
            $response = [
                'status' => 'error',
                'message' => 'Failed to update profile: ' . mysqli_error($con)
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
        'message' => 'Request method must be PATCH'
    ];
}

echo json_encode($response, JSON_PRETTY_PRINT);