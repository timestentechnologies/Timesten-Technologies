<?php
include "header.php";

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id > 0) {
    mysqli_query($con, "DELETE FROM partners WHERE id = $id");
}

header("Location: partners");
exit;
?>
