<?php
class OTPHelper {
    private $con;
    
    public function __construct($database_connection) {
        $this->con = $database_connection;
    }
    
    public function generateCode() {
        return rand(10000, 99999);
    }
    
    private function clean($data) {
        return mysqli_real_escape_string($this->con, $data);
    }
    
    public function saveCode($user_id, $phone, $code) {
        $clean_user_id = $this->clean($user_id);
        $clean_phone = $this->clean($phone);
        $clean_code = $this->clean($code);
        
        // حذف الكود القديم أولاً
        $delete_sql = "DELETE FROM otp_codes WHERE phone = '$clean_phone'";
        mysqli_query($this->con, $delete_sql);
        
        // إدخال الكود الجديد
        $sql = "INSERT INTO otp_codes (user_id, phone, otp_code) 
                VALUES ('$clean_user_id', '$clean_phone', '$clean_code')";
        
        return mysqli_query($this->con, $sql);
    }
    
    public function verifyCode($phone, $code) {
        $clean_phone = $this->clean($phone);
        $clean_code = $this->clean($code);
        
        $this->cleanExpiredCodes();
        
        $sql = "SELECT * FROM otp_codes 
                WHERE phone = '$clean_phone' AND otp_code = '$clean_code' 
                AND created_at > DATE_SUB(NOW(), INTERVAL 5 MINUTE)";
        
        $result = mysqli_query($this->con, $sql);
        
        if(mysqli_num_rows($result) > 0) {
            // حذف الكود بعد الاستخدام
            $delete_sql = "DELETE FROM otp_codes WHERE phone = '$clean_phone' AND otp_code = '$clean_code'";
            mysqli_query($this->con, $delete_sql);
            
            $update_sql = "UPDATE users SET is_phone_verified = TRUE WHERE phone = '$clean_phone'";
            mysqli_query($this->con, $update_sql);
            
            return true;
        }
        
        return false;
    }
    
    public function isVerified($phone) {
        $clean_phone = $this->clean($phone);
        $sql = "SELECT is_phone_verified FROM users WHERE phone = '$clean_phone'";
        $result = mysqli_query($this->con, $sql);
        $row = mysqli_fetch_assoc($result);
        return $row && $row['is_phone_verified'] == 1;
    }
    
    private function cleanExpiredCodes() {
        $sql = "DELETE FROM otp_codes WHERE created_at < DATE_SUB(NOW(), INTERVAL 10 MINUTE)";
        mysqli_query($this->con, $sql);
    }
}
