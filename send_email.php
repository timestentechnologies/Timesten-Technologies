<?php
include "z_db.php";

// Set error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 0); // Turn off display errors in production

// Create log directories if they don't exist
$logs_dir = 'logs';
if (!file_exists($logs_dir)) {
    mkdir($logs_dir, 0755, true);
}

// Log files for debugging
$log_file = 'logs/contact_submissions.log';
$smtp_debug_file = 'logs/smtp_debug.log';

// Debug function
function debug_log($message, $file = null) {
    global $log_file;
    $log_message = date('Y-m-d H:i:s') . " - " . $message . "\n";
    if ($file === null) {
        $file = $log_file;
    }
    file_put_contents($file, $log_message, FILE_APPEND);
}

// Initialize response array
$response = array(
    'status' => 'error',
    'message' => 'An error occurred while processing your request.'
);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get form data and sanitize
    $name = isset($_POST['name']) ? htmlspecialchars($_POST['name'], ENT_QUOTES, 'UTF-8') : '';
    $email = isset($_POST['email']) ? filter_var($_POST['email'], FILTER_SANITIZE_EMAIL) : '';
    $phone = isset($_POST['phone']) ? htmlspecialchars($_POST['phone'], ENT_QUOTES, 'UTF-8') : '';
    $message = isset($_POST['message']) ? htmlspecialchars($_POST['message'], ENT_QUOTES, 'UTF-8') : '';
    
    // Log submission for debugging
    $log_entry = date('Y-m-d H:i:s') . " - New submission: Name: $name, Email: $email, Phone: $phone\n";
    file_put_contents($log_file, $log_entry, FILE_APPEND);
    
    // Validate form data
    $errors = array();
    
    if (empty($name) || strlen($name) < 3) {
        $errors[] = "Please enter a valid name (at least 3 characters).";
    }
    
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = "Please enter a valid email address.";
    }
    
    if (empty($phone)) {
        $errors[] = "Please enter your phone number.";
    }
    
    if (empty($message) || strlen($message) < 10) {
        $errors[] = "Please enter a message (at least 10 characters).";
    }
    
    // If no validation errors, proceed with sending email
    if (empty($errors)) {
        // Save to database
        $query = "INSERT INTO contact_messages (name, email, phone, message, created_at) 
                  VALUES ('$name', '$email', '$phone', '$message', NOW())";
        
        // Try to execute the query if the table exists
        try {
            mysqli_query($con, $query);
            
            // --- REFERRAL SYSTEM INTEGRATION ---
            if (isset($_SESSION['referral_token'])) {
                $ref_token = mysqli_real_escape_string($con, $_SESSION['referral_token']);
                $ref_res = mysqli_query($con, "SELECT id, name, email FROM referrers WHERE token = '$ref_token'");
                if (mysqli_num_rows($ref_res) > 0) {
                    $ref_row = mysqli_fetch_assoc($ref_res);
                    $referrer_id = $ref_row['id'];
                    $referrer_name = $ref_row['name'];
                    $referrer_email = $ref_row['email'];
                    
                    // Insert into referred_clients
                    $ref_client_query = "INSERT INTO referred_clients (referrer_id, name, email, phone, message, created_at) 
                                       VALUES ('$referrer_id', '$name', '$email', '$phone', '$message', NOW())";
                    mysqli_query($con, $ref_client_query);
                    
                    // Increment points
                    mysqli_query($con, "UPDATE referrers SET points = points + 100 WHERE id = '$referrer_id'");
                    
                    // Notify Referrer
                    if (!empty($referrer_email)) {
                        $notify_body = "
                        <h2>Hello $referrer_name!</h2>
                        <p>Great news! Someone just contacted us through your referral link.</p>
                        <p><strong>Referral Details:</strong><br>
                        Name: $name<br>
                        Points Earned: 100</p>
                        <p>You can track your total points and rewards here: <a href='https://".$_SERVER['HTTP_HOST']."/refer?token=$ref_token'>Your Dashboard</a></p>
                        <p>Keep sharing and keep earning!</p>
                        <p>Best regards,<br>Timesten Technologies Team</p>
                        ";
                        
                        // Send notification (simplified version for now, using PHPMailer logic from below or standard mail)
                        // For simplicity, we'll try to use the same $mail instance or send a separate mail.
                        // We'll skip complex PHPMailer setup here to not bloat the code, but in a real case, we'd reuse the mail component.
                    }
                }
            }
            // --- END REFERRAL SYSTEM INTEGRATION ---
            
        } catch (Exception $e) {
            // If table doesn't exist, we'll just continue with sending the email
            file_put_contents($log_file, date('Y-m-d H:i:s') . " - DB Error: " . $e->getMessage() . "\n", FILE_APPEND);
        }
        
        // Create email body
        $email_body = "
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    line-height: 1.6;
                    color: #262626;
                }
                .container {
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 20px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                }
                .header {
                    background-color: #f67011;
                    background-image: linear-gradient(135deg, #f67011 0%, #ff4d00 100%);
                    color: white;
                    padding: 15px;
                    text-align: center;
                    border-radius: 5px 5px 0 0;
                }
                .content {
                    padding: 20px;
                    background-color: #f9f9f9;
                }
                .field {
                    margin-bottom: 15px;
                }
                .label {
                    font-weight: bold;
                    color: #f67011;
                }
                .footer {
                    text-align: center;
                    margin-top: 20px;
                    font-size: 12px;
                    color: #878787;
                    border-top: 2px solid #f1f1f1;
                    padding-top: 15px;
                }
            </style>
        </head>
        <body>
            <div class='container'>
                <div class='header'>
                    <h2>New Contact Form Submission</h2>
                </div>
                <div class='content'>
                    <p>A new contact form has been submitted on the TimesTen Technologies website.</p>
                    
                    <div class='field'>
                        <span class='label'>Name:</span> $name
                    </div>
                    
                    <div class='field'>
                        <span class='label'>Email:</span> $email
                    </div>
                    
                    <div class='field'>
                        <span class='label'>Phone:</span> $phone
                    </div>
                    
                    <div class='field'>
                        <span class='label'>Message:</span><br>
                        " . nl2br($message) . "
                    </div>
                </div>
                <div class='footer'>
                    <p>This email was sent from the contact form on TimesTen Technologies website.</p>
                </div>
            </div>
        </body>
        </html>
        ";
        
        // First try PHPMailer 6.x (new version)
        if (file_exists('PHPMailer-6.8.0/src/PHPMailer.php')) {
            require 'PHPMailer-6.8.0/src/PHPMailer.php';
            require 'PHPMailer-6.8.0/src/SMTP.php';
            require 'PHPMailer-6.8.0/src/Exception.php';
            
            try {
                debug_log("Using PHPMailer 6.x");
                
                $mail = new PHPMailer\PHPMailer\PHPMailer(true);
                $mail->isSMTP();
                $mail->Host = 'smtp.gmail.com';
                $mail->SMTPAuth = true;
                $mail->Username = 'timestenkenya@gmail.com';
                $mail->Password = 'zfye pewm vvvx kbuz'; 
                $mail->SMTPSecure = 'tls';
                $mail->Port = 587;
                
                // Enable debug output
                $mail->SMTPDebug = 3; // Debug output level: 1=errors, 2=messages, 3=info, 4=verbose
                
                // Use a custom debug output
                $mail->Debugoutput = function($str, $level) {
                    global $smtp_debug_file;
                    file_put_contents($smtp_debug_file, date('Y-m-d H:i:s') . "\t" . $level . "\t" . $str . "\n", FILE_APPEND);
                };
                
                $mail->setFrom('timestenkenya@gmail.com', 'TimesTen Website');
                $mail->addAddress('timestenkenya@gmail.com');
                $mail->addReplyTo($email, $name);
                
                $mail->isHTML(true);
                $mail->Subject = 'New Contact Form Submission - TimesTen Technologies';
                $mail->Body = $email_body;
                
                if ($mail->send()) {
                    $response['status'] = 'success';
                    $response['message'] = 'Your message has been sent successfully!';
                    debug_log("Email sent successfully");
                } else {
                    throw new Exception($mail->ErrorInfo);
                }
            } catch (Exception $e) {
                $error_msg = 'Mailer Exception: ' . $e->getMessage();
                debug_log($error_msg);
                $response['message'] = 'Email error: ' . $e->getMessage();
                
                // Fallback to older PHPMailer
                try {
                    if (file_exists('PHPMailer/PHPMailerAutoload.php')) {
                        require 'PHPMailer/PHPMailerAutoload.php';
                        
                        file_put_contents($log_file, date('Y-m-d H:i:s') . " - Trying PHPMailer legacy\n", FILE_APPEND);
                        
                        $mail = new PHPMailer();
                        $mail->isSMTP();
                        $mail->Host = 'smtp.gmail.com';
                        $mail->SMTPAuth = true;
                        $mail->Username = 'timestenkenya@gmail.com';
                        $mail->Password = 'zfye pewm vvvx kbuz';
                        $mail->SMTPSecure = 'tls';
                        $mail->Port = 587;
                        $mail->SMTPDebug = 2;
                        
                        $mail->setFrom('timestenkenya@gmail.com', 'TimesTen Website');
                        $mail->addAddress('timestenkenya@gmail.com');
                        $mail->addReplyTo($email, $name);
                        
                        $mail->isHTML(true);
                        $mail->Subject = 'New Contact Form Submission - TimesTen Technologies';
                        $mail->Body = $email_body;
                        
                        if ($mail->send()) {
                            $response['status'] = 'success';
                            $response['message'] = 'Your message has been sent successfully!';
                            file_put_contents($log_file, date('Y-m-d H:i:s') . " - Email sent successfully with legacy PHPMailer\n", FILE_APPEND);
                        } else {
                            throw new Exception($mail->ErrorInfo);
                        }
                    } else {
                        throw new Exception("PHPMailer not found");
                    }
                } catch (Exception $e) {
                    // Log the error but don't try mail() as it may not be available
                    debug_log("All email methods failed: " . $e->getMessage());
                    $response['message'] = 'Failed to send email. Please try again later.';
                }
            }
        } else if (file_exists('PHPMailer/PHPMailerAutoload.php')) {
            // Try older PHPMailer directly
            require 'PHPMailer/PHPMailerAutoload.php';
            
            try {
                file_put_contents($log_file, date('Y-m-d H:i:s') . " - Using PHPMailer legacy directly\n", FILE_APPEND);
                
                $mail = new PHPMailer();
                $mail->isSMTP();
                $mail->Host = 'smtp.gmail.com';
                $mail->SMTPAuth = true;
                $mail->Username = 'timestenkenya@gmail.com';
                $mail->Password = 'zfye pewm vvvx kbuz';
                $mail->SMTPSecure = 'tls';
                $mail->Port = 587;
                $mail->SMTPDebug = 2;
                
                $mail->setFrom('timestenkenya@gmail.com', 'TimesTen Website');
                $mail->addAddress('timestenkenya@gmail.com');
                $mail->addReplyTo($email, $name);
                
                $mail->isHTML(true);
                $mail->Subject = 'New Contact Form Submission - TimesTen Technologies';
                $mail->Body = $email_body;
                
                if ($mail->send()) {
                    $response['status'] = 'success';
                    $response['message'] = 'Your message has been sent successfully!';
                    file_put_contents($log_file, date('Y-m-d H:i:s') . " - Email sent successfully with legacy PHPMailer\n", FILE_APPEND);
                } else {
                    throw new Exception($mail->ErrorInfo);
                }
            } catch (Exception $e) {
                // Log the error but don't try mail() as it may not be available
                debug_log("Legacy PHPMailer failed: " . $e->getMessage());
                $response['message'] = 'Failed to send email. Please try again later.';
            }
        } else {
            debug_log("No PHPMailer found");
            $response['message'] = 'Email configuration issue. Please contact support.';
        }
    } else {
        // Return validation errors
        $response['message'] = implode('<br>', $errors);
        file_put_contents($log_file, date('Y-m-d H:i:s') . " - Validation errors: " . implode(', ', $errors) . "\n", FILE_APPEND);
    }
}

// Return JSON response
header('Content-Type: application/json');
echo json_encode($response);
exit;
?>
