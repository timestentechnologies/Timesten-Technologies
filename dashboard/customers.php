<?php
ob_start();
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  email VARCHAR(160) NULL,
  phone VARCHAR(80) NULL,
  service VARCHAR(160) NULL,
  address TEXT NULL,
  created_at DATETIME NULL
 )");

 $col_rs = mysqli_query($con, "SHOW COLUMNS FROM finance_customers LIKE 'service'");
 if (!$col_rs || mysqli_num_rows($col_rs) < 1) {
     @mysqli_query($con, "ALTER TABLE finance_customers ADD COLUMN service VARCHAR(160) NULL AFTER phone");
 }

$successmsg = '';
$errormsg = '';
if (isset($_SESSION['finance_flash_success'])) {
    $successmsg = (string)$_SESSION['finance_flash_success'];
    unset($_SESSION['finance_flash_success']);
}
if (isset($_SESSION['finance_flash_error'])) {
    $errormsg = (string)$_SESSION['finance_flash_error'];
    unset($_SESSION['finance_flash_error']);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_customer'])) {
    $name = trim((string)($_POST['name'] ?? ''));
    $email = trim((string)($_POST['email'] ?? ''));
    $phone = trim((string)($_POST['phone'] ?? ''));
    $service = trim((string)($_POST['service'] ?? ''));
    $address = trim((string)($_POST['address'] ?? ''));

    if (strlen($name) < 2) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Customer name is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: customers.php');
        exit;
    }

    $name_s = mysqli_real_escape_string($con, $name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $service_s = mysqli_real_escape_string($con, $service);
    $address_s = mysqli_real_escape_string($con, $address);

    mysqli_query($con, "INSERT INTO finance_customers (name, email, phone, service, address, created_at) VALUES ('$name_s', '$email_s', '$phone_s', '$service_s', '$address_s', NOW())");
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Customer added.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: customers.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_customer'])) {
    $id = (int)($_POST['id'] ?? 0);
    $name = trim((string)($_POST['name'] ?? ''));
    $email = trim((string)($_POST['email'] ?? ''));
    $phone = trim((string)($_POST['phone'] ?? ''));
    $service = trim((string)($_POST['service'] ?? ''));
    $address = trim((string)($_POST['address'] ?? ''));

    if ($id < 1 || strlen($name) < 2) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Invalid customer data.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: customers.php');
        exit;
    }

    $name_s = mysqli_real_escape_string($con, $name);
    $email_s = mysqli_real_escape_string($con, $email);
    $phone_s = mysqli_real_escape_string($con, $phone);
    $service_s = mysqli_real_escape_string($con, $service);
    $address_s = mysqli_real_escape_string($con, $address);

    mysqli_query($con, "UPDATE finance_customers SET name='$name_s', email='$email_s', phone='$phone_s', service='$service_s', address='$address_s' WHERE id=$id LIMIT 1");
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Customer updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: customers.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_customer'])) {
    $id = (int)($_POST['id'] ?? 0);
    if ($id > 0) {
        mysqli_query($con, "DELETE FROM finance_customers WHERE id=$id LIMIT 1");
        $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Customer deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
    header('Location: customers.php');
    exit;
}

$customers = [];
$rs = mysqli_query($con, "SELECT * FROM finance_customers ORDER BY id DESC");
if ($rs) {
    while ($r = mysqli_fetch_assoc($rs)) {
        $customers[] = $r;
    }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Customers</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">Finance</a></li>
                <li class="breadcrumb-item active">Customers</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php if (strlen($successmsg)) { print $successmsg; } ?>
      <?php if (strlen($errormsg)) { print $errormsg; } ?>

      <div class="card">
        <div class="card-header d-flex align-items-center">
          <h5 class="card-title mb-0">Customers</h5>
          <button type="button" class="btn btn-primary btn-sm ms-auto" data-bs-toggle="modal" data-bs-target="#addCustomerModal">Add Customer</button>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped align-middle mb-0">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Service</th>
                  <th>Created</th>
                  <th class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($customers) < 1) {
                    print "<tr><td colspan='6' class='text-center text-muted'>No customers yet.</td></tr>";
                }
                foreach ($customers as $c) {
                    $id = (int)$c['id'];
                    $nm = htmlspecialchars((string)$c['name']);
                    $em = htmlspecialchars((string)$c['email']);
                    $ph = htmlspecialchars((string)$c['phone']);
                    $sv = htmlspecialchars((string)($c['service'] ?? ''));
                    $ad = htmlspecialchars((string)$c['address']);
                    $dt = htmlspecialchars((string)$c['created_at']);

                    print "<tr>";
                    print "<td>$nm</td><td>$em</td><td>$ph</td><td>$sv</td><td>$dt</td>";
                    print "<td class='text-end'>";
                    print "<button type='button' class='btn btn-sm btn-soft-secondary js-cust-edit' data-id='$id' data-name='$nm' data-email='$em' data-phone='$ph' data-service='$sv' data-address='$ad'>Edit</button> ";
                    print "<button type='button' class='btn btn-sm btn-soft-danger js-cust-del' data-id='$id' data-name='$nm'>Delete</button>";
                    print "</td>";
                    print "</tr>";
                }
                ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Add Customer</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="addCustomerForm">
                <input type="hidden" name="add_customer" value="1">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" name="name" required>
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label">Phone</label>
                    <input type="text" class="form-control" name="phone">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label">Service</label>
                    <input type="text" class="form-control" name="service" placeholder="e.g. Web Development">
                  </div>
                  <div class="col-12">
                    <label class="form-label">Address</label>
                    <textarea class="form-control" name="address" rows="2"></textarea>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="addCustomerForm" class="btn btn-primary">Save</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Customer</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="editCustomerForm">
                <input type="hidden" name="update_customer" value="1">
                <input type="hidden" name="id" id="e_id" value="">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" id="e_name" name="name" required>
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" id="e_email" name="email">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label">Phone</label>
                    <input type="text" class="form-control" id="e_phone" name="phone">
                  </div>
                  <div class="col-12 col-md-6">
                    <label class="form-label">Service</label>
                    <input type="text" class="form-control" id="e_service" name="service">
                  </div>
                  <div class="col-12">
                    <label class="form-label">Address</label>
                    <textarea class="form-control" id="e_address" name="address" rows="2"></textarea>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="editCustomerForm" class="btn btn-primary">Update</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="deleteCustomerModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Confirm Delete</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">Delete <strong id="d_name"></strong>?</div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <form method="post" class="mb-0">
                <input type="hidden" name="delete_customer" value="1">
                <input type="hidden" name="id" id="d_id" value="">
                <button type="submit" class="btn btn-danger">Delete</button>
              </form>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<script>
(function(){
  if (!window.bootstrap) return;
  var editEl = document.getElementById('editCustomerModal');
  var delEl = document.getElementById('deleteCustomerModal');
  var editModal = editEl ? new bootstrap.Modal(editEl) : null;
  var delModal = delEl ? new bootstrap.Modal(delEl) : null;

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-cust-edit') : null;
    if (!btn || !editModal) return;
    document.getElementById('e_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('e_name').value = btn.getAttribute('data-name') || '';
    document.getElementById('e_email').value = btn.getAttribute('data-email') || '';
    document.getElementById('e_phone').value = btn.getAttribute('data-phone') || '';
    document.getElementById('e_service').value = btn.getAttribute('data-service') || '';
    document.getElementById('e_address').value = btn.getAttribute('data-address') || '';
    editModal.show();
  });

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-cust-del') : null;
    if (!btn || !delModal) return;
    document.getElementById('d_id').value = btn.getAttribute('data-id') || '';
    document.getElementById('d_name').textContent = btn.getAttribute('data-name') || '';
    delModal.show();
  });
})();
</script>

<?php include "footer.php"; ?>
