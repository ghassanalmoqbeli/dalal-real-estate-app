<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "ads");
        $cleanData = new CleanData($con);

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

        $adData = [
            'user_id' => $user_id
        ];

        $requiredFields = ['type', 'offer_type', 'title', 'city', 'location_text', 'price', 'area', 'google_map_url'];
        foreach ($requiredFields as $field) {
            if (isset($_POST[$field])) {
                $adData[$field] = $cleanData->clean($_POST[$field]);
            }
        }

        $optionalFields = ['currency', 'negotiable', 'extra_details', 'rooms', 'living_rooms', 
                  'bathrooms', 'kitchens', 'floors', 'latitude', 'longitude'];
        foreach ($optionalFields as $field) {
            if (isset($_POST[$field]) && $_POST[$field] !== '') {
                $adData[$field] = $cleanData->clean($_POST[$field]);
            }
        }


        // Validation
        $errors = [];

        // Required fields validation
        foreach ($requiredFields as $field) {
            if (empty($adData[$field])) {
                $errors[$field] = "$field is required";
            }
        }

        // Type validation
        $validTypes = ['apartment', 'house', 'land', 'shop'];
        if (!empty($adData['type']) && !in_array($adData['type'], $validTypes)) {
            $errors['type'] = "Invalid property type: only (apartment, house, land, shop)";
        }

        // Offer type validation
        $validOfferTypes = ['sale_freehold', 'sale_waqf', 'rent'];
        if (!empty($adData['offer_type']) && !in_array($adData['offer_type'], $validOfferTypes)) {
            $errors['offer_type'] = "Invalid offer type: only (sale_freehold, sale_waqf, rent)";
        }

        // City validation
        $validCities = [
            'sanaa', 'taiz', 'aden', 'ibb', 'dhamar', 'hodeidah',
            'hadramout', 'yareem', 'saada', 'amran', 'raymah',
            'mahweet', 'haggah', 'lahj', 'mahrah', 'shabwa',
            'marib', 'aljawf', 'albayda', 'aldhale', 'socotra', 'abian'
        ];
        if (!empty($adData['city']) && !in_array($adData['city'], $validCities)) {
            $errors['city'] = "Invalid city: only (" . implode(', ', $validCities) . ")";
        }

        // Currency validation
        $validCurrencies = ['YER', 'SAR', 'USD'];
        if (isset($adData['currency']) && !empty($adData['currency']) && !in_array($adData['currency'], $validCurrencies)) {
            $errors['currency'] = "Invalid currency: only (YER, SAR, USD)";
        }

        // Price validation
        if (!empty($adData['price']) && (!is_numeric($adData['price']) || $adData['price'] <= 0)) {
            $errors['price'] = "Price must be a positive number";
        }

        // Area validation
        if (!empty($adData['area']) && (!is_numeric($adData['area']) || $adData['area'] <= 0)) {
            $errors['area'] = "Area must be a positive number";
        }


        // Latitude & Longitude validation
        if (!empty($adData['latitude']) && (!is_numeric($adData['latitude']) || $adData['latitude'] < -90 || $adData['latitude'] > 90)) {
            $errors['latitude'] = "Invalid latitude value";
        }

        if (!empty($adData['longitude']) && (!is_numeric($adData['longitude']) || $adData['longitude'] < -180 || $adData['longitude'] > 180)) {
            $errors['longitude'] = "Invalid longitude value";
        }

        // Negotiable validation
        if (!empty($adData['negotiable']) && !in_array($adData['negotiable'], ['0', '1'])) {
            $errors['negotiable'] = "Negotiable must be 0 or 1 only";
        }
                            
        // Property type specific validation 
        if (isset($adData['type']) && ($adData['type'] == 'apartment' || $adData['type'] == 'house')) {
            if (!isset($adData['rooms']) || empty($adData['rooms'])) {
                $errors['rooms'] = "Rooms are required for apartments and houses";
            } elseif (!is_numeric($adData['rooms']) || $adData['rooms'] < 0) {
                $errors['rooms'] = "Rooms must be a positive number";
            }
            
            if (!isset($adData['bathrooms']) || empty($adData['bathrooms'])) {
                $errors['bathrooms'] = "Bathrooms are required for apartments and houses";
            } elseif (!is_numeric($adData['bathrooms']) || $adData['bathrooms'] < 0) {
                $errors['bathrooms'] = "Bathrooms must be a positive number";
            }
            
            if (!isset($adData['kitchens']) || empty($adData['kitchens'])) {
                $errors['kitchens'] = "Kitchens are required for apartments and houses";
            } elseif (!is_numeric($adData['kitchens']) || $adData['kitchens'] < 0) {
                $errors['kitchens'] = "Kitchens must be a positive number";
            }
            
            if ($adData['type'] == 'house' && (!isset($adData['floors']) || empty($adData['floors']))) {
                $errors['floors'] = "Floors are required for houses";
            } elseif ($adData['type'] == 'house' && (!is_numeric($adData['floors']) || $adData['floors'] < 0)) {
                $errors['floors'] = "Floors must be a positive number";
            }
        }

        // Also add numeric validation for other numeric fields
        $numericFields = ['living_rooms', 'floors'];
        foreach ($numericFields as $field) {
            if (isset($adData[$field]) && (!is_numeric($adData[$field]) || $adData[$field] < 0)) {
                $errors[$field] = "$field must be a positive number";
            }
        }

        // If there are validation errors
        if (!empty($errors)) {
            $response = [
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $errors
            ];
        } 
        
        else {
            
            $status_query = $query->create($adData);
            if($status_query===true){
                $last_id = (string)mysqli_insert_id($con);
                $adData['id'] = $last_id;
                
                $response = [
                    'status' => 'success',
                    'message' => 'Advertisement created successfully.',
                    'data' => $adData
                ];
            } else {
                $response = [
                    'status' => 'error',
                    'message' => "Error creating Advertisement: " . $status_query
                ];
            }
        }
    
    } 
    
    else {
        $response = [
            'status' => 'error',
            'message' => $con
        ]; 
    }
    $con->close();

}

else {
    $response = [
        "status" => 'error',
        'message' => "error in method request must be POST"
    ]; 
}

echo json_encode($response, JSON_PRETTY_PRINT);