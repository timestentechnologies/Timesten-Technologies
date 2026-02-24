<?php
ob_start();
include "header.php";
include "sidebar.php";

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

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_expense_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  created_at DATETIME NULL
)");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_expenses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NULL,
  vendor VARCHAR(160) NULL,
  description TEXT NULL,
  amount DECIMAL(12,2) NOT NULL,
  expense_date DATE NULL,
  employee_id INT NULL,
  payment_id INT NULL,
  payment_method VARCHAR(50) NULL,
  reference VARCHAR(120) NULL,
  receipt_file VARCHAR(255) NULL,
  created_at DATETIME NULL
)");

$col_payment_id = mysqli_query($con, "SHOW COLUMNS FROM finance_expenses LIKE 'payment_id'");
if (!$col_payment_id || mysqli_num_rows($col_payment_id) < 1) {
    @mysqli_query($con, "ALTER TABLE finance_expenses ADD COLUMN payment_id INT NULL AFTER employee_id");
}

$cat_seed = mysqli_query($con, "SELECT COUNT(*) AS c FROM finance_expense_categories");
$cat_row = $cat_seed ? mysqli_fetch_assoc($cat_seed) : null;
if ($cat_row && (int)$cat_row['c'] < 1) {
    mysqli_query($con, "INSERT INTO finance_expense_categories (name, created_at) VALUES ('General', NOW()), ('Office', NOW()), ('Transport', NOW()), ('Salary', NOW())");
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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_category'])) {
    $name = trim((string)($_POST['name'] ?? ''));
    if (strlen($name) < 2) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Category name is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: expenses.php');
        exit;
    }
    $name_s = mysqli_real_escape_string($con, $name);
    mysqli_query($con, "INSERT INTO finance_expense_categories (name, created_at) VALUES ('$name_s', NOW())");
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Category added.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: expenses.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_expense'])) {
    $category_id = (int)($_POST['category_id'] ?? 0);
    $vendor = trim((string)($_POST['vendor'] ?? ''));
    $description = trim((string)($_POST['description'] ?? ''));
    $amount = (float)($_POST['amount'] ?? 0);
    $expense_date = trim((string)($_POST['expense_date'] ?? ''));
    $employee_id = (int)($_POST['employee_id'] ?? 0);
    $payment_id = (int)($_POST['payment_id'] ?? 0);
    $payment_method = trim((string)($_POST['payment_method'] ?? ''));
    $reference = trim((string)($_POST['reference'] ?? ''));

    if ($amount <= 0) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Amount must be greater than 0.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: expenses.php');
        exit;
    }

    $vendor_s = mysqli_real_escape_string($con, $vendor);
    $desc_s = mysqli_real_escape_string($con, $description);
    $pm_s = mysqli_real_escape_string($con, $payment_method);
    $ref_s = mysqli_real_escape_string($con, $reference);

    $date_sql = strlen($expense_date) ? ("'" . mysqli_real_escape_string($con, $expense_date) . "'") : ("'" . date('Y-m-d') . "'");
    $cat_sql = $category_id > 0 ? (string)$category_id : 'NULL';
    $emp_sql = $employee_id > 0 ? (string)$employee_id : 'NULL';
    $pay_sql = $payment_id > 0 ? (string)$payment_id : 'NULL';
    $amount_sql = (string)((float)$amount);

    $receipt_name = '';
    if (isset($_FILES['receipt']) && $_FILES['receipt']['error'] === UPLOAD_ERR_OK) {
        $tmp_name = $_FILES['receipt']['tmp_name'];
        $original_name = basename($_FILES['receipt']['name']);
        $ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
        $allowed = ['pdf','jpg','jpeg','png','webp'];
        if (in_array($ext, $allowed, true)) {
            $uploads_dir = __DIR__ . '/uploads/expenses';
            if (!is_dir($uploads_dir)) {
                @mkdir($uploads_dir, 0775, true);
            }
            $safe_original = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
            $receipt_name = rand(1000, 9999) . '_' . $safe_original;
            if (!move_uploaded_file($tmp_name, $uploads_dir . '/' . $receipt_name)) {
                $receipt_name = '';
            }
        }
    }

    $receipt_sql = strlen($receipt_name) ? ("'" . mysqli_real_escape_string($con, $receipt_name) . "'") : 'NULL';

    mysqli_query(
        $con,
        "INSERT INTO finance_expenses (category_id, vendor, description, amount, expense_date, employee_id, payment_id, payment_method, reference, receipt_file, created_at)
         VALUES ($cat_sql, '$vendor_s', '$desc_s', $amount_sql, $date_sql, $emp_sql, $pay_sql, '$pm_s', '$ref_s', $receipt_sql, NOW())"
    );

    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Expense recorded.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: expenses.php');
    exit;
}

$categories = [];
$cat_rs = mysqli_query($con, "SELECT * FROM finance_expense_categories ORDER BY name ASC");
if ($cat_rs) {
    while ($r = mysqli_fetch_assoc($cat_rs)) { $categories[] = $r; }
}

$employees = [];
$emp_rs = mysqli_query($con, "SELECT id, full_name FROM employees ORDER BY full_name ASC");
if ($emp_rs) {
    while ($r = mysqli_fetch_assoc($emp_rs)) { $employees[] = $r; }
}

$expenses = [];
$ex_rs = mysqli_query(
    $con,
    "SELECT e.*, c.name AS category_name, emp.full_name AS employee_name
     FROM finance_expenses e
     LEFT JOIN finance_expense_categories c ON c.id=e.category_id
     LEFT JOIN employees emp ON emp.id=e.employee_id
     ORDER BY e.id DESC
     LIMIT 200"
);
if ($ex_rs) {
    while ($r = mysqli_fetch_assoc($ex_rs)) { $expenses[] = $r; }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Expenses</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">Finance</a></li>
                <li class="breadcrumb-item active">Expenses</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php if (strlen($successmsg)) { print $successmsg; } ?>
      <?php if (strlen($errormsg)) { print $errormsg; } ?>

      <div class="row g-3">
        <div class="col-12 col-lg-4">
          <div class="card">
            <div class="card-header d-flex align-items-center">
              <h5 class="card-title mb-0">Expense Categories</h5>
            </div>
            <div class="card-body">
              <form method="post" class="mb-3">
                <input type="hidden" name="add_category" value="1">
                <div class="input-group">
                  <input type="text" class="form-control" name="name" placeholder="New category">
                  <button class="btn btn-primary" type="submit">Add</button>
                </div>
              </form>
              <div class="list-group">
                <?php foreach ($categories as $c) {
                  $nm = htmlspecialchars((string)$c['name']);
                  print "<div class='list-group-item d-flex align-items-center justify-content-between'><span>$nm</span></div>";
                } ?>
              </div>
            </div>
          </div>
        </div>

        <div class="col-12 col-lg-8">
          <div class="card">
            <div class="card-header d-flex align-items-center">
              <h5 class="card-title mb-0">Record Expense</h5>
              <div class="ms-auto">
                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#addExpenseModal">Add Expense</button>
              </div>
            </div>
            <div class="card-body">
              <div class="text-muted">Use the button above to record a new expense.</div>
            </div>
          </div>

          <div class="modal fade" id="addExpenseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Record Expense</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form method="post" enctype="multipart/form-data" id="addExpenseForm">
                    <input type="hidden" name="add_expense" value="1">
                    <input type="hidden" name="payment_id" id="expense_payment_id" value="">
                    <div class="row g-3">
                      <div class="col-12 col-md-6">
                        <label class="form-label">Category</label>
                        <select class="form-select" name="category_id" id="expense_category_id">
                          <option value="">Select...</option>
                          <?php foreach ($categories as $c) {
                            $cid = (int)$c['id'];
                            $nm = htmlspecialchars((string)$c['name']);
                            print "<option value='$cid'>$nm</option>";
                          } ?>
                        </select>
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">Expense Date</label>
                        <input type="date" class="form-control" name="expense_date" value="<?php print date('Y-m-d'); ?>">
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">Vendor</label>
                        <input type="text" class="form-control" name="vendor" placeholder="Vendor / Shop / Supplier">
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">Amount</label>
                        <input type="number" step="0.01" class="form-control" name="amount" required>
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">Employee (optional)</label>
                        <select class="form-select" name="employee_id">
                          <option value="">None</option>
                          <?php foreach ($employees as $e) {
                            $eid = (int)$e['id'];
                            $en = htmlspecialchars((string)$e['full_name']);
                            print "<option value='$eid'>$en</option>";
                          } ?>
                        </select>
                        <div class="text-muted small mt-1">Use this for salaries/allowances/employee payments.</div>
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">Payment Method</label>
                        <input type="text" class="form-control" name="payment_method" placeholder="Cash / Bank / MPESA">
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">Reference</label>
                        <input type="text" class="form-control" name="reference" placeholder="Receipt / Transaction ID">
                      </div>
                      <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="2"></textarea>
                      </div>
                      <div class="col-12">
                        <label class="form-label">Receipt (optional)</label>
                        <input type="file" class="form-control" name="receipt" accept="application/pdf,image/png,image/jpeg,image/webp">
                      </div>
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" form="addExpenseForm" class="btn btn-danger">Save Expense</button>
                </div>
              </div>
            </div>
          </div>

          <div class="card">
            <div class="card-header">
              <h5 class="card-title mb-0">Expenses List</h5>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-striped align-middle mb-0">
                  <thead>
                    <tr>
                      <th>Date</th>
                      <th>Category</th>
                      <th>Vendor</th>
                      <th>Employee</th>
                      <th class="text-end">Amount</th>
                      <th>Method</th>
                      <th>Receipt</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    if (count($expenses) < 1) {
                        print "<tr><td colspan='7' class='text-center text-muted'>No expenses yet.</td></tr>";
                    }
                    foreach ($expenses as $x) {
                        $id = (int)$x['id'];
                        $dt = htmlspecialchars((string)$x['expense_date']);
                        $cat = htmlspecialchars((string)$x['category_name']);
                        $vd = htmlspecialchars((string)$x['vendor']);
                        $emp = htmlspecialchars((string)$x['employee_name']);
                        $am = (float)$x['amount'];
                        $pm = htmlspecialchars((string)$x['payment_method']);
                        $rf = htmlspecialchars((string)$x['receipt_file']);
                        $rc = "<a href='expense-receipt-view.php?id=$id' target='_blank' class='btn btn-sm btn-soft-success'>Receipt</a> ";
                        if (!empty($x['payment_id'])) {
                            $pid = (int)$x['payment_id'];
                            $rc .= "<a href='payslip-view.php?id=$pid' target='_blank' class='btn btn-sm btn-soft-secondary'>Payslip</a> ";
                        }
                        if (strlen($rf) > 0) {
                            $rc .= "<a href='uploads/expenses/$rf' target='_blank' class='btn btn-sm btn-soft-primary'>File</a>";
                        }
                        print "<tr><td>$dt</td><td>$cat</td><td>$vd</td><td>$emp</td><td class='text-end fw-semibold'>" . number_format($am,2) . "</td><td>$pm</td><td>$rc</td></tr>";
                    }
                    ?>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

        </div>
      </div>

    </div>
  </div>
</div>

<?php include "footer.php"; ?>
