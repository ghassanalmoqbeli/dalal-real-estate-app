<?php

class Database{
    private $hostname="localhost";
    private $username="root";
    private $password="";
    private $database="dalal_db";
    private $database_connection;
 public function connect(){
   mysqli_report(MYSQLI_REPORT_OFF);
   
    $this->database_connection= mysqli_connect(
        $this->hostname,
        $this->username,
        $this->password,
        $this->database
    );

    if(!$this->database_connection){
       return "Connection failed: ".mysqli_connect_error();
    }

    return $this->database_connection;
 }
 public function close(){
    mysqli_close($this->database_connection);
 }



}






