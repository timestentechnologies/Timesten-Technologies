<?php
$con = new mysqli("localhost", "opulentl_timesten", "Moonlight#911", "opulentl_timestentech");
if ($con->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}

?>
