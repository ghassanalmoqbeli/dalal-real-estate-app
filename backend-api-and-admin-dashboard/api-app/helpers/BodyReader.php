<?php
// BodyReader.php
function  readData() {
    $input = [];
    $rawData = file_get_contents('php://input');
    $contentType = isset($_SERVER['CONTENT_TYPE']) ? $_SERVER['CONTENT_TYPE'] : '';
    
    if (strpos($contentType, 'application/json') !== false) {
        $jsonData = json_decode($rawData, true);
        if (json_last_error() === JSON_ERROR_NONE) $input = $jsonData;
    } 
    elseif (strpos($contentType, 'multipart/form-data') !== false) {
        if (!empty($rawData)) {
            $boundary = '';
            if (preg_match('/boundary=(.*)$/', $contentType, $matches)) {
                $boundary = $matches[1];
            }
            
            if (!empty($boundary)) {
                $parts = explode("--" . $boundary, $rawData);
                foreach ($parts as $part) {
                    if (empty($part) || $part == "--\r\n") continue;
                    if (preg_match('/name="([^"]+)"/', $part, $nameMatches)) {
                        $name = $nameMatches[1];
                        $lines = explode("\r\n\r\n", $part, 2);
                        if (isset($lines[1])) {
                            $value = trim($lines[1]);
                            $value = rtrim($value, "\r\n--");
                            $input[$name] = $value;
                        }
                    }
                }
            } else {
                parse_str($rawData, $parsedData);
                $input = $parsedData;
            }
        }
    }
    elseif (strpos($contentType, 'application/x-www-form-urlencoded') !== false) {
        parse_str($rawData, $parsedData);
        $input = $parsedData;
    }
    else {
        $jsonData = json_decode($rawData, true);
        if (json_last_error() === JSON_ERROR_NONE) {
            $input = $jsonData;
        } else {
            parse_str($rawData, $parsedData);
            $input = $parsedData;
        }
    }
    
    if (!empty($_GET)) {
        $input = array_merge($_GET, $input);
    }
    
    return $input;
}