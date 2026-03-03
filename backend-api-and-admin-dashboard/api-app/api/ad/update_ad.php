<?php
include "../../config/Database.php";
include "../../models/Models.php";
include "../../helpers/TokenAuth.php";
include "../../helpers/CleanData.php";
include "../../helpers/BodyReader.php";

header("Content-Type: application/json");

$input = readData();

$db = new Database();
$con = $db->connect();
$response = [];

if($_SERVER['REQUEST_METHOD'] == 'PATCH') {
    if($con === true || is_object($con)) {

        $auth = new TokenAuth($con);
        $query = new Models($con, "ads");
        $cleanData = new CleanData($con);

        $headers = getallheaders();
        $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : '';
        $token_result = $auth->verifyToken($token);

        if($token_result['status'] !== 'success') {
            echo json_encode(['status'=>'error','message'=>$token_result['message']], JSON_PRETTY_PRINT);
            exit;
        }

        $user_id = $token_result['user_id'];

        $adData = [];
        $requiredFields = ['id'];
        foreach ($requiredFields as $field) {
            if (isset($input[$field])) $adData[$field] = $cleanData->clean($input[$field]);
        }

        $optionalFields = ['offer_type','title','city','location_text','price','area','latitude','longitude','google_map_url','currency','negotiable','extra_details','rooms','living_rooms','bathrooms','kitchens','floors'];
        foreach ($optionalFields as $field) {
            if (isset($input[$field]) && $input[$field] !== '') $adData[$field] = $cleanData->clean($input[$field]);
        }

        // Validation
        $errors = [];
        foreach ($requiredFields as $field) {
            if (empty($adData[$field])) $errors[$field] = "$field is required";
        }

        if (isset($adData['id']) && (!is_numeric($adData['id']) || $adData['id'] <= 0)) {
            $errors['id'] = "AD ID must be a positive number";
        }

        $validOfferTypes = ['sale_freehold','sale_waqf','rent'];
        if (!empty($adData['offer_type']) && !in_array($adData['offer_type'],$validOfferTypes)) {
            $errors['offer_type'] = "Invalid offer type: only (sale_freehold, sale_waqf, rent)";
        }

        $validCities = ['sanaa','taiz','aden','ibb','dhamar','hodeidah','hadramout','yareem','saada','amran','raymah','mahweet','haggah','lahj','mahrah','shabwa','marib','aljawf','albayda','aldhale','socotra','abian'];
        if (!empty($adData['city']) && !in_array($adData['city'],$validCities)) {
            $errors['city'] = "Invalid city: only (".implode(', ',$validCities).")";
        }

        $validCurrencies = ['YER','SAR','USD'];
        if (isset($adData['currency']) && !empty($adData['currency']) && !in_array($adData['currency'],$validCurrencies)) {
            $errors['currency'] = "Invalid currency: only (YER, SAR, USD)";
        }

        if (!empty($adData['price']) && (!is_numeric($adData['price']) || $adData['price'] <= 0)) $errors['price']="Price must be a positive number";
        if (!empty($adData['area']) && (!is_numeric($adData['area']) || $adData['area'] <= 0)) $errors['area']="Area must be a positive number";
        if (!empty($adData['latitude']) && (!is_numeric($adData['latitude']) || $adData['latitude'] < -90 || $adData['latitude'] > 90)) $errors['latitude']="Invalid latitude value";
        if (!empty($adData['longitude']) && (!is_numeric($adData['longitude']) || $adData['longitude'] < -180 || $adData['longitude'] > 180)) $errors['longitude']="Invalid longitude value";
        if (!empty($adData['negotiable']) && !in_array($adData['negotiable'],['0','1'])) $errors['negotiable']="Negotiable must be 0 or 1 only";

        $numericFields = ['living_rooms','floors','rooms','bathrooms','kitchens'];
        foreach ($numericFields as $field) {
            if (isset($adData[$field]) && (!is_numeric($adData[$field]) || $adData[$field] < 0)) $errors[$field]="$field must be a positive number";
        }

        if (!empty($errors)) {
            echo json_encode(['status'=>'error','message'=>'Validation failed','errors'=>$errors], JSON_PRETTY_PRINT);
            exit;
        }

        // جلب الإعلان الحالي
        $ad = $query->getByField('id',$adData['id']);
        if ($ad && !empty($ad)) {
            $row = $ad[0];
            $adOwnerId = $row['user_id'];
            $adStatus = $row['status'];
            $currentType = $row['type'];

            if ($adOwnerId != $user_id) {
                echo json_encode(['status'=>'error','message'=>'You do not have permission to update this advertisement'], JSON_PRETTY_PRINT);
                exit;
            }

            // لا يمكن تعديل الإعلانات pending
            if ($adStatus == 'pending') {
                echo json_encode(['status'=>'error','message'=>'Cannot update advertisement: pending ads cannot be updated'], JSON_PRETTY_PRINT);
                exit;
            }

            // التحقق من حالة المستخدم
            $userQuery = $query->getByField('id',$user_id,'users');
            $userStatus = isset($userQuery[0]['status']) ? $userQuery[0]['status'] : 'active';
            if ($userStatus == 'blocked') {
                echo json_encode(['status'=>'error','message'=>'Your account is blocked, cannot update advertisements'], JSON_PRETTY_PRINT);
                exit;
            }

            // التحقق من الحقول غير المتوافقة مع نوع العقار الحالي
            $invalidFields = [];
            if ($currentType == 'apartment') {
                if (isset($adData['floors'])) $invalidFields[] = 'floors';
            } elseif ($currentType == 'house') {
                // جميع الحقول مسموح بها
            } else {
                // land أو shop
                $restrictedFields = ['rooms','bathrooms','kitchens','floors','living_rooms'];
                foreach ($restrictedFields as $field) {
                    if (isset($adData[$field])) $invalidFields[] = $field;
                }
            }

            if (!empty($invalidFields)) {
                echo json_encode([
                    'status'=>'error',
                    'message'=>'Cannot update fields not compatible with current property type',
                    'invalid_fields'=>$invalidFields
                ], JSON_PRETTY_PRINT);
                exit;
            }

            // منع تعديل نوع الإعلان
            if (isset($adData['type'])) unset($adData['type']);

            // إزالة id من بيانات التحديث
            unset($adData['id']);

            // التحقق من وجود أي حقول للتعديل
            if (empty($adData)) {
                echo json_encode([
                    'status' => 'error',
                    'message' => 'You must modify at least one field to update the advertisement'
                ], JSON_PRETTY_PRINT);
                exit;
            }

            // إذا كانت الحالة rejected وأرسل المستخدم أي تعديل، أضف status => pending
            if ($adStatus == 'rejected') {
                $adData['status'] = 'pending';
            }

            // تنفيذ التحديث
            $where_condition = "id=".$row['id']." AND user_id=".$user_id;
            $ad_id = $row['id'];

            $status_query = $query->update($adData,$where_condition);

            if ($status_query === true) {
                echo json_encode([
                    'status'=>'success',
                    'message'=>'Advertisement updated successfully.',
                    'data'=>['id'=>$ad_id,'user_id'=>$user_id,'updated_fields'=>$adData]
                ], JSON_PRETTY_PRINT);
            } else {
                echo json_encode(['status'=>'error','message'=>"Error updating Advertisement: ".$status_query], JSON_PRETTY_PRINT);
            }

        } else {
            echo json_encode(['status'=>'error','message'=>'AD not found with this id'], JSON_PRETTY_PRINT);
        }

    } else {
        echo json_encode(['status'=>'error','message'=>$con], JSON_PRETTY_PRINT);
    }
    $con->close();

} else {
    echo json_encode(['status'=>'error','message'=>"error in method request must be PATCH"], JSON_PRETTY_PRINT);
}
