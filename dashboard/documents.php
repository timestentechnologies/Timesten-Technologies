<?php
ob_start();

if (isset($_GET['debug']) && (string)$_GET['debug'] === '1') {
    header('Content-Type: text/html; charset=utf-8');
    $BASE_DIR = dirname(__FILE__);
    $mysqli_ok = class_exists('mysqli');
    $db_loaded = false;
    if ($mysqli_ok) {
        if (file_exists($BASE_DIR . '/z_db.php')) {
            include $BASE_DIR . '/z_db.php';
            $db_loaded = true;
        } elseif (file_exists($BASE_DIR . '/../z_db.php')) {
            include $BASE_DIR . '/../z_db.php';
            $db_loaded = true;
        }
    }
    session_start();
    $authed = isset($_SESSION['username']);
    $has_con = $mysqli_ok && isset($con) && ($con instanceof mysqli);
    $has_phpmailer6 = file_exists($BASE_DIR . '/../PHPMailer-6.8.0/src/PHPMailer.php');
    $has_phpmailer_legacy = file_exists($BASE_DIR . '/../PHPMailer/PHPMailerAutoload.php');

    echo "<!doctype html><html><head><meta charset='utf-8'><title>Documents Debug</title><style>body{font-family:Arial,Helvetica,sans-serif;background:#f3f4f6;margin:0;padding:24px;color:#0f172a;} .card{max-width:820px;margin:0 auto;background:#fff;border:1px solid #e5e7eb;border-radius:14px;padding:18px;} pre{white-space:pre-wrap;background:#0b1220;color:#e2e8f0;padding:12px;border-radius:10px;}</style></head><body><div class='card'><h2 style='margin:0 0 10px 0;'>documents.php debug</h2>";
    echo "<pre>db_loaded=" . ($db_loaded ? 'true' : 'false') . "\n";
    echo "mysqli_ok=" . ($mysqli_ok ? 'true' : 'false') . "\n";
    echo "has_con=" . ($has_con ? 'true' : 'false') . "\n";
    echo "authed=" . ($authed ? 'true' : 'false') . "\n";
    echo "phpmailer6=" . ($has_phpmailer6 ? 'true' : 'false') . "\n";
    echo "phpmailer_legacy=" . ($has_phpmailer_legacy ? 'true' : 'false') . "\n";
    echo "BASE_DIR=" . $BASE_DIR . "\n";
    echo "</pre>";
    echo "</div></body></html>";
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['send_doc_email'])) {
    $BASE_DIR = dirname(__FILE__);
    $mysqli_ok = class_exists('mysqli');
    $db_loaded = false;
    if ($mysqli_ok) {
        if (file_exists($BASE_DIR . '/z_db.php')) {
            include $BASE_DIR . '/z_db.php';
            $db_loaded = true;
        } elseif (file_exists($BASE_DIR . '/../z_db.php')) {
            include $BASE_DIR . '/../z_db.php';
            $db_loaded = true;
        }
    }
    session_start();
    if (!isset($_SESSION['username'])) {
        header('Content-Type: application/json');
        echo json_encode(array('status' => 'error', 'message' => 'Unauthorized'));
        exit;
    }

    if (!$db_loaded || !$mysqli_ok || !isset($con) || !($con instanceof mysqli)) {
        header('Content-Type: application/json');
        echo json_encode(array('status' => 'error', 'message' => 'Database connection not available.'));
        exit;
    }

    mysqli_query($con, "CREATE TABLE IF NOT EXISTS email_settings (
      id INT PRIMARY KEY,
      smtp_host VARCHAR(255) NULL,
      smtp_port INT NULL,
      smtp_user VARCHAR(255) NULL,
      smtp_pass VARCHAR(255) NULL,
      smtp_secure VARCHAR(20) NULL,
      from_email VARCHAR(255) NULL,
      from_name VARCHAR(255) NULL,
      logo_url TEXT NULL,
      updated_at DATETIME NULL
    )");

    mysqli_query($con, "CREATE TABLE IF NOT EXISTS doc_access_tokens (
      id INT AUTO_INCREMENT PRIMARY KEY,
      doc_kind VARCHAR(30) NOT NULL,
      doc_id INT NOT NULL,
      token VARCHAR(100) NOT NULL,
      expires_at DATETIME NOT NULL,
      created_at DATETIME NULL,
      UNIQUE KEY uniq_token (token),
      KEY idx_doc (doc_kind, doc_id)
    )");
    mysqli_query(
        $con,
        "INSERT INTO email_settings (id, smtp_host, smtp_port, smtp_user, smtp_pass, smtp_secure, from_email, from_name, logo_url, updated_at)
         SELECT 1, 'smtp.gmail.com', 587, 'timestenkenya@gmail.com', 'zfye pewm vvvx kbuz', 'tls', 'timestenkenya@gmail.com', 'TimesTen Website', '', NOW()
         WHERE NOT EXISTS (SELECT 1 FROM email_settings WHERE id=1)"
    );
    $es_rs = mysqli_query($con, "SELECT * FROM email_settings WHERE id=1 LIMIT 1");
    $es = $es_rs ? mysqli_fetch_assoc($es_rs) : null;
    $smtp_host = $es && !empty($es['smtp_host']) ? (string)$es['smtp_host'] : 'smtp.gmail.com';
    $smtp_port = $es && !empty($es['smtp_port']) ? (int)$es['smtp_port'] : 587;
    $smtp_user = $es && !empty($es['smtp_user']) ? (string)$es['smtp_user'] : 'timestenkenya@gmail.com';
    $smtp_pass = $es && !empty($es['smtp_pass']) ? (string)$es['smtp_pass'] : 'zfye pewm vvvx kbuz';
    $smtp_secure = $es && !empty($es['smtp_secure']) ? (string)$es['smtp_secure'] : 'tls';
    $from_email = $es && !empty($es['from_email']) ? (string)$es['from_email'] : $smtp_user;
    $from_name = $es && !empty($es['from_name']) ? (string)$es['from_name'] : 'TimesTen Website';
    $logo_url = $es && !empty($es['logo_url']) ? (string)$es['logo_url'] : '';

    $doc_kind = isset($_POST['doc_kind']) ? strtolower(trim((string)$_POST['doc_kind'])) : '';
    $doc_id = isset($_POST['doc_id']) ? (int)$_POST['doc_id'] : 0;

    $to_raw = isset($_POST['to_emails']) ? trim((string)$_POST['to_emails']) : '';
    $doc_title = isset($_POST['doc_title']) ? trim((string)$_POST['doc_title']) : 'Document';
    $doc_url = isset($_POST['doc_url']) ? trim((string)$_POST['doc_url']) : '';
    $extra_msg = isset($_POST['message']) ? trim((string)$_POST['message']) : '';

    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host = isset($_SERVER['HTTP_HOST']) ? (string)$_SERVER['HTTP_HOST'] : '';
    $path = isset($_SERVER['SCRIPT_NAME']) ? rtrim(str_replace('documents.php', '', (string)$_SERVER['SCRIPT_NAME']), '/') : '';
    $base = $scheme . '://' . $host . $path;

    $token = '';
    $token_url = '';
    if ($doc_id > 0 && ($doc_kind === 'invoice' || $doc_kind === 'payslip' || $doc_kind === 'expense')) {
        try {
            $token = bin2hex(random_bytes(24));
        } catch (Exception $e) {
            $token = bin2hex(openssl_random_pseudo_bytes(24));
        }
        $tk_s = mysqli_real_escape_string($con, $token);
        $dk_s = mysqli_real_escape_string($con, $doc_kind);
        mysqli_query($con, "DELETE FROM doc_access_tokens WHERE doc_kind='$dk_s' AND doc_id=$doc_id AND expires_at < NOW()");
        mysqli_query($con, "INSERT INTO doc_access_tokens (doc_kind, doc_id, token, expires_at, created_at) VALUES ('$dk_s', $doc_id, '$tk_s', DATE_ADD(NOW(), INTERVAL 7 DAY), NOW())");

        if ($doc_kind === 'invoice') {
            $token_url = $base . '/invoice-view.php?id=' . $doc_id . '&print=1&t=' . urlencode($token);
        } elseif ($doc_kind === 'payslip') {
            $token_url = $base . '/payslip-view.php?id=' . $doc_id . '&t=' . urlencode($token);
        } else {
            $token_url = $base . '/expense-receipt-view.php?id=' . $doc_id . '&t=' . urlencode($token);
        }
        $doc_url = $token_url;
    }

    $emails = preg_split('/[\s,;]+/', $to_raw);
    $to_list = array();
    foreach ($emails as $em) {
        $em = trim($em);
        if (strlen($em) < 5) { continue; }
        if (filter_var($em, FILTER_VALIDATE_EMAIL)) {
            $to_list[] = $em;
        }
    }

    if (count($to_list) < 1 || strlen($doc_url) < 5) {
        header('Content-Type: application/json');
        echo json_encode(array('status' => 'error', 'message' => 'Please provide valid recipient email(s) and a document link.'));
        exit;
    }

    $subject = 'Document: ' . $doc_title;
    $safe_title = htmlspecialchars($doc_title);
    $safe_url = htmlspecialchars($doc_url);
    $safe_msg = strlen($extra_msg) > 0 ? nl2br(htmlspecialchars($extra_msg)) : '';

    $company_name = $from_name;
    $company_url = '';
    $company_phone = '';
    $company_email = $from_email;
    $company_address = '';

    $sc_rs = mysqli_query($con, "SELECT site_title, site_url FROM siteconfig WHERE id=1 LIMIT 1");
    $sc = $sc_rs ? mysqli_fetch_assoc($sc_rs) : null;
    if ($sc) {
        if (!empty($sc['site_title'])) { $company_name = (string)$sc['site_title']; }
        if (!empty($sc['site_url'])) { $company_url = (string)$sc['site_url']; }
    }

    $has_addr_col = false;
    $col_rs = mysqli_query($con, "SHOW COLUMNS FROM sitecontact LIKE 'address'");
    $has_addr_col = ($col_rs && mysqli_num_rows($col_rs) > 0);
    $ct_sql = $has_addr_col ? "SELECT phone1, email1, address FROM sitecontact WHERE id=1 LIMIT 1" : "SELECT phone1, email1 FROM sitecontact WHERE id=1 LIMIT 1";
    $ct_rs = mysqli_query($con, $ct_sql);
    $ct = $ct_rs ? mysqli_fetch_assoc($ct_rs) : null;
    if ($ct) {
        $company_phone = !empty($ct['phone1']) ? (string)$ct['phone1'] : '';
        $company_email = !empty($ct['email1']) ? (string)$ct['email1'] : $company_email;
        if ($has_addr_col && !empty($ct['address'])) {
            $company_address = (string)$ct['address'];
        }
    }

    $logo_src = '';
    mysqli_query($con, "CREATE TABLE IF NOT EXISTS invoice_settings (id INT PRIMARY KEY, invoice_logo VARCHAR(255) NULL, updated_at DATETIME NULL)");
    mysqli_query($con, "INSERT INTO invoice_settings (id, invoice_logo, updated_at) SELECT 1, '', NOW() WHERE NOT EXISTS (SELECT 1 FROM invoice_settings WHERE id=1)");
    $invset_rs = mysqli_query($con, "SELECT invoice_logo FROM invoice_settings WHERE id=1 LIMIT 1");
    $invset = $invset_rs ? mysqli_fetch_assoc($invset_rs) : null;
    if ($invset && !empty($invset['invoice_logo'])) {
        $logo_src = $base . '/uploads/logo/' . rawurlencode((string)$invset['invoice_logo']);
    } elseif (strlen(trim($logo_url)) > 5) {
        $logo_src = $logo_url;
    }

    $logo_html = '';
    if (strlen(trim($logo_src)) > 5) {
        $logo_html = "<div style='text-align:center;margin-bottom:14px;'><img src='" . htmlspecialchars($logo_src) . "' alt='Logo' style='max-width:180px;height:auto;'></div>";
    }

    $company_meta = '';
    $company_meta .= "<div style='font-size:12px;color:#6b7280;line-height:1.55;text-align:center;margin-top:8px;'>";
    if (strlen($company_address)) { $company_meta .= nl2br(htmlspecialchars($company_address)); }
    $line2 = '';
    if (strlen($company_phone)) { $line2 .= htmlspecialchars($company_phone); }
    if (strlen($company_email)) { $line2 .= (strlen($line2) ? ' | ' : '') . htmlspecialchars($company_email); }
    if (strlen($company_url)) { $line2 .= (strlen($line2) ? ' | ' : '') . htmlspecialchars($company_url); }
    if (strlen($line2)) {
        if (strlen($company_address)) { $company_meta .= "<br>"; }
        $company_meta .= $line2;
    }
    $company_meta .= "</div>";
    $msg_block = '';
    if (strlen($safe_msg) > 0) {
        $msg_block = "<div style='margin-top:16px;padding:14px 16px;background:#f8fafc;border:1px solid #e5e7eb;border-radius:10px;color:#0f172a;line-height:1.55;'>" . $safe_msg . "</div>";
    }

    $body = "<!doctype html><html><head><meta charset='utf-8'></head><body style='margin:0;padding:0;background:#f3f4f6;font-family:Arial,Helvetica,sans-serif;'>";
    $body .= "<div style='padding:24px 12px;'>";
    $body .= "<div style='max-width:640px;margin:0 auto;background:#ffffff;border-radius:14px;overflow:hidden;border:1px solid #e5e7eb;'>";
    $body .= "<div style='padding:22px 22px 10px 22px;background:#ffffff;'>";
    $body .= $logo_html;
    $body .= "<h2 style='margin:0 0 6px 0;font-size:20px;color:#111827;'>Document shared with you</h2>";
    $body .= "<div style='font-size:14px;color:#6b7280;margin-bottom:8px;'>" . htmlspecialchars($company_name) . "</div>";
    $body .= $company_meta;
    $body .= "<div style='padding:14px 16px;background:#f9fafb;border:1px solid #e5e7eb;border-radius:12px;'>";
    $body .= "<div style='font-size:14px;color:#6b7280;margin-bottom:6px;'>Document</div>";
    $body .= "<div style='font-size:16px;color:#111827;font-weight:700;margin-bottom:14px;'>$safe_title</div>";
    $body .= "<div style='text-align:center;margin:14px 0 6px 0;'>";
    $body .= "<a href='$safe_url' target='_blank' style='display:inline-block;background:#1d4ed8;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:10px;font-weight:700;font-size:14px;'>Open Document</a>";
    $body .= "</div>";
    $body .= "<div style='text-align:center;font-size:12px;color:#6b7280;margin-top:10px;'>If the button doesn't work, copy and paste this link:</div>";
    $body .= "<div style='word-break:break-all;font-size:12px;color:#2563eb;text-align:center;margin-top:6px;'><a href='$safe_url' target='_blank' style='color:#2563eb;'>$safe_url</a></div>";
    $body .= "</div>";
    $body .= $msg_block;
    $body .= "</div>";
    $body .= "<div style='padding:14px 22px;background:#f9fafb;border-top:1px solid #e5e7eb;font-size:12px;color:#6b7280;text-align:center;'>";
    $body .= "This email was sent from " . htmlspecialchars($company_name) . ".</div>";
    $body .= "</div></div></body></html>";

    $sent = false;
    $err = '';
    try {
        if (file_exists($BASE_DIR . '/../PHPMailer-6.8.0/src/PHPMailer.php')) {
            require_once $BASE_DIR . '/../PHPMailer-6.8.0/src/PHPMailer.php';
            require_once $BASE_DIR . '/../PHPMailer-6.8.0/src/SMTP.php';
            require_once $BASE_DIR . '/../PHPMailer-6.8.0/src/Exception.php';

            $cls = 'PHPMailer\\PHPMailer\\PHPMailer';
            $mail = new $cls(true);
            $mail->CharSet = 'UTF-8';
            $mail->isSMTP();
            $mail->Host = $smtp_host;
            $mail->SMTPAuth = true;
            $mail->Username = $smtp_user;
            $mail->Password = $smtp_pass;
            $mail->SMTPSecure = $smtp_secure;
            $mail->Port = $smtp_port;
            $mail->setFrom($from_email, $from_name);
            foreach ($to_list as $t) {
                $mail->addAddress($t);
            }

            if ($doc_kind === 'document' && $doc_id > 0) {
                $d_rs = mysqli_query($con, "SELECT doc_type, file_name, original_name FROM documents WHERE id=$doc_id LIMIT 1");
                $d = $d_rs ? mysqli_fetch_assoc($d_rs) : null;
                if ($d && isset($d['doc_type']) && (string)$d['doc_type'] === 'file' && !empty($d['file_name'])) {
                    $rel_fn = ltrim(str_replace('\\', '/', (string)$d['file_name']), '/');
                    $orig   = !empty($d['original_name']) ? (string)$d['original_name'] : basename($rel_fn);
                    $fp     = dirname(__FILE__) . '/uploads/documents/' . $rel_fn;
                    if (is_file($fp) && is_readable($fp)) {
                        $mail->addAttachment($fp, $orig);
                    }
                }
            }

            if ($doc_id > 0 && ($doc_kind === 'invoice' || $doc_kind === 'payslip' || $doc_kind === 'expense') && strlen($token) > 10) {
                $pdf_url = '';
                $filename = 'Document.pdf';
                if ($doc_kind === 'invoice') {
                    $pdf_url = $base . '/invoice-view.php?id=' . $doc_id . '&pdf=1&t=' . urlencode($token);
                    $filename = 'Invoice-' . (string)$doc_id . '.pdf';
                } elseif ($doc_kind === 'payslip') {
                    $pdf_url = $base . '/payslip-view.php?id=' . $doc_id . '&pdf=1&t=' . urlencode($token);
                    $filename = 'Payslip-' . (string)$doc_id . '.pdf';
                } else {
                    $pdf_url = $base . '/expense-receipt-view.php?id=' . $doc_id . '&pdf=1&t=' . urlencode($token);
                    $filename = 'Expense-Receipt-' . (string)$doc_id . '.pdf';
                }

                if (function_exists('curl_init') && strlen($pdf_url) > 10) {
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_URL, $pdf_url);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                    curl_setopt($ch, CURLOPT_TIMEOUT, 25);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    $pdf_data = curl_exec($ch);
                    $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
                    curl_close($ch);
                    if ($pdf_data !== false && $code >= 200 && $code < 300 && substr((string)$pdf_data, 0, 4) === '%PDF') {
                        $mail->addStringAttachment($pdf_data, $filename, 'base64', 'application/pdf');
                    }
                }
            }
            $mail->isHTML(true);
            $mail->Subject = $subject;
            $mail->Body = $body;
            $mail->AltBody = $doc_title . "\n" . $doc_url . (strlen($extra_msg) ? ("\n\n" . $extra_msg) : '');
            $sent = $mail->send();
        } elseif (file_exists($BASE_DIR . '/../PHPMailer/PHPMailerAutoload.php')) {
            require_once $BASE_DIR . '/../PHPMailer/PHPMailerAutoload.php';
            $mail = new PHPMailer();
            $mail->CharSet = 'UTF-8';
            $mail->isSMTP();
            $mail->Host = $smtp_host;
            $mail->SMTPAuth = true;
            $mail->Username = $smtp_user;
            $mail->Password = $smtp_pass;
            $mail->SMTPSecure = $smtp_secure;
            $mail->Port = $smtp_port;
            $mail->setFrom($from_email, $from_name);
            foreach ($to_list as $t) {
                $mail->addAddress($t);
            }

            if ($doc_kind === 'document' && $doc_id > 0) {
                $d_rs = mysqli_query($con, "SELECT doc_type, file_name, original_name FROM documents WHERE id=$doc_id LIMIT 1");
                $d = $d_rs ? mysqli_fetch_assoc($d_rs) : null;
                if ($d && isset($d['doc_type']) && (string)$d['doc_type'] === 'file' && !empty($d['file_name'])) {
                    $rel_fn = ltrim(str_replace('\\', '/', (string)$d['file_name']), '/');
                    $orig   = !empty($d['original_name']) ? (string)$d['original_name'] : basename($rel_fn);
                    $fp     = dirname(__FILE__) . '/uploads/documents/' . $rel_fn;
                    if (is_file($fp) && is_readable($fp)) {
                        $mail->addAttachment($fp, $orig);
                    }
                }
            }
            $mail->isHTML(true);
            $mail->Subject = $subject;
            $mail->Body = $body;
            $mail->AltBody = $doc_title . "\n" . $doc_url . (strlen($extra_msg) ? ("\n\n" . $extra_msg) : '');
            $sent = $mail->send();
        } else {
            $err = 'Email library not found.';
        }
    } catch (Exception $e) {
        $err = $e->getMessage();
    }

    header('Content-Type: application/json');
    if ($sent) {
        echo json_encode(array('status' => 'success', 'message' => 'Email sent.'));
    } else {
        echo json_encode(array('status' => 'error', 'message' => (strlen($err) ? $err : 'Failed to send email.')));
    }
    exit;
}

include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS document_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  created_at DATETIME NULL
)");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NULL,
  title VARCHAR(255) NOT NULL,
  doc_type VARCHAR(20) NOT NULL,
  file_name VARCHAR(255) NULL,
  original_name VARCHAR(255) NULL,
  link_url TEXT NULL,
  uploaded_by VARCHAR(120) NULL,
  related_employee_id INT NULL,
  created_at DATETIME NULL
)");

$username = isset($_SESSION['username']) ? $_SESSION['username'] : '';

$errormsg = '';
$successmsg = '';

if (isset($_SESSION['documents_flash_success'])) {
    $successmsg = (string)$_SESSION['documents_flash_success'];
    unset($_SESSION['documents_flash_success']);
}
if (isset($_SESSION['documents_flash_error'])) {
    $errormsg = (string)$_SESSION['documents_flash_error'];
    unset($_SESSION['documents_flash_error']);
}

$cat_id = isset($_GET['cat']) ? (int)$_GET['cat'] : 0;
$view = isset($_GET['view']) ? (string)$_GET['view'] : 'grid';
if ($view !== 'grid' && $view !== 'list') { $view = 'grid'; }

$cats = array();
$active_cat_name = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['bulk_delete_docs'])) {
    $raw_ids = isset($_POST['bulk_delete_docs']) && is_array($_POST['bulk_delete_docs'])
        ? $_POST['bulk_delete_docs'] : array();
    $ids = array();
    foreach ($raw_ids as $rid) {
        $rid = (int)$rid;
        if ($rid > 0) { $ids[] = $rid; }
    }
    if (count($ids) > 0) {
        $ids_in = implode(',', $ids);
        $d_rs = mysqli_query($con, "SELECT id, doc_type, file_name FROM documents WHERE id IN ($ids_in)");
        $del_count = 0;
        if ($d_rs) {
            while ($d = mysqli_fetch_assoc($d_rs)) {
                if ($d['doc_type'] === 'file' && !empty($d['file_name'])) {
                    $rel_fn = ltrim(str_replace('\\', '/', (string)$d['file_name']), '/');
                    $fp = dirname(__FILE__) . '/uploads/documents/' . $rel_fn;
                    if (is_file($fp)) { @unlink($fp); }
                }
                $del_count++;
            }
        }
        mysqli_query($con, "DELETE FROM documents WHERE id IN ($ids_in)");
        $word = $del_count === 1 ? 'Document' : "$del_count documents";
        $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>$word deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
    $qs = array();
    if ($cat_id > 0) { $qs[] = 'cat=' . (int)$cat_id; }
    if (strlen($view) > 0) { $qs[] = 'view=' . urlencode($view); }
    $to = 'documents.php' . (count($qs) ? ('?' . implode('&', $qs)) : '');
    header('Location: ' . $to);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['rename_doc_id'])) {
    $doc_id = (int)$_POST['rename_doc_id'];
    $new_title = isset($_POST['rename_title']) ? trim((string)$_POST['rename_title']) : '';
    $new_original = isset($_POST['rename_original_name']) ? trim((string)$_POST['rename_original_name']) : '';

    if ($doc_id > 0 && strlen($new_title) >= 1) {
        $doc_q = mysqli_query($con, "SELECT id, doc_type FROM documents WHERE id=$doc_id LIMIT 1");
        $doc = $doc_q ? mysqli_fetch_assoc($doc_q) : null;
        if ($doc) {
            $title_s = mysqli_real_escape_string($con, $new_title);
            if ((string)$doc['doc_type'] === 'file') {
                if (strlen($new_original) >= 1) {
                    $orig_s = mysqli_real_escape_string($con, $new_original);
                    mysqli_query($con, "UPDATE documents SET title='$title_s', original_name='$orig_s' WHERE id=$doc_id LIMIT 1");
                } else {
                    mysqli_query($con, "UPDATE documents SET title='$title_s' WHERE id=$doc_id LIMIT 1");
                }
            } else {
                mysqli_query($con, "UPDATE documents SET title='$title_s' WHERE id=$doc_id LIMIT 1");
            }
            $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Document renamed.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    } else {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Title is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }

    $qs = array();
    if ($cat_id > 0) { $qs[] = 'cat=' . (int)$cat_id; }
    if (strlen($view) > 0) { $qs[] = 'view=' . urlencode($view); }
    $to = 'documents.php' . (count($qs) ? ('?' . implode('&', $qs)) : '');
    header('Location: ' . $to);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_doc_id'])) {
    $doc_id = (int)$_POST['delete_doc_id'];
    if ($doc_id > 0) {
        $doc_q = mysqli_query($con, "SELECT * FROM documents WHERE id=$doc_id LIMIT 1");
        $doc = $doc_q ? mysqli_fetch_assoc($doc_q) : null;
        if ($doc) {
            if ($doc['doc_type'] === 'file' && !empty($doc['file_name'])) {
                $fp = dirname(__FILE__) . '/uploads/documents/' . $doc['file_name'];
                if (is_file($fp)) {
                    @unlink($fp);
                }
            }
            mysqli_query($con, "DELETE FROM documents WHERE id=$doc_id LIMIT 1");
            $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Document deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }

    $qs = array();
    if ($cat_id > 0) { $qs[] = 'cat=' . (int)$cat_id; }
    if (strlen($view) > 0) { $qs[] = 'view=' . urlencode($view); }
    $to = 'documents.php' . (count($qs) ? ('?' . implode('&', $qs)) : '');
    header('Location: ' . $to);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['upload_doc'])) {
    $title = isset($_POST['title']) ? trim((string)$_POST['title']) : '';
    $category_id = isset($_POST['category_id']) ? (int)$_POST['category_id'] : 0;
    $doc_type = isset($_POST['doc_type']) ? (string)$_POST['doc_type'] : 'file';
    $link_url = isset($_POST['link_url']) ? trim((string)$_POST['link_url']) : '';

    if ($category_id < 1) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Please select a category.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($doc_type === 'link' && strlen($link_url) < 5) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Link URL is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($doc_type === 'link') {
        if (strlen($title) < 2) {
            $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Title is required for links.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $title_s = mysqli_real_escape_string($con, $title);
            $link_s = mysqli_real_escape_string($con, $link_url);
            $uploader_s = mysqli_real_escape_string($con, $username);
            mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, created_at) VALUES ($category_id, '$title_s', 'link', NULL, NULL, '$link_s', '$uploader_s', NOW())");
            $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Link saved.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    } elseif ($doc_type === 'file') {
        // Support multiple file uploads
        $has_files = isset($_FILES['doc_file']) && is_array($_FILES['doc_file']['name']) && count($_FILES['doc_file']['name']) > 0;
        $single_file = isset($_FILES['doc_file']) && !is_array($_FILES['doc_file']['name']) && $_FILES['doc_file']['error'] === UPLOAD_ERR_OK;

        if (!$has_files && !$single_file) {
            $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>At least one file is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $uploads_dir = dirname(__FILE__) . '/uploads/documents';
            if (!is_dir($uploads_dir)) {
                @mkdir($uploads_dir, 0775, true);
            }

            // Normalise single/multi into a unified array
            if ($has_files) {
                $file_names_raw   = $_FILES['doc_file']['name'];
                $file_tmp_names   = $_FILES['doc_file']['tmp_name'];
                $file_errors      = $_FILES['doc_file']['error'];
            } else {
                $file_names_raw   = array($_FILES['doc_file']['name']);
                $file_tmp_names   = array($_FILES['doc_file']['tmp_name']);
                $file_errors      = array($_FILES['doc_file']['error']);
            }

            // Resolve category name for subfolder use
            $cat_name_raw = '';
            if ($category_id > 0) {
                $cn_q = mysqli_query($con, "SELECT name FROM document_categories WHERE id=$category_id LIMIT 1");
                $cn_r = $cn_q ? mysqli_fetch_assoc($cn_q) : null;
                if ($cn_r && !empty($cn_r['name'])) {
                    $cat_name_raw = (string)$cn_r['name'];
                }
            }

            // Title provided  → uploads/documents/{safe_cat}/{safe_title}/
            // Title blank     → uploads/documents/  (flat, as before)
            $safe_cat_dir   = trim(preg_replace('/[^a-zA-Z0-9\-_]/', '_', $cat_name_raw));
            $safe_title_dir = strlen($title) >= 2 ? trim(preg_replace('/[^a-zA-Z0-9\-_ ]/', '_', $title)) : '';

            if (strlen($safe_title_dir) >= 1 && strlen($safe_cat_dir) >= 1) {
                $target_dir      = $uploads_dir . '/' . $safe_cat_dir . '/' . $safe_title_dir;
                $relative_prefix = $safe_cat_dir . '/' . $safe_title_dir . '/';
            } else {
                $target_dir      = $uploads_dir;
                $relative_prefix = '';
            }

            if (!is_dir($target_dir)) {
                @mkdir($target_dir, 0775, true);
            }

            $uploaded = 0;
            $failed   = 0;
            $uploader_s = mysqli_real_escape_string($con, $username);

            foreach ($file_names_raw as $idx => $raw_name) {
                if ($file_errors[$idx] !== UPLOAD_ERR_OK) {
                    $failed++;
                    continue;
                }
                $tmp_name      = $file_tmp_names[$idx];
                $original_name = basename($raw_name);
                $safe_original = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
                $random_digit  = rand(1000, 9999);
                $stored_name   = $random_digit . '_' . $safe_original;

                // Doc title: supplied title for single-file; filename stem for multi / blank
                if (strlen($title) >= 2 && count($file_names_raw) === 1) {
                    $doc_title = $title;
                } else {
                    $doc_title = pathinfo($original_name, PATHINFO_FILENAME);
                    if (strlen($doc_title) < 1) { $doc_title = $original_name; }
                }

                if (!move_uploaded_file($tmp_name, $target_dir . '/' . $stored_name)) {
                    $failed++;
                    continue;
                }

                // db file_name carries the relative sub-path so open/download links resolve correctly
                $db_file_name = $relative_prefix . $stored_name;

                $title_s = mysqli_real_escape_string($con, $doc_title);
                $file_s  = mysqli_real_escape_string($con, $db_file_name);
                $orig_s  = mysqli_real_escape_string($con, $original_name);
                mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, created_at) VALUES ($category_id, '$title_s', 'file', '$file_s', '$orig_s', NULL, '$uploader_s', NOW())");
                $uploaded++;
            }

            if ($uploaded > 0 && $failed === 0) {
                $word = $uploaded === 1 ? 'Document' : "$uploaded documents";
                $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>$word uploaded successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } elseif ($uploaded > 0) {
                $_SESSION['documents_flash_success'] = "<div class='alert alert-warning alert-dismissible alert-outline fade show'>$uploaded uploaded, $failed failed.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } else {
                $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>File upload failed. Please try again.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            }
        }
    }

    $qs = array();
    $qs[] = 'cat=' . (int)$category_id;
    if (strlen($view) > 0) { $qs[] = 'view=' . urlencode($view); }
    $to = 'documents.php' . (count($qs) ? ('?' . implode('&', $qs)) : '');
    header('Location: ' . $to);
    exit;
}

$cat_q = mysqli_query($con, "SELECT c.id, c.name, COALESCE(d.cnt,0) AS cnt
  FROM document_categories c
  LEFT JOIN (SELECT category_id, COUNT(*) AS cnt FROM documents GROUP BY category_id) d
  ON d.category_id = c.id
  ORDER BY c.name ASC");
if ($cat_q) {
    while ($r = mysqli_fetch_assoc($cat_q)) {
        $cats[] = $r;
    }
}

if ($cat_id > 0) {
    $ac_q = mysqli_query($con, "SELECT name FROM document_categories WHERE id=$cat_id LIMIT 1");
    $ac = $ac_q ? mysqli_fetch_assoc($ac_q) : null;
    $active_cat_name = $ac ? (string)$ac['name'] : '';
    if (strlen($active_cat_name) < 1) { $cat_id = 0; }
}

$docs = array();
$where = "1=1";
if ($cat_id > 0) {
    $where .= " AND category_id=$cat_id";
}
$docs_q = mysqli_query($con, "SELECT d.*, c.name AS category_name FROM documents d LEFT JOIN document_categories c ON c.id=d.category_id WHERE $where ORDER BY d.id DESC LIMIT 200");
if ($docs_q) {
    while ($r = mysqli_fetch_assoc($docs_q)) {
        $docs[] = $r;
    }
}

$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
$basePath = isset($_SERVER['SCRIPT_NAME']) ? rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'])), '/') : '';
$publicBase = $scheme . '://' . $host . $basePath;
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Documents</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                <li class="breadcrumb-item active">Documents</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php
      if (!empty($errormsg)) { print $errormsg; }
      if (!empty($successmsg)) { print $successmsg; }
      ?>

      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header d-flex flex-wrap align-items-center">
              <h5 class="card-title mb-0">Folders</h5>
              <div class="ms-auto d-flex gap-2">
                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#addDocumentModal">Add Document</button>
                <a href="document-categories.php" class="btn btn-sm btn-soft-primary">Categories</a>
                <a href="documents.php?<?php print ($cat_id>0?'cat='.(int)$cat_id.'&':''); ?>view=grid" class="btn btn-sm <?php print ($view==='grid'?'btn-warning text-white':'btn-soft-secondary'); ?>">Grid</a>
                <a href="documents.php?<?php print ($cat_id>0?'cat='.(int)$cat_id.'&':''); ?>view=list" class="btn btn-sm <?php print ($view==='list'?'btn-warning text-white':'btn-soft-secondary'); ?>">List</a>
              </div>
            </div>
            <div class="card-body">
              <?php if (count($cats) < 1) { ?>
                <div class="alert alert-warning mb-0">Create document categories first.</div>
              <?php } else { ?>
                <div class="row">
                  <?php foreach ($cats as $c) {
                      $id = (int)$c['id'];
                      $nm = htmlspecialchars($c['name']);
                      $cnt = (int)$c['cnt'];
                      $active = $cat_id === $id ? ' border border-primary' : '';
                      print "<div class='col-12 col-md-6 col-xl-4 mb-3'>";
                      print "<a class='text-decoration-none text-reset' href='documents.php?cat=$id&view=$view'>";
                      print "<div class='card mb-0$active' style='cursor:pointer;'>";
                      print "<div class='card-body d-flex align-items-center'>";
                      print "<div class='avatar-sm me-3'><span class='avatar-title bg-light text-primary rounded-circle fs-3'><i class='ri-folder-3-line'></i></span></div>";
                      print "<div class='flex-grow-1'><div class='fw-semibold'>$nm</div><div class='text-muted fs-12'>$cnt items</div></div>";
                      print "</div></div></a></div>";
                  } ?>
                </div>
              <?php } ?>
            </div>
          </div>

          <div class="card">
            <div class="card-header d-flex flex-wrap align-items-center gap-2">
              <h5 class="card-title mb-0"><?php print $cat_id > 0 ? htmlspecialchars($active_cat_name) : 'All Documents'; ?></h5>
              <!-- Bulk delete bar (hidden until at least one item is checked) -->
              <form method="post" id="bulkDeleteForm" class="d-inline ms-1">
                <input type="hidden" name="bulk_delete_docs" value="">
                <!-- individual hidden inputs injected by JS -->
                <span id="bulkBar" class="d-none align-items-center gap-2">
                  <span class="text-muted fs-12" id="bulkCount"></span>
                  <button type="submit" class="btn btn-sm btn-danger" id="bulkDeleteBtn">Delete Selected</button>
                </span>
              </form>
              <div class="ms-auto d-flex align-items-center gap-2">
                <div class="form-check mb-0" id="selectAllWrap">
                  <input class="form-check-input" type="checkbox" id="selectAllDocs">
                  <label class="form-check-label text-muted fs-12" for="selectAllDocs">All</label>
                </div>
                <input type="text" class="form-control form-control-sm" id="docSearch" placeholder="Search documents..." style="min-width:200px;">
              </div>
            </div>
            <div class="card-body">
              <?php if ($view === 'grid') { ?>
                <div class="row" id="docsGrid">
                  <?php
                  if (count($docs) < 1) {
                      print "<div class='col-12'><div class='text-center text-muted py-4'>No documents found.</div></div>";
                  }
                  foreach ($docs as $d) {
                      $id = (int)$d['id'];
                      $title = htmlspecialchars($d['title']);
                      $catn = htmlspecialchars((string)$d['category_name']);
                      $type = htmlspecialchars($d['doc_type']);
                      $created = htmlspecialchars((string)$d['created_at']);

                      $open = '';
                      $shareUrl = '';
                      $fileExt = '';
                      if ($d['doc_type'] === 'file' && !empty($d['file_name'])) {
                          $rel = ltrim(str_replace('\\', '/', (string)$d['file_name']), '/');
                          $parts = explode('/', $rel);
                          $encParts = array();
                          foreach ($parts as $p) {
                              if ($p === '') { continue; }
                              $encParts[] = rawurlencode($p);
                          }
                          $fn = implode('/', $encParts);
                          $open = "uploads/documents/$fn";
                          $shareUrl = $publicBase . "/uploads/documents/$fn";
                          $fileExt = strtolower(pathinfo($rel, PATHINFO_EXTENSION));
                      }
                      if ($d['doc_type'] === 'link' && !empty($d['link_url'])) {
                          $open = $d['link_url'];
                          $shareUrl = $open;
                      }
                      $open_h = htmlspecialchars($open);
                      $share_h = htmlspecialchars($shareUrl);
                      $wa = strlen($shareUrl) ? ('https://wa.me/?text=' . rawurlencode($shareUrl)) : '';
                      $wa_h = htmlspecialchars($wa);
                      $em = strlen($shareUrl) ? ('mailto:?subject=' . rawurlencode('Document: ' . $d['title']) . '&body=' . rawurlencode($shareUrl)) : '';
                      $em_h = htmlspecialchars($em);

                      print "<div class='col-12 col-md-6 col-xl-4 mb-3 doc-item'>";
                      print "<div class='card mb-0 border border-warning' style='border-width:2px !important;'>";
                      print "<div class='card-body'>";
                      print "<div class='d-flex align-items-start'>";
                      print "<div class='form-check me-2'><input class='form-check-input doc-checkbox' type='checkbox' value='$id'></div>";
                      print "<div class='avatar-sm me-3'><span class='avatar-title bg-light text-primary rounded-circle fs-3'><i class='ri-file-2-line'></i></span></div>";
                      print "<div class='flex-grow-1'>";
                      print "<div class='fw-semibold doc-title'>$title</div>";
                      print "<div class='text-muted fs-12'>" . $catn . " • " . $type . "</div>";
                      print "<div class='text-muted fs-12'>" . $created . "</div>";
                      print "</div>";
                      print "</div>";

                      if ($d['doc_type'] === 'file' && strlen($open) > 0) {
                          $isImg = in_array($fileExt, array('jpg','jpeg','png','gif','webp','bmp','svg'));
                          $isPdf = ($fileExt === 'pdf');
                          print "<div class='mt-3 rounded border bg-light' style='overflow:hidden;'>";
                          if ($isImg) {
                              print "<a href='$open_h' target='_blank' class='d-block' style='line-height:0;'>";
                              print "<img src='$open_h' alt='' style='width:100%;height:140px;object-fit:cover;display:block;'>";
                              print "</a>";
                          } elseif ($isPdf) {
                              print "<iframe src='$open_h' style='width:100%;height:160px;border:0;display:block;background:#fff;' loading='lazy'></iframe>";
                          } else {
                              print "<div class='d-flex align-items-center justify-content-center text-muted' style='height:120px;'>No preview</div>";
                          }
                          print "</div>";
                      }

                      print "<div class='d-flex flex-wrap gap-2 mt-3 position-relative' style='z-index:2;'>";
                      if (strlen($open) > 0) {
                          print "<a class='btn btn-sm btn-soft-primary' href='$open_h' target='_blank'>Open</a>";
                      }
                      if (strlen($wa) > 0) {
                          print "<a class='btn btn-sm btn-soft-success' href='$wa_h' target='_blank' rel='noopener' title='WhatsApp'><i class='ri-whatsapp-line'></i></a>";
                          print "<button type='button' class='btn btn-sm btn-soft-secondary js-email-doc' data-title='" . htmlspecialchars($d['title']) . "' data-url='$share_h' data-id='$id' title='Email'><i class='ri-mail-line'></i></button>";
                          print "<button type='button' class='btn btn-sm btn-soft-info js-copy-link' data-url='$share_h' title='Copy link'><i class='ri-link'></i></button>";
                          if ($d['doc_type'] === 'file') {
                              print "<a class='btn btn-sm btn-soft-dark' href='$share_h' download title='Download'><i class='ri-download-2-line'></i></a>";
                          }
                      }
                      $orig_btn = htmlspecialchars((string)$d['original_name']);
                      $dtype_btn = htmlspecialchars((string)$d['doc_type']);
                      print "<button type='button' class='btn btn-sm btn-soft-warning js-rename-doc' data-id='$id' data-title='" . htmlspecialchars((string)$d['title']) . "' data-orig='$orig_btn' data-type='$dtype_btn'>Rename</button>";
                      print "<form method='post' class='d-inline' onsubmit=\"return confirm('Delete this document?');\">";
                      print "<input type='hidden' name='delete_doc_id' value='$id'>";
                      print "<button type='submit' class='btn btn-sm btn-soft-danger'>Delete</button>";
                      print "</form>";
                      print "</div>";

                      print "</div></div></div>";
                  }
                  ?>
                </div>
              <?php } else { ?>
                <div class="table-responsive">
                  <table class="table table-striped table-sm align-middle mb-0" id="docsTable">
                    <thead>
                      <tr>
                        <th style="width:36px;"><input class="form-check-input" type="checkbox" id="selectAllList"></th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Uploaded</th>
                        <th class="text-end">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <?php
                      if (count($docs) < 1) {
                          print "<tr><td colspan='6' class='text-center text-muted'>No documents found.</td></tr>";
                      }
                      foreach ($docs as $d) {
                          $id = (int)$d['id'];
                          $title = htmlspecialchars($d['title']);
                          $catn = htmlspecialchars((string)$d['category_name']);
                          $type = htmlspecialchars($d['doc_type']);
                          $created = htmlspecialchars((string)$d['created_at']);

                          $open = '';
                          $shareUrl = '';
                          $fileExt = '';
                          if ($d['doc_type'] === 'file' && !empty($d['file_name'])) {
                              $rel = ltrim(str_replace('\\', '/', (string)$d['file_name']), '/');
                              $parts = explode('/', $rel);
                              $encParts = array();
                              foreach ($parts as $p) {
                                  if ($p === '') { continue; }
                                  $encParts[] = rawurlencode($p);
                              }
                              $fn = implode('/', $encParts);
                              $open = "uploads/documents/$fn";
                              $shareUrl = $publicBase . "/uploads/documents/$fn";
                              $fileExt = strtolower(pathinfo($rel, PATHINFO_EXTENSION));
                          }
                          if ($d['doc_type'] === 'link' && !empty($d['link_url'])) {
                              $open = $d['link_url'];
                              $shareUrl = $open;
                          }
                          $open_h = htmlspecialchars($open);
                          $share_h = htmlspecialchars($shareUrl);
                          $wa = strlen($shareUrl) ? ('https://wa.me/?text=' . rawurlencode($shareUrl)) : '';
                          $wa_h = htmlspecialchars($wa);
                          $em = strlen($shareUrl) ? ('mailto:?subject=' . rawurlencode('Document: ' . $d['title']) . '&body=' . rawurlencode($shareUrl)) : '';
                          $em_h = htmlspecialchars($em);

                          print "<tr>";
                          print "<td><input class='form-check-input doc-checkbox' type='checkbox' value='$id'></td>";
                          if ($d['doc_type'] === 'file' && strlen($open) > 0 && in_array($fileExt, array('jpg','jpeg','png','gif','webp','bmp','svg'))) {
                              print "<td data-search='$title'><a href='$open_h' target='_blank' class='text-decoration-none'><img src='$open_h' alt='' style='width:34px;height:34px;object-fit:cover;border-radius:6px;margin-right:8px;border:1px solid #e5e7eb;vertical-align:middle;'><span style='vertical-align:middle;'>$title</span></a></td>";
                          } elseif ($d['doc_type'] === 'file' && strlen($open) > 0 && $fileExt === 'pdf') {
                              print "<td data-search='$title'><a href='$open_h' target='_blank' class='text-decoration-none'><span class='badge bg-danger-subtle text-danger me-2'>PDF</span>$title</a></td>";
                          } else {
                              print "<td data-search='$title'>$title</td>";
                          }
                          print "<td>$catn</td>";
                          print "<td>$type</td>";
                          print "<td>$created</td>";
                          print "<td class='text-end position-relative' style='z-index:2;'>";
                          if (strlen($open) > 0) {
                              print "<a class='btn btn-sm btn-soft-primary' href='$open_h' target='_blank'>Open</a> ";
                          }
                          if (strlen($wa) > 0) {
                              print "<a class='btn btn-sm btn-soft-success' href='$wa_h' target='_blank' rel='noopener' title='WhatsApp'><i class='ri-whatsapp-line'></i></a> ";
                              print "<button type='button' class='btn btn-sm btn-soft-secondary js-email-doc' data-title='" . htmlspecialchars($d['title']) . "' data-url='$share_h' data-id='$id' title='Email'><i class='ri-mail-line'></i></button> ";
                              print "<button type='button' class='btn btn-sm btn-soft-info js-copy-link' data-url='$share_h' title='Copy link'><i class='ri-link'></i></button> ";
                              if ($d['doc_type'] === 'file') {
                                  print "<a class='btn btn-sm btn-soft-dark' href='$share_h' download title='Download'><i class='ri-download-2-line'></i></a> ";
                              }
                          }
                          $orig_btn = htmlspecialchars((string)$d['original_name']);
                          $dtype_btn = htmlspecialchars((string)$d['doc_type']);
                          print "<button type='button' class='btn btn-sm btn-soft-warning js-rename-doc' data-id='$id' data-title='" . htmlspecialchars((string)$d['title']) . "' data-orig='$orig_btn' data-type='$dtype_btn'>Rename</button> ";
                          print "<form method='post' class='d-inline' onsubmit=\"return confirm('Delete this document?');\">";
                          print "<input type='hidden' name='delete_doc_id' value='$id'>";
                          print "<button type='submit' class='btn btn-sm btn-soft-danger'>Delete</button>";
                          print "</form>";
                          print "</td>";
                          print "</tr>";
                      }
                      ?>
                    </tbody>
                  </table>
                </div>
              <?php } ?>
            </div>
          </div>

          <div class="modal fade" id="addDocumentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Add Document</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form method="post" enctype="multipart/form-data" id="addDocumentForm">
                    <input type="hidden" name="upload_doc" value="1">

                    <div class="row g-3">
                      <div class="col-12" id="title_box">
                        <label class="form-label" for="title">Title <span class="text-muted fw-normal" id="title_hint">(optional when uploading multiple files)</span></label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="e.g. Company Policy">
                        <div class="form-text" id="title_sub">Leave blank to use each file's name as the title.</div>
                      </div>

                      <div class="col-12">
                        <label class="form-label" for="category_id">Category</label>
                        <select class="form-select" id="category_id" name="category_id" required>
                          <option value="">Select category</option>
                          <?php
                          foreach ($cats as $c) {
                              $id = (int)$c['id'];
                              $nm = htmlspecialchars($c['name']);
                              $sel = $cat_id === $id ? ' selected' : '';
                              print "<option value='$id'$sel>$nm</option>";
                          }
                          ?>
                        </select>
                      </div>

                      <div class="col-12">
                        <label class="form-label">Type</label>
                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="doc_type" id="type_file" value="file" checked>
                          <label class="form-check-label" for="type_file">File upload</label>
                        </div>
                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="doc_type" id="type_link" value="link">
                          <label class="form-check-label" for="type_link">Link</label>
                        </div>
                      </div>

                      <div class="col-12" id="file_box">
                        <label class="form-label" for="doc_file">Files</label>
                        <input class="form-control" type="file" id="doc_file" name="doc_file[]" multiple>
                        <div class="form-text">Any file type is allowed. You can select multiple files at once.</div>
                        <div id="file_preview" class="mt-2" style="display:none;">
                          <div class="fw-semibold fs-12 text-muted mb-1" id="file_preview_count"></div>
                          <ul class="list-unstyled mb-0" id="file_preview_list" style="max-height:140px;overflow-y:auto;font-size:13px;"></ul>
                        </div>
                      </div>

                      <div class="col-12 d-none" id="link_box">
                        <label class="form-label" for="link_url">Link URL</label>
                        <input class="form-control" type="url" id="link_url" name="link_url" placeholder="https://...">
                      </div>
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" form="addDocumentForm" class="btn btn-primary">Save</button>
                </div>
              </div>
            </div>
          </div>

          <div class="modal fade" id="renameDocModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Rename Document</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form method="post" id="renameDocForm">
                    <input type="hidden" name="rename_doc_id" id="rename_doc_id" value="0">
                    <input type="hidden" id="rename_doc_type" value="">

                    <div class="mb-3">
                      <label class="form-label" for="rename_title">Title</label>
                      <input type="text" class="form-control" name="rename_title" id="rename_title" required>
                    </div>

                    <div class="mb-0" id="rename_original_wrap">
                      <label class="form-label" for="rename_original_name">File name (display)</label>
                      <input type="text" class="form-control" name="rename_original_name" id="rename_original_name" placeholder="e.g. policy.pdf">
                      <div class="form-text">This does not change the stored file path, only the displayed name.</div>
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" form="renameDocForm" class="btn btn-primary">Save</button>
                </div>
              </div>
            </div>
          </div>

          <div class="modal fade" id="emailDocModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Send Document</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form id="emailDocForm">
                    <input type="hidden" name="send_doc_email" value="1">
                    <input type="hidden" name="doc_kind" id="email_doc_kind" value="document">
                    <input type="hidden" name="doc_id" id="email_doc_id" value="0">
                    <input type="hidden" name="doc_title" id="email_doc_title" value="">
                    <input type="hidden" name="doc_url" id="email_doc_url" value="">

                    <div class="mb-3">
                      <label class="form-label" for="email_to">To (comma separated)</label>
                      <input type="text" class="form-control" id="email_to" name="to_emails" placeholder="name@example.com, other@example.com" required>
                    </div>

                    <div class="mb-0">
                      <label class="form-label" for="email_msg">Message (optional)</label>
                      <textarea class="form-control" id="email_msg" name="message" rows="3"></textarea>
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" form="emailDocForm" class="btn btn-primary" id="emailDocSendBtn">Send</button>
                </div>
              </div>
            </div>
          </div>

          <div class="modal fade" id="successCenterModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-body text-center py-4">
                  <div class="mb-3">
                    <span class="avatar-lg rounded-circle bg-success-subtle text-success d-inline-flex align-items-center justify-content-center" style="width:84px;height:84px;">
                      <i class="ri-check-line" style="font-size:48px;"></i>
                    </span>
                  </div>
                  <h5 class="mb-0" id="successCenterText">Done</h5>
                </div>
              </div>
            </div>
          </div>

          <!-- Bulk delete confirmation modal -->
          <div class="modal fade px-4" id="bulkDeleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content border-0 shadow-lg">
                <div class="modal-body text-center p-5">
                  <div class="mb-4">
                    <i class="ri-delete-bin-line text-danger display-3"></i>
                  </div>
                  <h4 class="mb-3 text-dark fw-bold">Delete <span id="bulkDeleteConfirmCount">0</span> Selected Documents?</h4>
                  <p class="text-muted fs-15 mb-4">This action cannot be undone. Are you sure you want to permanently delete these items?</p>
                  <div class="d-flex justify-content-center gap-3">
                    <button type="button" class="btn btn-light btn-lg px-4 fw-medium" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger btn-lg px-4 fw-bold" id="bulkDeleteConfirmBtn">Yes, Delete All</button>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

    </div>
  </div>
  <?php include "footer.php"; ?>
</div>

<script>
(function(){
  function showErrorToast(message) {
    var existing = document.getElementById('docToast');
    if (!existing) {
      var wrap = document.createElement('div');
      wrap.className = 'toast-container position-fixed top-0 end-0 p-3';
      wrap.style.zIndex = '11000';
      wrap.innerHTML = "<div id='docToast' class='toast align-items-center text-bg-danger border-0' role='alert' aria-live='assertive' aria-atomic='true'><div class='d-flex'><div class='toast-body'></div><button type='button' class='btn-close btn-close-white me-2 m-auto' data-bs-dismiss='toast' aria-label='Close'></button></div></div>";
      document.body.appendChild(wrap);
      existing = document.getElementById('docToast');
    }
    var body = existing.querySelector('.toast-body');
    if (body) { body.textContent = message; }
    var t = bootstrap.Toast.getOrCreateInstance(existing, { delay: 2500 });
    t.show();
  }

  var successModalEl = document.getElementById('successCenterModal');
  var successModalText = document.getElementById('successCenterText');
  var successModal = null;
  var successTimer = null;
  if (successModalEl) {
    successModal = new bootstrap.Modal(successModalEl);
  }

  function showSuccessModal(message) {
    if (!successModal) return;
    if (successModalText) { successModalText.textContent = message; }
    successModal.show();
    if (successTimer) { clearTimeout(successTimer); }
    successTimer = setTimeout(function(){
      try { successModal.hide(); } catch (e) {}
    }, 1400);
  }

  function showToast(message, type) {
    if ((type || 'success') === 'success') {
      showSuccessModal(message);
      return;
    }
    showErrorToast(message);
  }

  var fileRadio = document.getElementById('type_file');
  var linkRadio = document.getElementById('type_link');
  var fileBox = document.getElementById('file_box');
  var linkBox = document.getElementById('link_box');
  var titleBox = document.getElementById('title_box');
  var titleHint = document.getElementById('title_hint');
  var titleSub = document.getElementById('title_sub');
  var titleInput = document.getElementById('title');
  var docFileInput = document.getElementById('doc_file');
  var filePreview = document.getElementById('file_preview');
  var filePreviewCount = document.getElementById('file_preview_count');
  var filePreviewList = document.getElementById('file_preview_list');

  function updateTitleHint() {
    if (!titleInput) return;
    var isLink = linkRadio && linkRadio.checked;
    if (isLink) {
      // Link mode: title required
      titleInput.setAttribute('required', 'required');
      if (titleHint) titleHint.style.display = 'none';
      if (titleSub) titleSub.style.display = 'none';
    } else {
      titleInput.removeAttribute('required');
      if (titleHint) titleHint.style.display = '';
      if (titleSub) titleSub.style.display = '';
    }
  }

  if (fileRadio && linkRadio && fileBox && linkBox) {
    function toggle(){
      if (linkRadio.checked) {
        fileBox.classList.add('d-none');
        linkBox.classList.remove('d-none');
      } else {
        fileBox.classList.remove('d-none');
        linkBox.classList.add('d-none');
      }
      updateTitleHint();
    }
    fileRadio.addEventListener('change', toggle);
    linkRadio.addEventListener('change', toggle);
    toggle();
  }

  // File preview – show list of selected filenames
  if (docFileInput) {
    docFileInput.addEventListener('change', function() {
      var files = docFileInput.files;
      if (!filePreview || !filePreviewCount || !filePreviewList) return;
      if (!files || files.length === 0) {
        filePreview.style.display = 'none';
        return;
      }
      filePreviewCount.textContent = files.length === 1 ? '1 file selected' : files.length + ' files selected';
      filePreviewList.innerHTML = '';
      for (var i = 0; i < files.length; i++) {
        var li = document.createElement('li');
        li.className = 'd-flex align-items-center gap-1 py-1 border-bottom';
        li.innerHTML = '<i class="ri-file-2-line text-primary"></i><span class="text-truncate">' + files[i].name + '</span>';
        filePreviewList.appendChild(li);
      }
      filePreview.style.display = '';
      // If only one file, suggest using its name in the title field if blank
      if (files.length === 1 && titleInput && titleInput.value.trim() === '') {
        var suggestedName = files[0].name.replace(/\.[^/.]+$/, '');
        titleInput.placeholder = suggestedName;
      } else if (titleInput) {
        titleInput.placeholder = 'e.g. Company Policy';
      }
    });
  }

  // Reset file preview when modal is closed
  var addDocModalEl = document.getElementById('addDocumentModal');
  if (addDocModalEl) {
    addDocModalEl.addEventListener('hidden.bs.modal', function() {
      if (docFileInput) docFileInput.value = '';
      if (filePreview) filePreview.style.display = 'none';
      if (filePreviewList) filePreviewList.innerHTML = '';
      if (titleInput) { titleInput.value = ''; titleInput.placeholder = 'e.g. Company Policy'; }
    });
  }

  var input = document.getElementById('docSearch');
  var table = document.getElementById('docsTable');
  if (input && table) {
    input.addEventListener('input', function(){
      var q = (input.value || '').toLowerCase();
      var rows = table.querySelectorAll('tbody tr');
      rows.forEach(function(tr){
        var text = tr.innerText.toLowerCase();
        tr.style.display = text.indexOf(q) !== -1 ? '' : 'none';
      });
    });
  }

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-copy-link') : null;
    if (!btn) return;
    e.preventDefault();
    var url = btn.getAttribute('data-url') || '';
    if (!url) return;

    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(url)
        .then(function(){
          showToast('Link copied', 'success');
        })
        .catch(function(){
          showToast('Copy failed', 'danger');
        });
      return;
    }

    var ta = document.createElement('textarea');
    ta.value = url;
    ta.style.position = 'fixed';
    ta.style.left = '-9999px';
    document.body.appendChild(ta);
    ta.select();
    try { document.execCommand('copy'); } catch (err) {}
    document.body.removeChild(ta);

    showToast('Link copied', 'success');
  });

  var emailModalEl = document.getElementById('emailDocModal');
  var emailForm = document.getElementById('emailDocForm');
  var emailKind = document.getElementById('email_doc_kind');
  var emailId = document.getElementById('email_doc_id');
  var emailTitle = document.getElementById('email_doc_title');
  var emailUrl = document.getElementById('email_doc_url');
  var emailTo = document.getElementById('email_to');
  var emailBtn = document.getElementById('emailDocSendBtn');
  var emailModal = null;
  if (emailModalEl) {
    emailModal = new bootstrap.Modal(emailModalEl);
  }

  var renameModalEl = document.getElementById('renameDocModal');
  var renameModal = null;
  if (renameModalEl) {
    renameModal = new bootstrap.Modal(renameModalEl);
  }
  var renameId = document.getElementById('rename_doc_id');
  var renameType = document.getElementById('rename_doc_type');
  var renameTitle = document.getElementById('rename_title');
  var renameOrigWrap = document.getElementById('rename_original_wrap');
  var renameOrig = document.getElementById('rename_original_name');

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-rename-doc') : null;
    if (!btn || !renameModal) return;
    e.preventDefault();
    var id = btn.getAttribute('data-id') || '0';
    var title = btn.getAttribute('data-title') || '';
    var orig = btn.getAttribute('data-orig') || '';
    var type = btn.getAttribute('data-type') || '';
    if (renameId) renameId.value = id;
    if (renameType) renameType.value = type;
    if (renameTitle) renameTitle.value = title;
    if (renameOrig) renameOrig.value = orig;
    if (renameOrigWrap) {
      if ((type || '').toLowerCase() === 'file') {
        renameOrigWrap.classList.remove('d-none');
      } else {
        renameOrigWrap.classList.add('d-none');
        if (renameOrig) renameOrig.value = '';
      }
    }
    renameModal.show();
  });

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-email-doc') : null;
    if (!btn || !emailModal) return;
    e.preventDefault();
    var title = btn.getAttribute('data-title') || 'Document';
    var url = btn.getAttribute('data-url') || '';
    var id = btn.getAttribute('data-id') || '0';
    if (emailTitle) emailTitle.value = title;
    if (emailUrl) emailUrl.value = url;
    if (emailKind) emailKind.value = 'document';
    if (emailId) emailId.value = id;
    if (emailTo) emailTo.value = '';
    var msg = document.getElementById('email_msg');
    if (msg) msg.value = '';
    emailModal.show();
  });

  if (emailForm) {
    emailForm.addEventListener('submit', function(ev){
      ev.preventDefault();
      var oldTxt = emailBtn ? emailBtn.textContent : '';
      if (emailBtn) {
        emailBtn.disabled = true;
        emailBtn.textContent = 'Sending...';
      }
      var fd = new FormData(emailForm);
      setTimeout(function(){
        fetch('documents.php', { method: 'POST', body: fd })
          .then(function(r){ return r.json(); })
          .then(function(data){
            if (emailBtn) {
              emailBtn.disabled = false;
              emailBtn.textContent = oldTxt;
            }
            if (data && data.status === 'success') {
              showToast('Email sent', 'success');
              if (emailModal) {
                setTimeout(function(){ try { emailModal.hide(); } catch(e){} }, 650);
              }
            } else {
              showToast((data && data.message) ? data.message : 'Failed to send email', 'danger');
            }
          })
          .catch(function(){
            if (emailBtn) {
              emailBtn.disabled = false;
              emailBtn.textContent = oldTxt;
            }
            showToast('Failed to send email', 'danger');
          });
      }, 10);
    });
  }

  var grid = document.getElementById('docsGrid');
  if (input && grid) {
    input.addEventListener('input', function(){
      var q = (input.value || '').toLowerCase();
      var cards = grid.querySelectorAll('.doc-item');
      cards.forEach(function(el){
        var text = el.innerText.toLowerCase();
        el.style.display = text.indexOf(q) !== -1 ? '' : 'none';
      });
    });
  }

  // Multi-delete logic
  var bulkBar = document.getElementById('bulkBar');
  var bulkCountTxt = document.getElementById('bulkCount');
  var bulkForm = document.getElementById('bulkDeleteForm');
  var selectAllGrid = document.getElementById('selectAllDocs');
  var selectAllList = document.getElementById('selectAllList');

  function updateBulkBar() {
    var checkboxes = document.querySelectorAll('.doc-checkbox:checked');
    var count = checkboxes.length;
    if (count > 0) {
      if (bulkBar) bulkBar.classList.replace('d-none', 'd-flex');
      if (bulkCountTxt) bulkCountTxt.textContent = count + (count === 1 ? ' item' : ' items') + ' selected';
    } else {
      if (bulkBar) bulkBar.classList.replace('d-flex', 'd-none');
    }
  }

  document.addEventListener('change', function(e){
    if (e.target && e.target.classList.contains('doc-checkbox')) {
      updateBulkBar();
    }
  });

  if (selectAllGrid) {
    selectAllGrid.addEventListener('change', function(){
      var state = selectAllGrid.checked;
      document.querySelectorAll('.doc-checkbox').forEach(function(cb){
        cb.checked = state;
      });
      if (selectAllList) selectAllList.checked = state;
      updateBulkBar();
    });
  }
  if (selectAllList) {
    selectAllList.addEventListener('change', function(){
      var state = selectAllList.checked;
      document.querySelectorAll('.doc-checkbox').forEach(function(cb){
        cb.checked = state;
      });
      if (selectAllGrid) selectAllGrid.checked = state;
      updateBulkBar();
    });
  }

  if (bulkForm) {
    bulkForm.addEventListener('submit', function(e){
      e.preventDefault();
      var checked = document.querySelectorAll('.doc-checkbox:checked');
      if (checked.length < 1) return;

      var bdm = document.getElementById('bulkDeleteConfirmModal');
      var bdc = document.getElementById('bulkDeleteConfirmCount');
      if (bdm && bdc) {
        bdc.textContent = checked.length;
        var modal = new bootstrap.Modal(bdm);
        modal.show();

        var confirmBtn = document.getElementById('bulkDeleteConfirmBtn');
        if (confirmBtn) {
          confirmBtn.onclick = function() {
            confirmBtn.disabled = true;
            confirmBtn.textContent = 'Deleting...';
            // Inject hidden inputs
            checked.forEach(function(cb){
              var hid = document.createElement('input');
              hid.type = 'hidden';
              hid.name = 'bulk_delete_docs[]';
              hid.value = cb.value;
              bulkForm.appendChild(hid);
            });
            bulkForm.submit();
          };
        }
      }
    });
  }
})();
</script>
