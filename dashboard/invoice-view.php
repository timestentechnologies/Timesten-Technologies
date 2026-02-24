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

function finance_recalc_invoice(mysqli $con, int $invoice_id): array {
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

    return [
        'subtotal' => $subtotal,
        'total' => $total,
        'paid' => $paid,
        'balance' => $balance,
        'status' => $new_status,
    ];
}

$invoice_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($invoice_id < 1) {
    print "<script>window.location='invoices.php';</script>";
    exit;
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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_item'])) {
    $desc = trim((string)($_POST['description'] ?? ''));
    $qty = (float)($_POST['qty'] ?? 0);
    $unit = (float)($_POST['unit_price'] ?? 0);

    if (strlen($desc) < 2 || $qty <= 0 || $unit < 0) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Please provide valid item details.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: invoice-view.php?id=' . $invoice_id);
        exit;
    }

    $desc_s = mysqli_real_escape_string($con, $desc);
    $line_total = $qty * $unit;
    $qty_sql = (string)((float)$qty);
    $unit_sql = (string)((float)$unit);
    $line_sql = (string)((float)$line_total);

    mysqli_query(
        $con,
        "INSERT INTO finance_invoice_items (invoice_id, description, qty, unit_price, line_total, created_at)
         VALUES ($invoice_id, '$desc_s', $qty_sql, $unit_sql, $line_sql, NOW())"
    );

    finance_recalc_invoice($con, $invoice_id);

    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Item added.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: invoice-view.php?id=' . $invoice_id);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_item'])) {
    $item_id = (int)($_POST['item_id'] ?? 0);
    if ($item_id > 0) {
        mysqli_query($con, "DELETE FROM finance_invoice_items WHERE id=$item_id AND invoice_id=$invoice_id LIMIT 1");
        finance_recalc_invoice($con, $invoice_id);
        $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Item deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
    header('Location: invoice-view.php?id=' . $invoice_id);
    exit;
}

$inv_rs = mysqli_query(
    $con,
    "SELECT i.*, c.name AS customer_name, c.email AS customer_email, c.phone AS customer_phone, c.address AS customer_address
     FROM finance_invoices i
     JOIN finance_customers c ON c.id=i.customer_id
     WHERE i.id=$invoice_id
     LIMIT 1"
);
$invoice = $inv_rs ? mysqli_fetch_assoc($inv_rs) : null;
if (!$invoice) {
    print "<script>window.location='invoices.php';</script>";
    exit;
}

$summary = finance_recalc_invoice($con, $invoice_id);

$items = [];
$it_rs = mysqli_query($con, "SELECT * FROM finance_invoice_items WHERE invoice_id=$invoice_id ORDER BY id ASC");
if ($it_rs) {
    while ($r = mysqli_fetch_assoc($it_rs)) { $items[] = $r; }
}

$payments = [];
$pay_rs = mysqli_query($con, "SELECT * FROM finance_payments WHERE invoice_id=$invoice_id ORDER BY id DESC LIMIT 50");
if ($pay_rs) {
    while ($r = mysqli_fetch_assoc($pay_rs)) { $payments[] = $r; }
}

$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
$path = isset($_SERVER['SCRIPT_NAME']) ? rtrim(str_replace('invoice-view.php', '', $_SERVER['SCRIPT_NAME']), '/') : '';
$base = $scheme . '://' . $host . $path;
$public_link = $base . '/invoice-view.php?id=' . $invoice_id;

?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Invoice</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="invoices.php">Invoices</a></li>
                <li class="breadcrumb-item active"><?php print htmlspecialchars((string)$invoice['invoice_no']); ?></li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php if (strlen($successmsg)) { print $successmsg; } ?>
      <?php if (strlen($errormsg)) { print $errormsg; } ?>

      <div class="card" id="printArea">
        <div class="card-header d-flex flex-wrap gap-2 align-items-center">
          <div>
            <div class="fs-5 fw-semibold"><?php print htmlspecialchars((string)$invoice['invoice_no']); ?></div>
            <div class="text-muted">Customer: <?php print htmlspecialchars((string)$invoice['customer_name']); ?></div>
          </div>
          <div class="ms-auto d-flex flex-wrap gap-2">
            <a href="payments.php?invoice_id=<?php print (int)$invoice_id; ?>" class="btn btn-soft-success btn-sm">Record Payment</a>
            <button type="button" class="btn btn-soft-secondary btn-sm" onclick="window.print()">Print</button>
            <a href="invoices.php" class="btn btn-light btn-sm">Back</a>
          </div>
        </div>
        <div class="card-body">

          <div class="row g-3 mb-3">
            <div class="col-12 col-md-7">
              <div class="p-3 border rounded-3">
                <div class="fw-semibold">Bill To</div>
                <div><?php print htmlspecialchars((string)$invoice['customer_name']); ?></div>
                <div class="text-muted"><?php print htmlspecialchars((string)$invoice['customer_email']); ?></div>
                <div class="text-muted"><?php print htmlspecialchars((string)$invoice['customer_phone']); ?></div>
                <div class="text-muted" style="white-space:pre-line;"><?php print htmlspecialchars((string)$invoice['customer_address']); ?></div>
              </div>
            </div>
            <div class="col-12 col-md-5">
              <div class="p-3 border rounded-3">
                <div class="d-flex justify-content-between"><span class="text-muted">Status</span><span class="fw-semibold"><?php print htmlspecialchars((string)$summary['status']); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Issue Date</span><span><?php print htmlspecialchars((string)$invoice['issue_date']); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Due Date</span><span><?php print htmlspecialchars((string)$invoice['due_date']); ?></span></div>
                <hr>
                <div class="d-flex justify-content-between"><span class="text-muted">Subtotal</span><span class="fw-semibold"><?php print number_format((float)$summary['subtotal'],2); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Paid</span><span class="fw-semibold"><?php print number_format((float)$summary['paid'],2); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Balance</span><span class="fw-semibold"><?php print number_format((float)$summary['balance'],2); ?></span></div>
              </div>
            </div>
          </div>

          <?php if (strlen(trim((string)$invoice['notes'])) > 0) { ?>
            <div class="alert alert-light border" style="white-space:pre-line;"><?php print htmlspecialchars((string)$invoice['notes']); ?></div>
          <?php } ?>

          <div class="d-flex align-items-center mb-2">
            <h5 class="mb-0">Items</h5>
            <button type="button" class="btn btn-primary btn-sm ms-auto" data-bs-toggle="modal" data-bs-target="#addItemModal">Add Item</button>
          </div>

          <div class="table-responsive">
            <table class="table table-striped align-middle">
              <thead>
                <tr>
                  <th>Description</th>
                  <th class="text-end">Qty</th>
                  <th class="text-end">Unit Price</th>
                  <th class="text-end">Line Total</th>
                  <th class="text-end">Action</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($items) < 1) {
                    print "<tr><td colspan='5' class='text-center text-muted'>No items yet.</td></tr>";
                }
                foreach ($items as $it) {
                    $iid = (int)$it['id'];
                    $ds = htmlspecialchars((string)$it['description']);
                    $qt = (float)$it['qty'];
                    $up = (float)$it['unit_price'];
                    $lt = (float)$it['line_total'];
                    print "<tr>";
                    print "<td>$ds</td>";
                    print "<td class='text-end'>" . number_format($qt,2) . "</td>";
                    print "<td class='text-end'>" . number_format($up,2) . "</td>";
                    print "<td class='text-end fw-semibold'>" . number_format($lt,2) . "</td>";
                    print "<td class='text-end'>";
                    print "<form method='post' class='d-inline'>";
                    print "<input type='hidden' name='delete_item' value='1'>";
                    print "<input type='hidden' name='item_id' value='$iid'>";
                    print "<button type='submit' class='btn btn-sm btn-soft-danger'>Delete</button>";
                    print "</form>";
                    print "</td>";
                    print "</tr>";
                }
                ?>
              </tbody>
            </table>
          </div>

          <?php if (count($payments) > 0) { ?>
            <h5 class="mt-4">Payments</h5>
            <div class="table-responsive">
              <table class="table table-sm table-striped align-middle">
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Method</th>
                    <th>Reference</th>
                    <th class="text-end">Amount</th>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($payments as $p) {
                    $pd = htmlspecialchars((string)$p['paid_at']);
                    $pm = htmlspecialchars((string)$p['method']);
                    $pr = htmlspecialchars((string)$p['reference']);
                    $pa = (float)$p['amount'];
                    print "<tr><td>$pd</td><td>$pm</td><td>$pr</td><td class='text-end fw-semibold'>" . number_format($pa,2) . "</td></tr>";
                  } ?>
                </tbody>
              </table>
            </div>
          <?php } ?>

        </div>
      </div>

      <div class="modal fade" id="addItemModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Add Item</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="addItemForm">
                <input type="hidden" name="add_item" value="1">
                <div class="row g-3">
                  <div class="col-12">
                    <label class="form-label">Description</label>
                    <input type="text" name="description" class="form-control" required>
                  </div>
                  <div class="col-12 col-md-4">
                    <label class="form-label">Qty</label>
                    <input type="number" step="0.01" name="qty" class="form-control" value="1" required>
                  </div>
                  <div class="col-12 col-md-4">
                    <label class="form-label">Unit Price</label>
                    <input type="number" step="0.01" name="unit_price" class="form-control" value="0" required>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="addItemForm" class="btn btn-primary">Add</button>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<style>
@media print {
  body { background: #fff !important; }
  #page-topbar, .app-menu, .footer, .btn, .vertical-overlay { display: none !important; }
  .main-content { margin-left: 0 !important; }
  .page-content { padding: 0 !important; }
  .card { border: none !important; }
}
</style>

<?php include "footer.php"; ?>
