<?php
class CleanData {
    private $con;
    
    public function __construct($database_connection) {
        $this->con = $database_connection;
    }
    
    public function clean($data) {
        return mysqli_real_escape_string($this->con, $data);
    }
}
