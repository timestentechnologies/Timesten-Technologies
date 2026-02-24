<?php
include"header.php";
include"sidebar.php";
$app_id = mysqli_real_escape_string($con, $_GET['id']);

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

mysqli_query($con, "CREATE TABLE IF NOT EXISTS employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(160) NOT NULL,
  email VARCHAR(160) NULL,
  phone VARCHAR(80) NULL,
  job_title VARCHAR(255) NULL,
  comp_type VARCHAR(30) NULL,
  comp_amount DECIMAL(12,2) NULL,
  hired_from_application_id INT NULL,
  cv_document_id INT NULL,
  created_at DATETIME NULL
)");

$col_comp_type = mysqli_query($con, "SHOW COLUMNS FROM employees LIKE 'comp_type'");
if (!$col_comp_type || mysqli_num_rows($col_comp_type) < 1) {
  @mysqli_query($con, "ALTER TABLE employees ADD COLUMN comp_type VARCHAR(30) NULL AFTER job_title");
}
$col_comp_amount = mysqli_query($con, "SHOW COLUMNS FROM employees LIKE 'comp_amount'");
if (!$col_comp_amount || mysqli_num_rows($col_comp_amount) < 1) {
  @mysqli_query($con, "ALTER TABLE employees ADD COLUMN comp_amount DECIMAL(12,2) NULL AFTER comp_type");
}

$app_q = mysqli_query($con, "SELECT a.*, j.job_title FROM job_applications a JOIN jobs j ON a.job_id=j.id WHERE a.id='$app_id' LIMIT 1");
$app = $app_q ? mysqli_fetch_assoc($app_q) : null;

$hire_err = '';
$hire_ok = '';

$already_employee = null;
$ae_q = mysqli_query($con, "SELECT * FROM employees WHERE hired_from_application_id='$app_id' LIMIT 1");
if ($ae_q) {
  $already_employee = mysqli_fetch_assoc($ae_q);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['confirm_hire']) && $app) {
  if ($already_employee) {
    $hire_err = "<div class='alert alert-warning'>This applicant is already hired.</div>";
  } else {
    $cv_cat_id = 0;
    $cv_cat_name = 'CVs';
    $cv_cat_name_s = mysqli_real_escape_string($con, $cv_cat_name);
    $cv_cat_q = mysqli_query($con, "SELECT id FROM document_categories WHERE name='$cv_cat_name_s' LIMIT 1");
    if ($cv_cat_q && mysqli_num_rows($cv_cat_q) > 0) {
      $cv_cat = mysqli_fetch_assoc($cv_cat_q);
      $cv_cat_id = (int)$cv_cat['id'];
    } else {
      mysqli_query($con, "INSERT INTO document_categories (name, created_at) VALUES ('$cv_cat_name_s', NOW())");
      $cv_cat_id = (int)mysqli_insert_id($con);
    }

    $full_name = (string)$app['full_name'];
    $email = (string)$app['email'];
    $phone = (string)$app['phone'];
    $job_title = (string)$app['job_title'];
    $cv_file = (string)$app['cv_file'];

    $full_name_s = mysqli_real_escape_string($con, $full_name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $job_title_s = mysqli_real_escape_string($con, $job_title);

    $comp_type_s = mysqli_real_escape_string($con, '');
    mysqli_query($con, "INSERT INTO employees (full_name, email, phone, job_title, comp_type, comp_amount, hired_from_application_id, created_at) VALUES ('$full_name_s', '$email_s', '$phone_s', '$job_title_s', '$comp_type_s', NULL, '$app_id', NOW())");
    $employee_id = (int)mysqli_insert_id($con);

    $doc_id = 0;
    if (strlen(trim($cv_file)) > 0) {
      $src = __DIR__ . '/uploads/cv/' . $cv_file;
      $dst_dir = __DIR__ . '/uploads/documents';
      if (!is_dir($dst_dir)) {
        @mkdir($dst_dir, 0775, true);
      }

      $ext = pathinfo($cv_file, PATHINFO_EXTENSION);
      $base = preg_replace('/[^a-zA-Z0-9\-_ ]/', '', $full_name);
      $base = trim(preg_replace('/\s+/', ' ', $base));
      if (strlen($base) < 1) { $base = 'Applicant'; }
      $safe = preg_replace('/\s+/', '_', $base);
      $new_name = $safe . '_' . $employee_id;
      if (strlen($ext) > 0) { $new_name .= '.' . $ext; }
      $new_name = preg_replace('/[^a-zA-Z0-9.\-_]/', '', $new_name);

      if (is_file($src)) {
        @copy($src, $dst_dir . '/' . $new_name);
      }

      $title = $full_name . ' - CV';
      $title_s = mysqli_real_escape_string($con, $title);
      $new_name_s = mysqli_real_escape_string($con, $new_name);
      $orig_s = mysqli_real_escape_string($con, $cv_file);
      $uploader_s = mysqli_real_escape_string($con, isset($_SESSION['username']) ? $_SESSION['username'] : '');
      mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, related_employee_id, created_at) VALUES ($cv_cat_id, '$title_s', 'file', '$new_name_s', '$orig_s', NULL, '$uploader_s', $employee_id, NOW())");
      $doc_id = (int)mysqli_insert_id($con);
    }

    mysqli_query($con, "UPDATE employees SET cv_document_id=" . (int)$doc_id . " WHERE id=$employee_id LIMIT 1");
    $hire_ok = "<div class='alert alert-success'>Employee created successfully.</div>";

    $ae_q2 = mysqli_query($con, "SELECT * FROM employees WHERE id=$employee_id LIMIT 1");
    if ($ae_q2) {
      $already_employee = mysqli_fetch_assoc($ae_q2);
    }
  }
}
?>

<div class="main-content">
 <div class="page-content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
          <h4 class="mb-sm-0">Application Details</h4>
          <div class="page-title-right">
            <ol class="breadcrumb m-0">
              <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
              <li class="breadcrumb-item active">Application</li>
            </ol>
          </div>
        </div>
      </div>
    </div>

    <?php if(!$app){ ?>
      <div class="alert alert-danger">Application not found.</div>
    <?php } else { ?>

    <div class="row">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0"><?php print $app['job_title']; ?> - <?php print $app['full_name']; ?></h5>
            <div class="d-flex gap-2">
              <?php if ($already_employee) { ?>
                <a href="employees.php" class="btn btn-success btn-sm">Hired</a>
              <?php } else { ?>
                <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#hireModal">Hire</button>
              <?php } ?>
              <a href="javascript:history.back()" class="btn btn-soft-secondary btn-sm">Back</a>
            </div>
          </div>
          <div class="card-body">
            <?php if (!empty($hire_err)) { print $hire_err; } ?>
            <?php if (!empty($hire_ok)) { print $hire_ok; } ?>
            <p><strong>Email:</strong> <?php print $app['email']; ?></p>
            <p><strong>Phone:</strong> <?php print $app['phone']; ?></p>
            <p><strong>Submitted:</strong> <?php print $app['created_at']; ?></p>
            <p><strong>CV:</strong> <a href="uploads/cv/<?php print $app['cv_file']; ?>" target="_blank">Download</a></p>
            <hr>
            <h5>Cover Letter</h5>
            <p><?php echo nl2br($app['cover_letter']); ?></p>
            <hr>
            <h5>Answers</h5>
            <div class="table-responsive">
              <table class="table table-bordered align-middle">
                <thead>
                  <tr>
                    <th>Question</th>
                    <th>Answer</th>
                  </tr>
                </thead>
                <tbody>
                  <?php
                    $ans_q = mysqli_query($con, "SELECT q.question_text, a.answer_text FROM job_application_answers a JOIN job_questions q ON a.question_id=q.id WHERE a.application_id='$app_id' ORDER BY a.id ASC");
                    while($r = mysqli_fetch_assoc($ans_q)){
                      $qt = $r['question_text'];
                      $at = $r['answer_text'];
                      print "<tr><td>$qt</td><td>".nl2br($at)."</td></tr>";
                    }
                  ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade" id="hireModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Confirm Hire</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Hire <strong><?php print htmlspecialchars($app['full_name']); ?></strong> for <strong><?php print htmlspecialchars($app['job_title']); ?></strong>?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
            <form method="post" class="mb-0">
              <button type="submit" name="confirm_hire" value="1" class="btn btn-primary">Hire</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <?php } ?>
  </div>
 </div>
 <?php include"footer.php";?>
</div>
