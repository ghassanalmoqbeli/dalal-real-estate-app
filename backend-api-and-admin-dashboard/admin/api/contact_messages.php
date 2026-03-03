<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

require_once '../config/Database.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$db = new Database();
$conn = $db->connect();

function verifyAdmin($conn) {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : null;
    
    if (!$token) {
        $token = isset($_GET['token']) ? $_GET['token'] : null;
    }
    
    if (!$token) {
        return null;
    }
    
    $token = mysqli_real_escape_string($conn, $token);
    $query = "SELECT * FROM admins WHERE token = '$token' AND status = 'active'";
    $result = mysqli_query($conn, $query);
    
    if ($result && mysqli_num_rows($result) > 0) {
        return mysqli_fetch_assoc($result);
    }
    
    return null;
}

$admin = verifyAdmin($conn);
if (!$admin) {
    echo json_encode(['success' => false, 'message' => 'غير مصرح']);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get contact messages
    $status = isset($_GET['status']) ? mysqli_real_escape_string($conn, $_GET['status']) : '';
    $page = isset($_GET['page']) ? intval($_GET['page']) : 1;
    $limit = isset($_GET['limit']) ? intval($_GET['limit']) : 20;
    $offset = ($page - 1) * $limit;
    
    $where = [];
    if ($status) {
        $where[] = "status = '$status'";
    }
    
    $whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';
    
    // Get total count
    $countQuery = "SELECT COUNT(*) as total FROM contact_messages $whereClause";
    $countResult = mysqli_query($conn, $countQuery);
    $total = mysqli_fetch_assoc($countResult)['total'];
    
    // Get messages
    $query = "SELECT * FROM contact_messages $whereClause ORDER BY created_at DESC LIMIT $limit OFFSET $offset";
    $result = mysqli_query($conn, $query);
    $messages = [];
    
    while ($row = mysqli_fetch_assoc($result)) {
        $messages[] = $row;
    }
    
    echo json_encode([
        'success' => true,
        'data' => $messages,
        'pagination' => [
            'total' => intval($total),
            'page' => $page,
            'limit' => $limit,
            'pages' => ceil($total / $limit)
        ]
    ]);
    
} else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Update message status (mark as handled)
    $data = json_decode(file_get_contents('php://input'), true);
    $messageId = intval($data['id']);
    $status = mysqli_real_escape_string($conn, $data['status']); // 'pending', 'handled'
    $response = isset($data['response']) ? mysqli_real_escape_string($conn, $data['response']) : null;
    
    $query = "UPDATE contact_messages SET 
              status = '$status',
              response = " . ($response ? "'$response'" : "NULL") . ",
              admin_id = {$admin['id']},
              handled_at = " . ($status === 'handled' ? "NOW()" : "NULL") . "
              WHERE id = $messageId";
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['success' => true, 'message' => 'تم تحديث حالة الرسالة بنجاح']);
    } else {
        echo json_encode(['success' => false, 'message' => 'فشل تحديث الرسالة: ' . mysqli_error($conn)]);
    }
}

$db->close();
?>

