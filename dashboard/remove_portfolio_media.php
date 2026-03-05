<?php
/**
 * remove_portfolio_media.php
 * Place this file in the SAME folder as edit_portfolio.php
 * Handles AJAX delete requests for portfolio_media records.
 */

ob_start();
include 'header.php'; // gives us $con — HTML output is buffered
ob_end_clean();       // discard the HTML, keep $con

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

$media_rs = mysqli_query($con, "SELECT file_path FROM portfolio_media WHERE id='$media_id' AND portfolio_id='$todo'");

if ($media_rs && mysqli_num_rows($media_rs) > 0) {
    $media_row      = mysqli_fetch_assoc($media_rs);
    $file_to_delete = 'uploads/portfolio/' . $media_row['file_path'];
    if (file_exists($file_to_delete)) {
        unlink($file_to_delete);
    }
    mysqli_query($con, "DELETE FROM portfolio_media WHERE id='$media_id' AND portfolio_id='$todo'");
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => 'Record not found']);
}
exit;
