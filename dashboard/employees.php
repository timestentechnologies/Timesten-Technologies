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
  hired_from_application_id INT NULL,
  cv_document_id INT NULL,
  created_at DATETIME NULL
)");

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

    if (strlen($full_name) < 2) {
        $_SESSION['employees_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Full name is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: employees.php');
        exit;
    }

    $full_name_s = mysqli_real_escape_string($con, $full_name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $job_title_s = mysqli_real_escape_string($con, $job_title);

    mysqli_query($con, "INSERT INTO employees (full_name, email, phone, job_title, created_at) VALUES ('$full_name_s', '$email_s', '$phone_s', '$job_title_s', NOW())");
    $employee_id = (int)mysqli_insert_id($con);

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

    if ($emp_id < 1 || strlen($full_name) < 2) {
        $_SESSION['employees_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Invalid employee data.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: employees.php');
        exit;
    }

    $full_name_s = mysqli_real_escape_string($con, $full_name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $job_title_s = mysqli_real_escape_string($con, $job_title);
    mysqli_query($con, "UPDATE employees SET full_name='$full_name_s', email='$email_s', phone='$phone_s', job_title='$job_title_s' WHERE id=$emp_id LIMIT 1");
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
                    $dt = htmlspecialchars((string)$e['created_at']);
                    $hiredFrom = htmlspecialchars((string)$e['hired_from_application_id']);
                    $cvDoc = htmlspecialchars((string)$e['cv_document_id']);

                    print "<tr>";
                    print "<td>$nm</td><td>$em</td><td>$ph</td><td>$jt</td><td>$dt</td>";
                    print "<td class='text-end'>";
                    print "<button type='button' class='btn btn-sm btn-soft-primary js-emp-view' data-id='$id' data-name='$nm' data-email='$em' data-phone='$ph' data-job='$jt' data-date='$dt' data-hiredfrom='$hiredFrom' data-cvdoc='$cvDoc'>View</button> ";
                    print "<button type='button' class='btn btn-sm btn-soft-secondary js-emp-edit' data-id='$id' data-name='$nm' data-email='$em' data-phone='$ph' data-job='$jt'>Edit</button> ";
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
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Employee Details</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="mb-2"><strong>Name:</strong> <span id="v_emp_name"></span></div>
              <div class="mb-2"><strong>Email:</strong> <span id="v_emp_email"></span></div>
              <div class="mb-2"><strong>Phone:</strong> <span id="v_emp_phone"></span></div>
              <div class="mb-2"><strong>Job Title:</strong> <span id="v_emp_job"></span></div>
              <div class="mb-2"><strong>Hired:</strong> <span id="v_emp_date"></span></div>
              <div class="mb-2"><strong>From Application ID:</strong> <span id="v_emp_hiredfrom"></span></div>
              <div class="mb-0"><strong>CV Document ID:</strong> <span id="v_emp_cvdoc"></span></div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="editEmployeeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Employee</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="editEmployeeForm">
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
        <div class="modal-dialog modal-lg">
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
    document.getElementById('v_emp_name').textContent = btn.getAttribute('data-name') || '';
    document.getElementById('v_emp_email').textContent = btn.getAttribute('data-email') || '';
    document.getElementById('v_emp_phone').textContent = btn.getAttribute('data-phone') || '';
    document.getElementById('v_emp_job').textContent = btn.getAttribute('data-job') || '';
    document.getElementById('v_emp_date').textContent = btn.getAttribute('data-date') || '';
    document.getElementById('v_emp_hiredfrom').textContent = btn.getAttribute('data-hiredfrom') || '';
    document.getElementById('v_emp_cvdoc').textContent = btn.getAttribute('data-cvdoc') || '';
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
    editModal.show();
  });

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-emp-del') : null;
    if (!btn || !delModal) return;
    document.getElementById('d_emp_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('d_emp_name').textContent = btn.getAttribute('data-name') || '';
    delModal.show();
  });
})();
</script>
