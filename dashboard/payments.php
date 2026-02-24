<?php
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  email VARCHAR(160) NULL,
  phone VARCHAR(80) NULL,
  address TEXT NULL,
  created_at DATETIME NULL
 )");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_invoices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_no VARCHAR(50) NOT NULL,
  customer_id INT NOT NULL,
  issue_date DATE NULL,
  due_date DATE NULL,
  status VARCHAR(20) NULL,
  notes TEXT NULL,
  subtotal DECIMAL(12,2) NULL,
  total DECIMAL(12,2) NULL,
  amount_paid DECIMAL(12,2) NULL,
  created_at DATETIME NULL,
  UNIQUE KEY uniq_invoice_no (invoice_no)
 )");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_invoice_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT NOT NULL,
  description VARCHAR(255) NOT NULL,
  qty DECIMAL(12,2) NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  line_total DECIMAL(12,2) NOT NULL,
  created_at DATETIME NULL
 )");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT NOT NULL,
  customer_id INT NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  method VARCHAR(50) NULL,
  reference VARCHAR(120) NULL,
  paid_at DATE NULL,
  notes TEXT NULL,
  created_at DATETIME NULL
 )");

function finance_recalc_invoice(mysqli $con, int $invoice_id): void {
    $items_rs = mysqli_query($con, "SELECT COALESCE(SUM(line_total),0) AS s FROM finance_invoice_items WHERE invoice_id=$invoice_id");
    $items_row = $items_rs ? mysqli_fetch_assoc($items_rs) : null;
    $subtotal = $items_row ? (float)$items_row['s'] : 0.0;

    $pay_rs = mysqli_query($con, "SELECT COALESCE(SUM(amount),0) AS s FROM finance_payments WHERE invoice_id=$invoice_id");
    $pay_row = $pay_rs ? mysqli_fetch_assoc($pay_rs) : null;
    $paid = $pay_row ? (float)$pay_row['s'] : 0.0;

    $inv_rs = mysqli_query($con, "SELECT status FROM finance_invoices WHERE id=$invoice_id LIMIT 1");
    $inv = $inv_rs ? mysqli_fetch_assoc($inv_rs) : null;
    $cur_status = $inv ? (string)$inv['status'] : '';

    $total = $subtotal;
    $balance = $total - $paid;

    $new_status = $cur_status;
    if ($cur_status !== 'void') {
        if ($total <= 0 && $paid <= 0) {
            $new_status = strlen($cur_status) ? $cur_status : 'draft';
        } elseif ($balance <= 0.00001) {
            $new_status = 'paid';
        } elseif ($paid > 0) {
            $new_status = 'partial';
        } else {
            $new_status = $cur_status === 'draft' ? 'draft' : 'sent';
        }
    }

    $subtotal_sql = (string)((float)$subtotal);
    $total_sql = (string)((float)$total);
    $paid_sql = (string)((float)$paid);
    $new_status_s = mysqli_real_escape_string($con, $new_status);

    mysqli_query(
        $con,
        "UPDATE finance_invoices SET subtotal=$subtotal_sql, total=$total_sql, amount_paid=$paid_sql, status='$new_status_s' WHERE id=$invoice_id LIMIT 1"
    );
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

$pref_invoice_id = isset($_GET['invoice_id']) ? (int)$_GET['invoice_id'] : 0;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_payment'])) {
    $invoice_id = (int)($_POST['invoice_id'] ?? 0);
    $amount = (float)($_POST['amount'] ?? 0);
    $method = trim((string)($_POST['method'] ?? ''));
    $reference = trim((string)($_POST['reference'] ?? ''));
    $paid_at = trim((string)($_POST['paid_at'] ?? ''));
    $notes = trim((string)($_POST['notes'] ?? ''));

    $inv_rs = mysqli_query($con, "SELECT * FROM finance_invoices WHERE id=$invoice_id LIMIT 1");
    $inv = $inv_rs ? mysqli_fetch_assoc($inv_rs) : null;
    if (!$inv || $amount <= 0) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Invalid payment data.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: payments.php');
        exit;
    }

    $customer_id = (int)$inv['customer_id'];

    $method_s = mysqli_real_escape_string($con, $method);
    $reference_s = mysqli_real_escape_string($con, $reference);
    $notes_s = mysqli_real_escape_string($con, $notes);
    $paid_at_sql = strlen($paid_at) ? ("'" . mysqli_real_escape_string($con, $paid_at) . "'") : ("'" . date('Y-m-d') . "'");

    $amount_sql = (string)((float)$amount);

    mysqli_query(
        $con,
        "INSERT INTO finance_payments (invoice_id, customer_id, amount, method, reference, paid_at, notes, created_at)
         VALUES ($invoice_id, $customer_id, $amount_sql, '$method_s', '$reference_s', $paid_at_sql, '$notes_s', NOW())"
    );

    finance_recalc_invoice($con, $invoice_id);

    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Payment recorded.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: payments.php?invoice_id=' . $invoice_id);
    exit;
}

$invoices = [];
$inv_rs2 = mysqli_query(
    $con,
    "SELECT i.id, i.invoice_no, i.status, i.total, i.amount_paid, c.name AS customer_name
     FROM finance_invoices i
     JOIN finance_customers c ON c.id=i.customer_id
     ORDER BY i.id DESC"
);
if ($inv_rs2) {
    while ($r = mysqli_fetch_assoc($inv_rs2)) {
        if (isset($r['id'])) {
            finance_recalc_invoice($con, (int)$r['id']);
        }
    }
}
$inv_rs3 = mysqli_query(
    $con,
    "SELECT i.id, i.invoice_no, i.status, i.total, i.amount_paid, c.name AS customer_name
     FROM finance_invoices i
     JOIN finance_customers c ON c.id=i.customer_id
     ORDER BY i.id DESC"
);
if ($inv_rs3) {
    while ($r = mysqli_fetch_assoc($inv_rs3)) { $invoices[] = $r; }
}

$where = "1=1";
if ($pref_invoice_id > 0) {
    $where = "p.invoice_id=$pref_invoice_id";
}

$payments = [];
$p_rs = mysqli_query(
    $con,
    "SELECT p.*, i.invoice_no, c.name AS customer_name
     FROM finance_payments p
     JOIN finance_invoices i ON i.id=p.invoice_id
     JOIN finance_customers c ON c.id=p.customer_id
     WHERE $where
     ORDER BY p.id DESC
     LIMIT 200"
);
if ($p_rs) {
    while ($r = mysqli_fetch_assoc($p_rs)) { $payments[] = $r; }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Payments</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">Finance</a></li>
                <li class="breadcrumb-item active">Payments</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php if (strlen($successmsg)) { print $successmsg; } ?>
      <?php if (strlen($errormsg)) { print $errormsg; } ?>

      <div class="card">
        <div class="card-header d-flex align-items-center">
          <h5 class="card-title mb-0">Record Payment</h5>
        </div>
        <div class="card-body">
          <form method="post">
            <input type="hidden" name="add_payment" value="1">
            <div class="row g-3">
              <div class="col-12 col-md-6">
                <label class="form-label">Invoice</label>
                <select name="invoice_id" class="form-select" required>
                  <option value="">Select...</option>
                  <?php foreach ($invoices as $i) {
                    $id = (int)$i['id'];
                    $no = htmlspecialchars((string)$i['invoice_no']);
                    $cn = htmlspecialchars((string)$i['customer_name']);
                    $total = (float)($i['total'] ?? 0);
                    $paid = (float)($i['amount_paid'] ?? 0);
                    $bal = $total - $paid;
                    $sel = $pref_invoice_id === $id ? ' selected' : '';
                    print "<option value='$id'$sel>$no - $cn (Bal: " . number_format($bal,2) . ")</option>";
                  } ?>
                </select>
              </div>
              <div class="col-12 col-md-3">
                <label class="form-label">Amount</label>
                <input type="number" step="0.01" name="amount" class="form-control" required>
              </div>
              <div class="col-12 col-md-3">
                <label class="form-label">Paid Date</label>
                <input type="date" name="paid_at" class="form-control" value="<?php print date('Y-m-d'); ?>">
              </div>
              <div class="col-12 col-md-4">
                <label class="form-label">Method</label>
                <input type="text" name="method" class="form-control" placeholder="Cash / Bank / MPESA">
              </div>
              <div class="col-12 col-md-4">
                <label class="form-label">Reference</label>
                <input type="text" name="reference" class="form-control" placeholder="Transaction ID">
              </div>
              <div class="col-12">
                <label class="form-label">Notes</label>
                <textarea name="notes" class="form-control" rows="2"></textarea>
              </div>
              <div class="col-12">
                <button type="submit" class="btn btn-success">Save Payment</button>
              </div>
            </div>
          </form>
        </div>
      </div>

      <div class="card">
        <div class="card-header d-flex align-items-center">
          <h5 class="card-title mb-0">Payments List</h5>
          <?php if ($pref_invoice_id > 0) { ?>
            <a class="btn btn-light btn-sm ms-auto" href="payments.php">Clear Filter</a>
          <?php } ?>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped align-middle mb-0">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Invoice</th>
                  <th>Customer</th>
                  <th>Method</th>
                  <th>Reference</th>
                  <th class="text-end">Amount</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($payments) < 1) {
                    print "<tr><td colspan='6' class='text-center text-muted'>No payments yet.</td></tr>";
                }
                foreach ($payments as $p) {
                    $pd = htmlspecialchars((string)$p['paid_at']);
                    $no = htmlspecialchars((string)$p['invoice_no']);
                    $cn = htmlspecialchars((string)$p['customer_name']);
                    $pm = htmlspecialchars((string)$p['method']);
                    $pr = htmlspecialchars((string)$p['reference']);
                    $am = (float)$p['amount'];
                    print "<tr><td>$pd</td><td>$no</td><td>$cn</td><td>$pm</td><td>$pr</td><td class='text-end fw-semibold'>" . number_format($am,2) . "</td></tr>";
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

<?php include "footer.php"; ?>
