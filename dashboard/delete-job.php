<?php
include"header.php";
$todo = mysqli_real_escape_string($con, $_GET['id']);
mysqli_query($con, "DELETE FROM jobs WHERE id='$todo'");
print "<script>window.location='jobs';</script>";
