<?php
class TokenAuth {
    private $con;
    private $table = "users";
    
    public function __construct($database_connection) {
        $this->con = $database_connection;
    }
    
    public function generateToken($length = 32) {
        return bin2hex(random_bytes($length));
    }
    

    public function verifyToken($token) {
        if (empty($token)) {
            return [
                'status' => 'error',
                'message' => 'Token is required'
            ];
        }
        
        $user = $this->getUserByToken($token);
        
        if ($user) {
            return [
                'status' => 'success',
                'user_id' => $user['id'],
                'user_data' => [
                    'name' => $user['name'],
                    'phone' => $user['phone'],
                    'whatsapp' => $user['whatsapp']
                ]
            ];
        } else {
            return [
                'status' => 'error',
                'message' => 'Invalid or expired token'
            ];
        }
    }
    

    public function updateUserToken($user_id, $token) {
        $sql = "UPDATE {$this->table} SET token = ? WHERE id = ?";
        $stmt = $this->con->prepare($sql);
        $stmt->bind_param("si", $token, $user_id);
        
        return $stmt->execute();
    }
    

    private function getUserByToken($token) {
        $sql = "SELECT id, name, phone, whatsapp, token FROM {$this->table} WHERE token = ?";
        $stmt = $this->con->prepare($sql);
        $stmt->bind_param("s", $token);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    

    public function quickVerify($token) {
        if (empty($token)) return false;
        
        $user = $this->getUserByToken($token);
        return $user ? $user['id'] : false;
    }
}
