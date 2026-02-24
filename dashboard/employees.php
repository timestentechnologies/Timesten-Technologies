<?php
ob_start();
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

mysqli_query($con, "CREATE TABLE IF NOT EXISTS employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(160) NOT NULL,
  email VARCHAR(160) NULL,
  phone VARCHAR(80) NULL,
  job_title VARCHAR(255) NULL,
  comp_type VARCHAR(30) NULL,
  comp_amount DECIMAL(12,2) NULL,
  photo VARCHAR(255) NULL,
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
$col_photo = mysqli_query($con, "SHOW COLUMNS FROM employees LIKE 'photo'");
if (!$col_photo || mysqli_num_rows($col_photo) < 1) {
    @mysqli_query($con, "ALTER TABLE employees ADD COLUMN photo VARCHAR(255) NULL AFTER comp_amount");
}

$errormsg = '';
$successmsg = '';

if (isset($_SESSION['employees_flash_success'])) {
    $successmsg = (string)$_SESSION['employees_flash_success'];
    unset($_SESSION['employees_flash_success']);
}
if (isset($_SESSION['employees_flash_error'])) {
    $errormsg = (string)$_SESSION['employees_flash_error'];
    unset($_SESSION['employees_flash_error']);
}

$username = isset($_SESSION['username']) ? $_SESSION['username'] : '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_employee'])) {
    $full_name = trim((string)($_POST['full_name'] ?? ''));
    $email = trim((string)($_POST['email'] ?? ''));
    $phone = trim((string)($_POST['phone'] ?? ''));
    $job_title = trim((string)($_POST['job_title'] ?? ''));
    $comp_type = trim((string)($_POST['comp_type'] ?? ''));
    $comp_amount_raw = trim((string)($_POST['comp_amount'] ?? ''));
    $comp_amount = strlen($comp_amount_raw) > 0 ? (float)$comp_amount_raw : null;

    if (strlen($full_name) < 2) {
        $_SESSION['employees_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Full name is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: employees.php');
        exit;
    }

    $full_name_s = mysqli_real_escape_string($con, $full_name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $job_title_s = mysqli_real_escape_string($con, $job_title);

    $allowed_comp = ['salary', 'commission', 'voluntary'];
    if (!in_array($comp_type, $allowed_comp, true)) { $comp_type = ''; }
    $comp_type_s = mysqli_real_escape_string($con, $comp_type);
    if ($comp_type === 'voluntary') {
        $comp_amount = null;
    }
    $comp_amount_sql = $comp_amount === null ? 'NULL' : (string)((float)$comp_amount);

    mysqli_query($con, "INSERT INTO employees (full_name, email, phone, job_title, comp_type, comp_amount, created_at) VALUES ('$full_name_s', '$email_s', '$phone_s', '$job_title_s', '$comp_type_s', $comp_amount_sql, NOW())");
    $employee_id = (int)mysqli_insert_id($con);

    $photo_file_name = '';
    if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
        $tmp_name = $_FILES['photo']['tmp_name'];
        $original_name = basename($_FILES['photo']['name']);
        $ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
        $allowed_ext = ['jpg', 'jpeg', 'png', 'webp'];
        if (in_array($ext, $allowed_ext, true)) {
            $uploads_dir = __DIR__ . '/uploads/employees';
            if (!is_dir($uploads_dir)) {
                @mkdir($uploads_dir, 0775, true);
            }
            $base = preg_replace('/[^a-zA-Z0-9\-_ ]/', '', $full_name);
            $base = trim(preg_replace('/\s+/', ' ', $base));
            if (strlen($base) < 1) { $base = 'Employee'; }
            $safe = preg_replace('/\s+/', '_', $base);
            $new_name = $safe . '_' . $employee_id . '.' . $ext;
            $new_name = preg_replace('/[^a-zA-Z0-9.\-_]/', '', $new_name);
            if (move_uploaded_file($tmp_name, $uploads_dir . '/' . $new_name)) {
                $photo_file_name = $new_name;
                $photo_s = mysqli_real_escape_string($con, $photo_file_name);
                mysqli_query($con, "UPDATE employees SET photo='$photo_s' WHERE id=$employee_id LIMIT 1");
            }
        }
    }

    $doc_id = 0;
    if (isset($_FILES['cv_file']) && $_FILES['cv_file']['error'] === UPLOAD_ERR_OK) {
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

        $uploads_dir = __DIR__ . '/uploads/documents';
        if (!is_dir($uploads_dir)) {
            @mkdir($uploads_dir, 0775, true);
        }

        $tmp_name = $_FILES['cv_file']['tmp_name'];
        $original_name = basename($_FILES['cv_file']['name']);

        $ext = pathinfo($original_name, PATHINFO_EXTENSION);
        $base = preg_replace('/[^a-zA-Z0-9\-_ ]/', '', $full_name);
        $base = trim(preg_replace('/\s+/', ' ', $base));
        if (strlen($base) < 1) { $base = 'Employee'; }
        $safe = preg_replace('/\s+/', '_', $base);
        $new_name = $safe . '_' . $employee_id;
        if (strlen($ext) > 0) { $new_name .= '.' . $ext; }
        $new_name = preg_replace('/[^a-zA-Z0-9.\-_]/', '', $new_name);

        if (move_uploaded_file($tmp_name, $uploads_dir . '/' . $new_name)) {
            $title = $full_name . ' - CV';
            $title_s = mysqli_real_escape_string($con, $title);
            $file_s = mysqli_real_escape_string($con, $new_name);
            $orig_s = mysqli_real_escape_string($con, $original_name);
            $uploader_s = mysqli_real_escape_string($con, $username);
            mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, related_employee_id, created_at) VALUES ($cv_cat_id, '$title_s', 'file', '$file_s', '$orig_s', NULL, '$uploader_s', $employee_id, NOW())");
            $doc_id = (int)mysqli_insert_id($con);
            mysqli_query($con, "UPDATE employees SET cv_document_id=$doc_id WHERE id=$employee_id LIMIT 1");
        }
    }

    $_SESSION['employees_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Employee added.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: employees.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_employee'])) {
    $emp_id = (int)($_POST['emp_id'] ?? 0);
    $full_name = trim((string)($_POST['full_name'] ?? ''));
    $email = trim((string)($_POST['email'] ?? ''));
    $phone = trim((string)($_POST['phone'] ?? ''));
    $job_title = trim((string)($_POST['job_title'] ?? ''));
    $comp_type = trim((string)($_POST['comp_type'] ?? ''));
    $comp_amount_raw = trim((string)($_POST['comp_amount'] ?? ''));
    $comp_amount = strlen($comp_amount_raw) > 0 ? (float)$comp_amount_raw : null;

    if ($emp_id < 1 || strlen($full_name) < 2) {
        $_SESSION['employees_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Invalid employee data.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: employees.php');
        exit;
    }

    $full_name_s = mysqli_real_escape_string($con, $full_name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $job_title_s = mysqli_real_escape_string($con, $job_title);

    $allowed_comp = ['salary', 'commission', 'voluntary'];
    if (!in_array($comp_type, $allowed_comp, true)) { $comp_type = ''; }
    $comp_type_s = mysqli_real_escape_string($con, $comp_type);
    if ($comp_type === 'voluntary') {
        $comp_amount = null;
    }
    $comp_amount_sql = $comp_amount === null ? 'NULL' : (string)((float)$comp_amount);

    mysqli_query($con, "UPDATE employees SET full_name='$full_name_s', email='$email_s', phone='$phone_s', job_title='$job_title_s', comp_type='$comp_type_s', comp_amount=$comp_amount_sql WHERE id=$emp_id LIMIT 1");

    if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
        $tmp_name = $_FILES['photo']['tmp_name'];
        $original_name = basename($_FILES['photo']['name']);
        $ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
        $allowed_ext = ['jpg', 'jpeg', 'png', 'webp'];
        if (in_array($ext, $allowed_ext, true)) {
            $uploads_dir = __DIR__ . '/uploads/employees';
            if (!is_dir($uploads_dir)) {
                @mkdir($uploads_dir, 0775, true);
            }
            $base = preg_replace('/[^a-zA-Z0-9\-_ ]/', '', $full_name);
            $base = trim(preg_replace('/\s+/', ' ', $base));
            if (strlen($base) < 1) { $base = 'Employee'; }
            $safe = preg_replace('/\s+/', '_', $base);
            $new_name = $safe . '_' . $emp_id . '.' . $ext;
            $new_name = preg_replace('/[^a-zA-Z0-9.\-_]/', '', $new_name);
            if (move_uploaded_file($tmp_name, $uploads_dir . '/' . $new_name)) {
                $photo_s = mysqli_real_escape_string($con, $new_name);
                mysqli_query($con, "UPDATE employees SET photo='$photo_s' WHERE id=$emp_id LIMIT 1");
            }
        }
    }

    $_SESSION['employees_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Employee updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: employees.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_employee'])) {
    $emp_id = (int)($_POST['emp_id'] ?? 0);
    if ($emp_id > 0) {
        mysqli_query($con, "DELETE FROM employees WHERE id=$emp_id LIMIT 1");
        $_SESSION['employees_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Employee deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
    header('Location: employees.php');
    exit;
}

$employees = [];
$q = mysqli_query($con, "SELECT * FROM employees ORDER BY id DESC");
if ($q) {
    while ($r = mysqli_fetch_assoc($q)) {
        $employees[] = $r;
    }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Employees</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                <li class="breadcrumb-item active">Employees</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php
      if (!empty($errormsg)) { print $errormsg; }
      if (!empty($successmsg)) { print $successmsg; }
      ?>

      <div class="card">
        <div class="card-header d-flex flex-wrap align-items-center">
          <h5 class="card-title mb-0">All Employees</h5>
          <div class="ms-auto d-flex gap-2 align-items-center" style="min-width: 240px;">
            <input type="text" class="form-control form-control-sm flex-grow-1" id="empSearch" placeholder="Search employees...">
            <button type="button" class="btn btn-sm btn-primary text-nowrap" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">Add</button>
          </div>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped table-sm align-middle mb-0" id="employeesTable">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Job</th>
                  <th>Hired</th>
                  <th class="text-end">Action</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($employees) < 1) {
                    print "<tr><td colspan='6' class='text-center text-muted'>No employees yet.</td></tr>";
                }
                foreach ($employees as $e) {
                    $id = (int)$e['id'];
                    $nm = htmlspecialchars($e['full_name']);
                    $em = htmlspecialchars((string)$e['email']);
                    $ph = htmlspecialchars((string)$e['phone']);
                    $jt = htmlspecialchars((string)$e['job_title']);
                    $ct = htmlspecialchars((string)($e['comp_type'] ?? ''));
                    $ca = htmlspecialchars((string)($e['comp_amount'] ?? ''));
                    $photo = htmlspecialchars((string)($e['photo'] ?? ''));
                    $dt = htmlspecialchars((string)$e['created_at']);
                    $hiredFrom = htmlspecialchars((string)$e['hired_from_application_id']);
                    $cvDoc = htmlspecialchars((string)$e['cv_document_id']);

                    print "<tr>";
                    print "<td>$nm</td><td>$em</td><td>$ph</td><td>$jt</td><td>$dt</td>";
                    print "<td class='text-end'>";
                    print "<button type='button' class='btn btn-sm btn-soft-primary js-emp-view' data-id='$id' data-name='$nm' data-email='$em' data-phone='$ph' data-job='$jt' data-comptype='$ct' data-compamount='$ca' data-photo='$photo' data-date='$dt' data-hiredfrom='$hiredFrom' data-cvdoc='$cvDoc'>View</button> ";
                    print "<button type='button' class='btn btn-sm btn-soft-secondary js-emp-edit' data-id='$id' data-name='$nm' data-email='$em' data-phone='$ph' data-job='$jt' data-comptype='$ct' data-compamount='$ca' data-photo='$photo'>Edit</button> ";
                    print "<button type='button' class='btn btn-sm btn-soft-danger js-emp-del' data-id='$id' data-name='$nm'>Delete</button>";
                    print "</td>";
                    print "</tr>";
                }
                ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div class="modal fade" id="viewEmployeeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Employee Details</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="d-flex flex-wrap gap-3 align-items-center mb-3">
                <div class="flex-shrink-0">
                  <img id="v_emp_photo" src="" alt="photo" style="width:72px;height:72px;object-fit:cover;border-radius:50%;display:none;">
                  <div id="v_emp_photo_placeholder" class="bg-light text-muted d-flex align-items-center justify-content-center" style="width:72px;height:72px;border-radius:50%;">
                    <span class="fw-semibold" id="v_emp_initials"></span>
                  </div>
                </div>
                <div class="flex-grow-1">
                  <div class="fs-5 fw-semibold" id="v_emp_name"></div>
                  <div class="text-muted" id="v_emp_job"></div>
                </div>
              </div>

              <div class="row g-3">
                <div class="col-12 col-md-6">
                  <div class="p-3 border rounded-3">
                    <div class="text-muted small">Email</div>
                    <div class="fw-medium" id="v_emp_email"></div>
                  </div>
                </div>
                <div class="col-12 col-md-6">
                  <div class="p-3 border rounded-3">
                    <div class="text-muted small">Phone</div>
                    <div class="fw-medium" id="v_emp_phone"></div>
                  </div>
                </div>
                <div class="col-12 col-md-6">
                  <div class="p-3 border rounded-3">
                    <div class="text-muted small">Compensation</div>
                    <div class="fw-medium" id="v_emp_comp"></div>
                  </div>
                </div>
                <div class="col-12 col-md-6">
                  <div class="p-3 border rounded-3">
                    <div class="text-muted small">Hired</div>
                    <div class="fw-medium" id="v_emp_date"></div>
                  </div>
                </div>
                <div class="col-12 col-md-6">
                  <div class="p-3 border rounded-3">
                    <div class="text-muted small">From Application ID</div>
                    <div class="fw-medium" id="v_emp_hiredfrom"></div>
                  </div>
                </div>
                <div class="col-12 col-md-6">
                  <div class="p-3 border rounded-3">
                    <div class="text-muted small">CV Document ID</div>
                    <div class="fw-medium" id="v_emp_cvdoc"></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="editEmployeeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Employee</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="editEmployeeForm" enctype="multipart/form-data">
                <input type="hidden" name="update_employee" value="1">
                <input type="hidden" name="emp_id" id="e_emp_id" value="">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="e_full_name">Full Name</label>
                    <input type="text" class="form-control" id="e_full_name" name="full_name" required>
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="e_job_title">Job Title</label>
                    <input type="text" class="form-control" id="e_job_title" name="job_title">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="e_comp_type">Pay Type</label>
                    <select class="form-select" id="e_comp_type" name="comp_type">
                      <option value="">Select...</option>
                      <option value="salary">Salary</option>
                      <option value="commission">Commission</option>
                      <option value="voluntary">Voluntary</option>
                    </select>
                  </div>
                  <div class="col-12 col-md-6" id="e_comp_amount_wrap">
                    <label class="form-label" for="e_comp_amount">Amount</label>
                    <input type="number" step="0.01" class="form-control" id="e_comp_amount" name="comp_amount" placeholder="0.00">
                  </div>
                  <div class="col-12">
                    <label class="form-label" for="e_photo">Employee Image (optional)</label>
                    <input type="file" class="form-control" id="e_photo" name="photo" accept="image/png,image/jpeg,image/webp">
                    <div class="mt-2" id="e_photo_preview_wrap" style="display:none;">
                      <img id="e_photo_preview" src="" alt="photo" style="width:64px;height:64px;object-fit:cover;border-radius:50%;">
                    </div>
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="e_email">Email</label>
                    <input type="email" class="form-control" id="e_email" name="email">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="e_phone">Phone</label>
                    <input type="text" class="form-control" id="e_phone" name="phone">
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="editEmployeeForm" class="btn btn-primary">Save</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="deleteEmployeeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Delete Employee</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              Delete <strong id="d_emp_name"></strong>?
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <form method="post" class="mb-0">
                <input type="hidden" name="delete_employee" value="1">
                <input type="hidden" name="emp_id" id="d_emp_id" value="">
                <button type="submit" class="btn btn-danger">Delete</button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Add Employee</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" enctype="multipart/form-data" id="addEmployeeForm">
                <input type="hidden" name="add_employee" value="1">

                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="full_name">Full Name</label>
                    <input type="text" class="form-control" id="full_name" name="full_name" required>
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="job_title">Job Title</label>
                    <input type="text" class="form-control" id="job_title" name="job_title">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="comp_type">Pay Type</label>
                    <select class="form-select" id="comp_type" name="comp_type">
                      <option value="">Select...</option>
                      <option value="salary">Salary</option>
                      <option value="commission">Commission</option>
                      <option value="voluntary">Voluntary</option>
                    </select>
                  </div>
                  <div class="col-12 col-md-6" id="comp_amount_wrap">
                    <label class="form-label" for="comp_amount">Amount</label>
                    <input type="number" step="0.01" class="form-control" id="comp_amount" name="comp_amount" placeholder="0.00">
                  </div>
                  <div class="col-12">
                    <label class="form-label" for="photo">Employee Image (optional)</label>
                    <input type="file" class="form-control" id="photo" name="photo" accept="image/png,image/jpeg,image/webp">
                    <div class="mt-2" id="photo_preview_wrap" style="display:none;">
                      <img id="photo_preview" src="" alt="photo" style="width:64px;height:64px;object-fit:cover;border-radius:50%;">
                    </div>
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label" for="phone">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone">
                  </div>
                  <div class="col-12">
                    <label class="form-label" for="cv_file">CV (optional)</label>
                    <input type="file" class="form-control" id="cv_file" name="cv_file">
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="addEmployeeForm" class="btn btn-primary">Save</button>
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
  var input = document.getElementById('empSearch');
  var table = document.getElementById('employeesTable');
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

  var viewEl = document.getElementById('viewEmployeeModal');
  var editEl = document.getElementById('editEmployeeModal');
  var delEl = document.getElementById('deleteEmployeeModal');
  var viewModal = viewEl ? new bootstrap.Modal(viewEl) : null;
  var editModal = editEl ? new bootstrap.Modal(editEl) : null;
  var delModal = delEl ? new bootstrap.Modal(delEl) : null;

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-emp-view') : null;
    if (!btn || !viewModal) return;
    var name = btn.getAttribute('data-name') || '';
    document.getElementById('v_emp_name').textContent = name;
    document.getElementById('v_emp_email').textContent = btn.getAttribute('data-email') || '';
    document.getElementById('v_emp_phone').textContent = btn.getAttribute('data-phone') || '';
    document.getElementById('v_emp_job').textContent = btn.getAttribute('data-job') || '';
    var ct = btn.getAttribute('data-comptype') || '';
    var ca = btn.getAttribute('data-compamount') || '';
    var compTxt = '';
    if (ct.length > 0) {
      compTxt = ct;
      if (ca.length > 0) compTxt += ' - ' + ca;
    } else if (ca.length > 0) {
      compTxt = ca;
    }
    document.getElementById('v_emp_comp').textContent = compTxt;
    document.getElementById('v_emp_date').textContent = btn.getAttribute('data-date') || '';
    document.getElementById('v_emp_hiredfrom').textContent = btn.getAttribute('data-hiredfrom') || '';
    document.getElementById('v_emp_cvdoc').textContent = btn.getAttribute('data-cvdoc') || '';

    var initials = '';
    var parts = name.trim().split(/\s+/).filter(Boolean);
    if (parts.length >= 2) {
      initials = (parts[0][0] || '').toUpperCase() + (parts[1][0] || '').toUpperCase();
    } else if (parts.length === 1) {
      initials = (parts[0][0] || '').toUpperCase();
    }
    document.getElementById('v_emp_initials').textContent = initials;

    var photo = btn.getAttribute('data-photo') || '';
    var img = document.getElementById('v_emp_photo');
    var ph = document.getElementById('v_emp_photo_placeholder');
    if (img) {
      img.onload = null;
      img.onerror = null;
    }
    if (photo.length > 0 && img && ph) {
      img.style.display = 'none';
      ph.style.display = '';
      img.onload = function(){
        img.style.display = '';
        ph.style.display = 'none';
      };
      img.onerror = function(){
        img.style.display = 'none';
        ph.style.display = '';
      };
      img.src = 'uploads/employees/' + photo;
    } else {
      if (img) {
        img.src = '';
        img.style.display = 'none';
      }
      if (ph) {
        ph.style.display = '';
      }
    }
    viewModal.show();
  });

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-emp-edit') : null;
    if (!btn || !editModal) return;
    document.getElementById('e_emp_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('e_full_name').value = btn.getAttribute('data-name') || '';
    document.getElementById('e_email').value = btn.getAttribute('data-email') || '';
    document.getElementById('e_phone').value = btn.getAttribute('data-phone') || '';
    document.getElementById('e_job_title').value = btn.getAttribute('data-job') || '';
    document.getElementById('e_comp_type').value = btn.getAttribute('data-comptype') || '';
    document.getElementById('e_comp_amount').value = btn.getAttribute('data-compamount') || '';

    var p = btn.getAttribute('data-photo') || '';
    var wrap = document.getElementById('e_photo_preview_wrap');
    var prev = document.getElementById('e_photo_preview');
    if (wrap && prev) {
      if (p.length > 0) {
        prev.src = 'uploads/employees/' + p;
        wrap.style.display = '';
      } else {
        prev.src = '';
        wrap.style.display = 'none';
      }
    }

    editModal.show();
  });

  function toggleAmount(selectEl, wrapEl, inputEl) {
    if (!selectEl || !wrapEl) return;
    var v = (selectEl.value || '').toLowerCase();
    if (v === 'voluntary') {
      wrapEl.style.display = 'none';
      if (inputEl) inputEl.value = '';
    } else {
      wrapEl.style.display = '';
    }
  }

  var addType = document.getElementById('comp_type');
  var addWrap = document.getElementById('comp_amount_wrap');
  var addAmt = document.getElementById('comp_amount');
  if (addType) {
    addType.addEventListener('change', function(){ toggleAmount(addType, addWrap, addAmt); });
    toggleAmount(addType, addWrap, addAmt);
  }

  var editType = document.getElementById('e_comp_type');
  var editWrap = document.getElementById('e_comp_amount_wrap');
  var editAmt = document.getElementById('e_comp_amount');
  if (editType) {
    editType.addEventListener('change', function(){ toggleAmount(editType, editWrap, editAmt); });
    toggleAmount(editType, editWrap, editAmt);
  }

  function previewImage(fileInput, imgEl, wrapEl) {
    if (!fileInput || !imgEl || !wrapEl) return;
    fileInput.addEventListener('change', function(){
      var f = fileInput.files && fileInput.files[0] ? fileInput.files[0] : null;
      if (!f) {
        imgEl.src = '';
        wrapEl.style.display = 'none';
        return;
      }
      var url = URL.createObjectURL(f);
      imgEl.src = url;
      wrapEl.style.display = '';
    });
  }

  previewImage(document.getElementById('photo'), document.getElementById('photo_preview'), document.getElementById('photo_preview_wrap'));
  previewImage(document.getElementById('e_photo'), document.getElementById('e_photo_preview'), document.getElementById('e_photo_preview_wrap'));

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-emp-del') : null;
    if (!btn || !delModal) return;
    document.getElementById('d_emp_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('d_emp_name').textContent = btn.getAttribute('data-name') || '';
    delModal.show();
  });
})();
</script>
