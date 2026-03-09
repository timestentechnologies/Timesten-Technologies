<?php
/**
 * remove_service_media.php
 * Place this file in the SAME folder as edit_service.php
 * Handles AJAX delete requests for service_media records.
 */

// Load only the DB connection — adjust this path/file to match your actual config file
// Common names: config.php, db.php, conn.php, dbcon.php, connection.php
$config_candidates = [
    'config.php',
    'db.php',
    'conn.php',
    'dbcon.php',
    'connection.php',
    'database.php',
    'includes/config.php',
    'includes/db.php',
    'includes/conn.php',
    'includes/dbcon.php',
];

foreach ($config_candidates as $file) {
    if (file_exists($file)) {
        ob_start();
        include_once $file;
        ob_end_clean();
        break;
    }
}

// If still no connection, try header.php buffered
if (!isset($con) && !isset($conn) && !isset($db)) {
    ob_start();
    include 'header.php';
    ob_end_clean();
}

// Normalise connection variable
if (!isset($con)) {
    if (isset($conn)) $con = $conn;
    elseif (isset($db))  $con = $db;
}

header('Content-Type: application/json');

if (!isset($con)) {
    echo json_encode(['success' => false, 'error' => 'No DB connection']);
    exit;
}

if (!isset($_POST['remove_media_id']) || !isset($_GET['id'])) {
    echo json_encode(['success' => false, 'error' => 'Missing parameters']);
    exit;
}

$todo     = mysqli_real_escape_string($con, $_GET['id']);
$media_id = intval($_POST['remove_media_id']);

$media_rs = mysqli_query($con, "SELECT file_path FROM service_media WHERE id='$media_id' AND service_id='$todo'");

if ($media_rs && mysqli_num_rows($media_rs) > 0) {
    $media_row      = mysqli_fetch_assoc($media_rs);
    $file_to_delete = 'uploads/services/' . $media_row['file_path'];
    if (file_exists($file_to_delete)) {
        unlink($file_to_delete);
    }
    mysqli_query($con, "DELETE FROM service_media WHERE id='$media_id' AND service_id='$todo'");
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => 'Record not found']);
}
exit;
