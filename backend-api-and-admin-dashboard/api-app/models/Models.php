 <?php

class Models{

    protected $con;
    protected $table;
    
    public function  __construct($con,$table){
        $this->con=$con;
        $this->table=$table;

    }
    public function create($data) {
        $escaped_data = [];
        foreach($data as $key => $value) {
            $escaped_data[$key] = mysqli_real_escape_string($this->con, $value);
        }

        $columns = implode(', ', array_keys($escaped_data));
        $values = "'" . implode("', '", array_values($escaped_data)) . "'";
        $sql="INSERT INTO {$this->table} ($columns) VALUES ($values)";
        
        if(mysqli_query($this->con,$sql)){
            return true;
        }else{
            return mysqli_error($this->con);
        }

    }

    public function update($data, $where_condition) {
        $escaped_data = [];
        foreach($data as $key => $value) {
            $escaped_data[$key] = mysqli_real_escape_string($this->con, $value);
        }
        
        $set_parts = [];
        foreach($escaped_data as $column => $value) {
            $set_parts[] = "`$column` = '$value'";
        }
        
        $set_clause = implode(', ', $set_parts);
        $sql = "UPDATE {$this->table} SET $set_clause WHERE $where_condition";
        
        if(mysqli_query($this->con, $sql)){
            return true;
        }else{
            return mysqli_error($this->con);
        }
    }


    public function getByField($field, $value) {
        $safe_field = mysqli_real_escape_string($this->con, $field);
        $safe_value = mysqli_real_escape_string($this->con, $value);

        $sql = "SELECT * FROM {$this->table} WHERE $safe_field = '$safe_value'";
        $result = mysqli_query($this->con, $sql);
        
        if($result && mysqli_num_rows($result) > 0) {
            $rows=[];
            while($row=mysqli_fetch_assoc($result)){
                $rows[]=$row;
            }
            return $rows;

        } else {
            return ;
        }
    }

    public function get($where_condition) {
        $sql = "SELECT * FROM {$this->table} WHERE $where_condition";
        $result = mysqli_query($this->con, $sql);
        
        if($result && mysqli_num_rows($result) > 0) {
            $rows=[];
            while($row=mysqli_fetch_assoc($result)){
                $rows[]=$row;
            }
            return $rows;

        } else {
            return ;
        }
    }

    public function delete($where_condition) {
        $sql = "DELETE FROM {$this->table} WHERE $where_condition";
        
        if(mysqli_query($this->con, $sql)){
            return true;
        }else{
            return mysqli_error($this->con);
        }
    }



}
    
