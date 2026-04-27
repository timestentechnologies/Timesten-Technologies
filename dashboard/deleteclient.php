<?php
session_start();
include "z_db.php";

if (!isset($_SESSION['username'])) {
    header("Location: login");
    exit;
}

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id > 0) {
    mysqli_query($con, "DELETE FROM clients WHERE id = $id");
}

header("Location: clients");
exit;
?>
