<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/OTPHelper.php";

header("Content-Type: application/json");

$db=new Database();
$con=$db->connect();

$response=[];

if($_SERVER['REQUEST_METHOD']=='POST'){

    if($con===true || is_object($con)){
        $auth=new TokenAuth($con);
        $otp=new OTPHelper($con);

        $name = isset($_POST['name']) ? $_POST['name'] : '';
        $phone = isset($_POST['phone']) ? $_POST['phone'] : '';
        $whatsapp = isset($_POST['whatsapp']) ? $_POST['whatsapp'] : '';
        $password = isset($_POST['password']) ? $_POST['password'] : '';
        $date_of_birth = isset($_POST['date_of_birth']) ? $_POST['date_of_birth'] : '';
        $profile_image = isset($_POST['profile_image']) ? $_POST['profile_image'] : '';

        if(empty($name) || empty($phone) || empty($password) || empty($date_of_birth)){

            $response=[
                'status' => 'error',
                'message' => 'This fields are required: name, phone, password, date of birth'
            ];
        }
        else {
            $errors = [];
            
            if(!preg_match('/^[\p{Arabic}a-zA-Z\s\-]+$/u', $name)) {
             $errors[] = "Name must contain only letters, spaces and hyphens";
            }
            
            if(!preg_match('/^[0-9]{9}$/', $phone)) {
                $errors[] = "Phone number must be 9 numbers";
            }
            
            if(!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date_of_birth)) {
                $errors[] = "Date of birth must be in format YYYY-MM-DD";
            }else {
                    $date_parts = explode('-', $date_of_birth);
                    $year = intval($date_parts[0]);
                    $month = intval($date_parts[1]);
                    $day = intval($date_parts[2]);
    
                    $current_year = date('Y');
    
                    if($year < 1900 || $year > $current_year) {
                        $errors[] = "Year must be between 1900 and $current_year";
                    }
    
                    if(!checkdate($month, $day, $year)) {
                        $errors[] = "Date of birth is not valid";
                    }
                }
            
            if(strlen($password) < 8) {
                $errors[] = "Password must be minimum 8 characters";
            }
            
            if(!empty($whatsapp) && !preg_match('/^[0-9]{9}$/', $whatsapp)) {
                $errors[] = "WhatsApp number must be 9 numbers";
            }
            if(!empty($profile_image) && !preg_match('/^data:image\/[a-zA-Z]+;base64,/', $profile_image)) {
                $errors[] = "Image must be provided in base64 format with a Data URL prefix (e.g., 'data:image/jpeg;base64,...').";
            }
            
            if(!empty($errors)) {
                $response = [
                    'status' => 'error',
                    'message' => implode(" - ", $errors)
                ];
            }
            else {

                $password_hash = password_hash($password, PASSWORD_DEFAULT);
                $token = $auth->generateToken();
                if(empty($whatsapp)) { $whatsapp = $phone;}

                if(empty($profile_image)) { 
                    $sql="INSERT INTO users (name, phone,whatsapp,password_hash,date_of_birth,token) 
                    VALUES ('$name','$phone','$whatsapp','$password_hash','$date_of_birth','$token')";
                    }
                    else{
                        $sql="INSERT INTO users (name, phone,whatsapp,password_hash,date_of_birth,token,profile_image) 
                        VALUES ('$name','$phone','$whatsapp','$password_hash','$date_of_birth','$token','$profile_image')";
                    }
                
                    
                    if(mysqli_query($con,$sql)){
                        $user_id = (string)mysqli_insert_id($con);

                        $code=$otp->generateCode();
                        $otp->saveCode($user_id,$phone,$code);
                        


                        $response = [
                         'status' => 'success',
                          'message' => "Account created successfully. Verification code sent.",
                           'user_id' => $user_id,
                            'token' => $token
                          ];
                          
                        if(!empty($profile_image)) {
                            $parts = explode(";base64,", $profile_image);
                            $image_type = explode("data:image/", $parts[0])[1];
                            $image_data = base64_decode($parts[1]);
    
                            $image_name = $user_id . '_' . uniqid() . '.' . $image_type;
                            file_put_contents("../../storage/user_profiles/" . $image_name, $image_data);
                            $profile_image ="../../storage/user_profiles/".$image_name;
                            $update_sql = "UPDATE users SET profile_image = '$profile_image' WHERE id = $user_id";
                            mysqli_query($con, $update_sql);
                        }
                    }else{
                        if(!empty($image_path) && file_exists($image_path)) {
                        unlink($image_path);
                        }
                        $response = [
                         'status' => 'error',
                         'message' => "Error creating account: " . mysqli_error($con)
                        ];
                    }


            }
        }   
    }
    else{
        $response=[
        'status'=>'error',
        'message'=>$con
        ]; 
    }
    $con->close();
   


    
}
else{
 $response=[
        "status"=>'error',
        'message'=>"error in method request must be POST"
        ]; 

}






echo json_encode($response,JSON_PRETTY_PRINT);










