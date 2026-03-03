<?php
include "../../config/Database.php";

header("Content-Type: application/json");

$db=new Database();
$con=$db->connect();

$response=[];

if($_SERVER['REQUEST_METHOD']=='GET'){
    if($con===true || is_object($con)){

        $phone = isset($_GET['phone']) ? mysqli_real_escape_string($con, $_GET['phone']) : '';
        
        if(empty($phone)){
            $response=[
                'status' => 'error',
                'message' => 'Phone is required'
            ];
        }
        else {
            $errors = [];
            
            if(!preg_match('/^[0-9]{9}$/', $phone)) {
                $errors[] = "Phone number must be 9 numbers";
            }
            
            if(!empty($errors)) {
                $response = [
                    'status' => 'error',
                    'message' => implode(" - ", $errors)
                ];
            }
            else {
                
                $sql = "SELECT otp_code FROM otp_codes WHERE phone = '$phone' ORDER BY created_at DESC LIMIT 1";
                $result = mysqli_query($con,$sql);
                
                if(mysqli_num_rows($result) > 0) {
                    $otp_data = mysqli_fetch_assoc($result);
                    $response = [
                        'status' => 'success',
                        'message' => 'OTP code retrieved',
                        'debug_otp' => $otp_data['otp_code'],
                        'expires_in' => '5 minutes',
                        'note' => 'For development only'
                    ];
                }else{
                    $response = [
                        'status' => 'error',
                        'message' => 'No OTP code found for this phone'
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
        'message'=>"error in method request must be GET"
        ]; 

}




echo json_encode($response,JSON_PRETTY_PRINT);
