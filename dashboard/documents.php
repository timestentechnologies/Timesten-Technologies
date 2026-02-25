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

    $to_raw = isset($_POST['to_emails']) ? trim((string)$_POST['to_emails']) : '';
    $doc_title = isset($_POST['doc_title']) ? trim((string)$_POST['doc_title']) : 'Document';
    $doc_url = isset($_POST['doc_url']) ? trim((string)$_POST['doc_url']) : '';
    $extra_msg = isset($_POST['message']) ? trim((string)$_POST['message']) : '';

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
    $logo_html = '';
    if (strlen(trim($logo_url)) > 5) {
        $logo_html = "<div style='text-align:center;margin-bottom:16px;'><img src='" . htmlspecialchars($logo_url) . "' alt='Logo' style='max-width:170px;height:auto;'></div>";
    }
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
    $body .= "<div style='font-size:14px;color:#6b7280;margin-bottom:14px;'>" . htmlspecialchars($from_name) . "</div>";
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
    $body .= "This email was sent from " . htmlspecialchars($from_name) . ".</div>";
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
            $mail->isHTML(true);
            $mail->Subject = $subject;
            $mail->Body = $body;
            $mail->AltBody = $doc_title . "\n" . $doc_url . (strlen($extra_msg) ? ("\n\n" . $extra_msg) : '');
            $sent = $mail->send();
        } elseif (file_exists($BASE_DIR . '/../PHPMailer/PHPMailerAutoload.php')) {
            require_once $BASE_DIR . '/../PHPMailer/PHPMailerAutoload.php';
            $mail = new PHPMailer();
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

    if (strlen($title) < 2) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Title is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($category_id < 1) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Please select a category.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($doc_type === 'link' && strlen($link_url) < 5) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Link URL is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($doc_type === 'file') {
        if (!isset($_FILES['doc_file']) || $_FILES['doc_file']['error'] !== UPLOAD_ERR_OK) {
            $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>File is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $uploads_dir = dirname(__FILE__) . '/uploads/documents';
            if (!is_dir($uploads_dir)) {
                @mkdir($uploads_dir, 0775, true);
            }

            $tmp_name = $_FILES['doc_file']['tmp_name'];
            $original_name = basename($_FILES['doc_file']['name']);
            $safe_original = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
            $random_digit = rand(1000, 9999);
            $file_name = $random_digit . '_' . $safe_original;

            if (!move_uploaded_file($tmp_name, $uploads_dir . '/' . $file_name)) {
                $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>File upload failed.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } else {
                $title_s = mysqli_real_escape_string($con, $title);
                $file_s = mysqli_real_escape_string($con, $file_name);
                $orig_s = mysqli_real_escape_string($con, $original_name);
                $uploader_s = mysqli_real_escape_string($con, $username);
                mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, created_at) VALUES ($category_id, '$title_s', 'file', '$file_s', '$orig_s', NULL, '$uploader_s', NOW())");
                $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Document uploaded.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            }
        }
    } else {
        $title_s = mysqli_real_escape_string($con, $title);
        $link_s = mysqli_real_escape_string($con, $link_url);
        $uploader_s = mysqli_real_escape_string($con, $username);
        mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, created_at) VALUES ($category_id, '$title_s', 'link', NULL, NULL, '$link_s', '$uploader_s', NOW())");
        $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Link saved.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
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
            <div class="card-header d-flex flex-wrap align-items-center">
              <h5 class="card-title mb-0"><?php print $cat_id > 0 ? htmlspecialchars($active_cat_name) : 'All Documents'; ?></h5>
              <div class="ms-auto" style="min-width:260px;">
                <input type="text" class="form-control" id="docSearch" placeholder="Search documents...">
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
                      if ($d['doc_type'] === 'file' && !empty($d['file_name'])) {
                          $fn = rawurlencode($d['file_name']);
                          $open = "uploads/documents/$fn";
                          $shareUrl = $publicBase . "/uploads/documents/$fn";
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
                      print "<div class='avatar-sm me-3'><span class='avatar-title bg-light text-primary rounded-circle fs-3'><i class='ri-file-2-line'></i></span></div>";
                      print "<div class='flex-grow-1'>";
                      print "<div class='fw-semibold doc-title'>$title</div>";
                      print "<div class='text-muted fs-12'>" . $catn . " • " . $type . "</div>";
                      print "<div class='text-muted fs-12'>" . $created . "</div>";
                      print "</div>";
                      print "</div>";

                      print "<div class='d-flex flex-wrap gap-2 mt-3 position-relative' style='z-index:2;'>";
                      if (strlen($open) > 0) {
                          print "<a class='btn btn-sm btn-soft-primary' href='$open_h' target='_blank'>Open</a>";
                      }
                      if (strlen($wa) > 0) {
                          print "<a class='btn btn-sm btn-soft-success' href='$wa_h' target='_blank' rel='noopener' title='WhatsApp'><i class='ri-whatsapp-line'></i></a>";
                          print "<button type='button' class='btn btn-sm btn-soft-secondary js-email-doc' data-title='" . htmlspecialchars($d['title']) . "' data-url='$share_h' title='Email'><i class='ri-mail-line'></i></button>";
                          print "<button type='button' class='btn btn-sm btn-soft-info js-copy-link' data-url='$share_h' title='Copy link'><i class='ri-link'></i></button>";
                          if ($d['doc_type'] === 'file') {
                              print "<a class='btn btn-sm btn-soft-dark' href='$share_h' download title='Download'><i class='ri-download-2-line'></i></a>";
                          }
                      }
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
                          print "<tr><td colspan='5' class='text-center text-muted'>No documents found.</td></tr>";
                      }
                      foreach ($docs as $d) {
                          $id = (int)$d['id'];
                          $title = htmlspecialchars($d['title']);
                          $catn = htmlspecialchars((string)$d['category_name']);
                          $type = htmlspecialchars($d['doc_type']);
                          $created = htmlspecialchars((string)$d['created_at']);

                          $open = '';
                          $shareUrl = '';
                          if ($d['doc_type'] === 'file' && !empty($d['file_name'])) {
                              $fn = rawurlencode($d['file_name']);
                              $open = "uploads/documents/$fn";
                              $shareUrl = $publicBase . "/uploads/documents/$fn";
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
                          print "<td data-search='$title'>$title</td>";
                          print "<td>$catn</td>";
                          print "<td>$type</td>";
                          print "<td>$created</td>";
                          print "<td class='text-end position-relative' style='z-index:2;'>";
                          if (strlen($open) > 0) {
                              print "<a class='btn btn-sm btn-soft-primary' href='$open_h' target='_blank'>Open</a> ";
                          }
                          if (strlen($wa) > 0) {
                              print "<a class='btn btn-sm btn-soft-success' href='$wa_h' target='_blank' rel='noopener' title='WhatsApp'><i class='ri-whatsapp-line'></i></a> ";
                              print "<button type='button' class='btn btn-sm btn-soft-secondary js-email-doc' data-title='" . htmlspecialchars($d['title']) . "' data-url='$share_h' title='Email'><i class='ri-mail-line'></i></button> ";
                              print "<button type='button' class='btn btn-sm btn-soft-info js-copy-link' data-url='$share_h' title='Copy link'><i class='ri-link'></i></button> ";
                              if ($d['doc_type'] === 'file') {
                                  print "<a class='btn btn-sm btn-soft-dark' href='$share_h' download title='Download'><i class='ri-download-2-line'></i></a> ";
                              }
                          }
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
                      <div class="col-12">
                        <label class="form-label" for="title">Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="e.g. Company Policy" required>
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
                        <label class="form-label" for="doc_file">File</label>
                        <input class="form-control" type="file" id="doc_file" name="doc_file">
                        <div class="form-text">Any file type is allowed.</div>
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
  if (fileRadio && linkRadio && fileBox && linkBox) {
    function toggle(){
      if (linkRadio.checked) {
        fileBox.classList.add('d-none');
        linkBox.classList.remove('d-none');
      } else {
        fileBox.classList.remove('d-none');
        linkBox.classList.add('d-none');
      }
    }
    fileRadio.addEventListener('change', toggle);
    linkRadio.addEventListener('change', toggle);
    toggle();
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
  var emailTitle = document.getElementById('email_doc_title');
  var emailUrl = document.getElementById('email_doc_url');
  var emailTo = document.getElementById('email_to');
  var emailBtn = document.getElementById('emailDocSendBtn');
  var emailModal = null;
  if (emailModalEl) {
    emailModal = new bootstrap.Modal(emailModalEl);
  }

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-email-doc') : null;
    if (!btn || !emailModal) return;
    e.preventDefault();
    var title = btn.getAttribute('data-title') || 'Document';
    var url = btn.getAttribute('data-url') || '';
    if (emailTitle) emailTitle.value = title;
    if (emailUrl) emailUrl.value = url;
    if (emailTo) emailTo.value = '';
    var msg = document.getElementById('email_msg');
    if (msg) msg.value = '';
    emailModal.show();
  });

  if (emailForm) {
    emailForm.addEventListener('submit', function(ev){
      ev.preventDefault();
      if (emailBtn) {
        emailBtn.disabled = true;
        emailBtn.textContent = 'Sending...';
      }
      var fd = new FormData(emailForm);
      fetch('documents.php', { method: 'POST', body: fd })
        .then(function(r){ return r.json(); })
        .then(function(data){
          if (data && data.status === 'success') {
            showToast('Email sent', 'success');
            if (emailModal) emailModal.hide();
          } else {
            showToast((data && data.message) ? data.message : 'Failed to send email', 'danger');
          }
        })
        .catch(function(){
          showToast('Failed to send email', 'danger');
        })
        .finally(function(){
          if (emailBtn) {
            emailBtn.disabled = false;
            emailBtn.textContent = 'Send';
          }
        });
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
})();
</script>
