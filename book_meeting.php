<?php
include "z_db.php";

error_reporting(E_ALL);
ini_set('display_errors', 1);

$response = array(
    'status' => 'error',
    'message' => 'An error occurred while processing your request.'
);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = isset($_POST['name']) ? trim($_POST['name']) : '';
    $company = isset($_POST['company']) ? trim($_POST['company']) : '';
    $email = isset($_POST['email']) ? trim($_POST['email']) : '';
    $phone = isset($_POST['phone']) ? trim($_POST['phone']) : '';
    $meeting_type = isset($_POST['meeting_type']) ? trim($_POST['meeting_type']) : '';
    $meeting_date = isset($_POST['meeting_date']) ? trim($_POST['meeting_date']) : '';
    $meeting_time = isset($_POST['meeting_time']) ? trim($_POST['meeting_time']) : '';
    $message = isset($_POST['message']) ? trim($_POST['message']) : '';

    $errors = array();

    if (strlen($name) < 3) {
        $errors[] = 'Please enter your full name.';
    }
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Please enter a valid email address.';
    }
    if (empty($phone)) {
        $errors[] = 'Please enter your phone number.';
    }
    if (strlen($company) > 255) {
        $errors[] = 'Company name is too long.';
    }
    $allowed_types = array('Online', 'Physical');
    if (empty($meeting_type) || !in_array($meeting_type, $allowed_types, true)) {
        $errors[] = 'Please select a meeting type.';
    }
    if (empty($meeting_date)) {
        $errors[] = 'Please select a meeting date.';
    }
    if (empty($meeting_time)) {
        $errors[] = 'Please select a meeting time.';
    }
    if (strlen($message) < 5) {
        $errors[] = 'Please enter a brief message.';
    }

    if (empty($errors)) {
        mysqli_query($con, "CREATE TABLE IF NOT EXISTS meeting_bookings (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            company VARCHAR(255),
            email VARCHAR(255),
            phone VARCHAR(50),
            meeting_type VARCHAR(50),
            meeting_date DATE,
            meeting_time TIME,
            message TEXT,
            status ENUM('New','Contacted','Completed','Cancelled') DEFAULT 'New',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )");

        $col_company = mysqli_query($con, "SHOW COLUMNS FROM meeting_bookings LIKE 'company'");
        if (!$col_company || mysqli_num_rows($col_company) === 0) {
            @mysqli_query($con, "ALTER TABLE meeting_bookings ADD COLUMN company VARCHAR(255)");
        }
        $col_meeting_type = mysqli_query($con, "SHOW COLUMNS FROM meeting_bookings LIKE 'meeting_type'");
        if (!$col_meeting_type || mysqli_num_rows($col_meeting_type) === 0) {
            @mysqli_query($con, "ALTER TABLE meeting_bookings ADD COLUMN meeting_type VARCHAR(50)");
        }

        $db_name = mysqli_real_escape_string($con, htmlspecialchars($name, ENT_QUOTES, 'UTF-8'));
        $db_company = mysqli_real_escape_string($con, htmlspecialchars($company, ENT_QUOTES, 'UTF-8'));
        $db_email = mysqli_real_escape_string($con, filter_var($email, FILTER_SANITIZE_EMAIL));
        $db_phone = mysqli_real_escape_string($con, htmlspecialchars($phone, ENT_QUOTES, 'UTF-8'));
        $db_meeting_type = mysqli_real_escape_string($con, htmlspecialchars($meeting_type, ENT_QUOTES, 'UTF-8'));
        $db_date = mysqli_real_escape_string($con, $meeting_date);
        $db_time = mysqli_real_escape_string($con, $meeting_time);
        $db_message = mysqli_real_escape_string($con, htmlspecialchars($message, ENT_QUOTES, 'UTF-8'));

        $q = "INSERT INTO meeting_bookings (name, company, email, phone, meeting_type, meeting_date, meeting_time, message, created_at)
              VALUES ('$db_name', '$db_company', '$db_email', '$db_phone', '$db_meeting_type', '$db_date', '$db_time', '$db_message', NOW())";

        if (mysqli_query($con, $q)) {
            $response['status'] = 'success';
            $response['message'] = 'Your meeting request has been received. We will confirm shortly.';

            // Send email notification if mail function is available
            if (function_exists('mail')) {
                $recipient = 'timestenkenya@gmail.com';
                $subject = 'New Meeting Booking - TimesTen Technologies';
                $body = "New meeting booking:\n\nName: $name\nCompany: $company\nEmail: $email\nPhone: $phone\nMeeting Type: $meeting_type\nDate: $meeting_date\nTime: $meeting_time\nMessage: $message\n";
                @mail($recipient, $subject, $body, "From: noreply@timesten.com\r\n");
            }
        } else {
            $response['message'] = 'Failed to save your meeting. Please try again.';
        }
    } else {
        $response['message'] = implode('<br>', $errors);
    }
}

header('Content-Type: application/json');
echo json_encode($response);
exit;
?>
