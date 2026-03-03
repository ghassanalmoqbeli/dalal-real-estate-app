<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

require_once '../config/Database.php';
require_once '../config/RBAC.php';

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

// التحقق من صلاحية عرض لوحة التحكم
$permissionCheck = RBAC::verifyPermission($admin, 'view_dashboard');
if ($permissionCheck !== null) {
    echo json_encode($permissionCheck);
    exit();
}

// Get dashboard statistics
$stats = [];

// Total users
$usersQuery = "SELECT COUNT(*) as total FROM users";
$usersResult = mysqli_query($conn, $usersQuery);
$stats['total_users'] = mysqli_fetch_assoc($usersResult)['total'];

// Published ads
$publishedQuery = "SELECT COUNT(*) as total FROM ads WHERE status = 'published'";
$publishedResult = mysqli_query($conn, $publishedQuery);
$stats['published_ads'] = mysqli_fetch_assoc($publishedResult)['total'];

// Pending ads
$pendingQuery = "SELECT COUNT(*) as total FROM ads WHERE status = 'pending'";
$pendingResult = mysqli_query($conn, $pendingQuery);
$stats['pending_ads'] = mysqli_fetch_assoc($pendingResult)['total'];

// Rejected ads
$rejectedQuery = "SELECT COUNT(*) as total FROM ads WHERE status = 'rejected'";
$rejectedResult = mysqli_query($conn, $rejectedQuery);
$stats['rejected_ads'] = mysqli_fetch_assoc($rejectedResult)['total'];

// Open reports
$reportsQuery = "SELECT COUNT(*) as total FROM reports WHERE status = 'open'";
$reportsResult = mysqli_query($conn, $reportsQuery);
$stats['open_reports'] = mysqli_fetch_assoc($reportsResult)['total'];

// Featured ads
$featuredQuery = "SELECT COUNT(*) as total FROM featured_ads WHERE end_date >= CURDATE()";
$featuredResult = mysqli_query($conn, $featuredQuery);
$stats['featured_ads'] = mysqli_fetch_assoc($featuredResult)['total'];

// Get recent pending ads
$recentAdsQuery = "SELECT a.*, u.name as user_name 
                   FROM ads a 
                   LEFT JOIN users u ON a.user_id = u.id 
                   WHERE a.status = 'pending' 
                   ORDER BY a.created_at DESC 
                   LIMIT 5";
$recentAdsResult = mysqli_query($conn, $recentAdsQuery);
$recentAds = [];
while ($row = mysqli_fetch_assoc($recentAdsResult)) {
    $recentAds[] = $row;
}

// Get recent reports
$recentReportsQuery = "SELECT r.*, u.name as reporter_name, a.title as ad_title 
                       FROM reports r 
                       LEFT JOIN users u ON r.user_id = u.id 
                       LEFT JOIN ads a ON r.ad_id = a.id 
                       WHERE r.status = 'open' 
                       ORDER BY r.created_at DESC 
                       LIMIT 5";
$recentReportsResult = mysqli_query($conn, $recentReportsQuery);
$recentReports = [];
while ($row = mysqli_fetch_assoc($recentReportsResult)) {
    $recentReports[] = $row;
}

echo json_encode([
    'success' => true,
    'stats' => $stats,
    'recent_pending_ads' => $recentAds,
    'recent_reports' => $recentReports
]);

$db->close();
?>

