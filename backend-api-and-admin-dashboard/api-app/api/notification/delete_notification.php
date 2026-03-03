<?php
include "../../config/Database.php";
// NOTE:
// Users are NOT allowed to delete notifications (admin only).
// This endpoint is intentionally disabled and kept only for backward compatibility.

header("Content-Type: application/json");

$db = new Database();
$con = $db->connect();
$response = [
    'status' => 'error',
    'message' => 'Forbidden: users cannot delete notifications. Admin only.',
    'code' => 403
];

http_response_code(403);
if (is_object($con)) {
    $con->close();
}

echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

