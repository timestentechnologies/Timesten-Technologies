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
  product_id INT NULL,
  description VARCHAR(255) NOT NULL,
  qty DECIMAL(12,2) NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  line_total DECIMAL(12,2) NOT NULL,
  created_at DATETIME NULL
 )");

 $col_rs2 = mysqli_query($con, "SHOW COLUMNS FROM finance_invoice_items LIKE 'product_id'");
 if (!$col_rs2 || mysqli_num_rows($col_rs2) < 1) {
     @mysqli_query($con, "ALTER TABLE finance_invoice_items ADD COLUMN product_id INT NULL AFTER invoice_id");
 }

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

$customers = [];
$c_rs = mysqli_query($con, "SELECT id, name FROM finance_customers ORDER BY name ASC");
if ($c_rs) {
    while ($r = mysqli_fetch_assoc($c_rs)) { $customers[] = $r; }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create_invoice'])) {
    $customer_id = (int)($_POST['customer_id'] ?? 0);
    $issue_date = trim((string)($_POST['issue_date'] ?? ''));
    $due_date = trim((string)($_POST['due_date'] ?? ''));
    $status = trim((string)($_POST['status'] ?? 'draft'));
    $notes = trim((string)($_POST['notes'] ?? ''));

    if ($customer_id < 1) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Please select a customer.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: invoices.php');
        exit;
    }

    $status_allowed = ['draft','sent','paid','partial','void'];
    if (!in_array($status, $status_allowed, true)) { $status = 'draft'; }

    $inv_no = 'INV-' . date('Ymd') . '-' . rand(1000, 9999);
    $inv_no_s = mysqli_real_escape_string($con, $inv_no);
    $status_s = mysqli_real_escape_string($con, $status);
    $notes_s = mysqli_real_escape_string($con, $notes);

    $issue_sql = strlen($issue_date) ? ("'" . mysqli_real_escape_string($con, $issue_date) . "'") : 'NULL';
    $due_sql = strlen($due_date) ? ("'" . mysqli_real_escape_string($con, $due_date) . "'") : 'NULL';

    mysqli_query(
        $con,
        "INSERT INTO finance_invoices (invoice_no, customer_id, issue_date, due_date, status, notes, subtotal, total, amount_paid, created_at)
         VALUES ('$inv_no_s', $customer_id, $issue_sql, $due_sql, '$status_s', '$notes_s', 0, 0, 0, NOW())"
    );

    $invoice_id = (int)mysqli_insert_id($con);
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Invoice created. Add items next.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: invoice-view.php?id=' . $invoice_id);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_invoice'])) {
    $id = (int)($_POST['id'] ?? 0);
    $customer_id = (int)($_POST['customer_id'] ?? 0);
    $issue_date = trim((string)($_POST['issue_date'] ?? ''));
    $due_date = trim((string)($_POST['due_date'] ?? ''));
    $status = trim((string)($_POST['status'] ?? 'draft'));
    $notes = trim((string)($_POST['notes'] ?? ''));

    if ($id < 1 || $customer_id < 1) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Invalid invoice data.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: invoices.php');
        exit;
    }

    $status_allowed = ['draft','sent','paid','partial','void'];
    if (!in_array($status, $status_allowed, true)) { $status = 'draft'; }

    $status_s = mysqli_real_escape_string($con, $status);
    $notes_s = mysqli_real_escape_string($con, $notes);

    $issue_sql = strlen($issue_date) ? ("'" . mysqli_real_escape_string($con, $issue_date) . "'") : 'NULL';
    $due_sql = strlen($due_date) ? ("'" . mysqli_real_escape_string($con, $due_date) . "'") : 'NULL';

    mysqli_query(
        $con,
        "UPDATE finance_invoices SET customer_id=$customer_id, issue_date=$issue_sql, due_date=$due_sql, status='$status_s', notes='$notes_s' WHERE id=$id LIMIT 1"
    );

    finance_recalc_invoice($con, $id);

    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Invoice updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: invoices.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_invoice'])) {
    $id = (int)($_POST['id'] ?? 0);
    if ($id > 0) {
        mysqli_query($con, "DELETE FROM finance_invoice_items WHERE invoice_id=$id");
        mysqli_query($con, "DELETE FROM finance_payments WHERE invoice_id=$id");
        mysqli_query($con, "DELETE FROM finance_invoices WHERE id=$id LIMIT 1");
        $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Invoice deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
    header('Location: invoices.php');
    exit;
}

$invoices = [];
$inv_rs = mysqli_query(
    $con,
    "SELECT i.*, c.name AS customer_name
     FROM finance_invoices i
     JOIN finance_customers c ON c.id=i.customer_id
     ORDER BY i.id DESC"
);
if ($inv_rs) {
    while ($r = mysqli_fetch_assoc($inv_rs)) {
        if (isset($r['id'])) {
            finance_recalc_invoice($con, (int)$r['id']);
        }
        $invoices[] = $r;
    }
}

$inv_rs2 = mysqli_query(
    $con,
    "SELECT i.*, c.name AS customer_name
     FROM finance_invoices i
     JOIN finance_customers c ON c.id=i.customer_id
     ORDER BY i.id DESC"
);
$invoices = [];
if ($inv_rs2) {
    while ($r = mysqli_fetch_assoc($inv_rs2)) { $invoices[] = $r; }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Invoices</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">Finance</a></li>
                <li class="breadcrumb-item active">Invoices</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php if (strlen($successmsg)) { print $successmsg; } ?>
      <?php if (strlen($errormsg)) { print $errormsg; } ?>

      <div class="card">
        <div class="card-header d-flex align-items-center">
          <h5 class="card-title mb-0">Invoices</h5>
          <button type="button" class="btn btn-primary btn-sm ms-auto" data-bs-toggle="modal" data-bs-target="#createInvoiceModal">Create Invoice</button>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped align-middle mb-0">
              <thead>
                <tr>
                  <th>Invoice</th>
                  <th>Customer</th>
                  <th>Status</th>
                  <th class="text-end">Total</th>
                  <th class="text-end">Paid</th>
                  <th class="text-end">Balance</th>
                  <th>Issue</th>
                  <th>Due</th>
                  <th class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($invoices) < 1) {
                    print "<tr><td colspan='9' class='text-center text-muted'>No invoices yet.</td></tr>";
                }
                foreach ($invoices as $i) {
                    $id = (int)$i['id'];
                    $no = htmlspecialchars((string)$i['invoice_no']);
                    $cn = htmlspecialchars((string)$i['customer_name']);
                    $st = htmlspecialchars((string)$i['status']);
                    $total = (float)($i['total'] ?? 0);
                    $paid = (float)($i['amount_paid'] ?? 0);
                    $bal = $total - $paid;
                    $issue = htmlspecialchars((string)$i['issue_date']);
                    $due = htmlspecialchars((string)$i['due_date']);
                    $notes = htmlspecialchars((string)$i['notes']);
                    $cust_id = (int)$i['customer_id'];

                    $badge = 'secondary';
                    if ($st === 'paid') $badge = 'success';
                    elseif ($st === 'partial') $badge = 'warning';
                    elseif ($st === 'sent') $badge = 'info';
                    elseif ($st === 'void') $badge = 'danger';

                    print "<tr>";
                    print "<td><a href='invoice-view.php?id=$id' class='fw-semibold text-decoration-none'>$no</a></td>";
                    print "<td>$cn</td>";
                    print "<td><span class='badge bg-$badge'>$st</span></td>";
                    print "<td class='text-end'>" . number_format($total, 2) . "</td>";
                    print "<td class='text-end'>" . number_format($paid, 2) . "</td>";
                    print "<td class='text-end'>" . number_format($bal, 2) . "</td>";
                    print "<td>$issue</td><td>$due</td>";
                    print "<td class='text-end'>";
                    print "<a class='btn btn-sm btn-soft-primary' href='invoice-view.php?id=$id'>Open</a> ";
                    print "<button type='button' class='btn btn-sm btn-soft-secondary js-inv-edit' data-id='$id' data-customer='$cust_id' data-issue='$issue' data-due='$due' data-status='$st' data-notes='$notes'>Edit</button> ";
                    print "<button type='button' class='btn btn-sm btn-soft-danger js-inv-del' data-id='$id' data-name='$no'>Delete</button>";
                    print "</td>";
                    print "</tr>";
                }
                ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div class="modal fade" id="createInvoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Create Invoice</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="createInvoiceForm">
                <input type="hidden" name="create_invoice" value="1">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label">Customer</label>
                    <select name="customer_id" class="form-select" required>
                      <option value="">Select...</option>
                      <?php foreach ($customers as $c) {
                        $cid = (int)$c['id'];
                        $cn = htmlspecialchars((string)$c['name']);
                        print "<option value='$cid'>$cn</option>";
                      } ?>
                    </select>
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Issue Date</label>
                    <input type="date" name="issue_date" class="form-control" value="<?php print date('Y-m-d'); ?>">
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Due Date</label>
                    <input type="date" name="due_date" class="form-control">
                  </div>
                  <div class="col-12 col-md-4">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">
                      <option value="draft">Draft</option>
                      <option value="sent">Sent</option>
                      <option value="void">Void</option>
                    </select>
                  </div>
                  <div class="col-12">
                    <label class="form-label">Notes</label>
                    <textarea name="notes" class="form-control" rows="2"></textarea>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="createInvoiceForm" class="btn btn-primary">Create</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="editInvoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Invoice</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="editInvoiceForm">
                <input type="hidden" name="update_invoice" value="1">
                <input type="hidden" name="id" id="e_id" value="">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label">Customer</label>
                    <select name="customer_id" id="e_customer" class="form-select" required>
                      <option value="">Select...</option>
                      <?php foreach ($customers as $c) {
                        $cid = (int)$c['id'];
                        $cn = htmlspecialchars((string)$c['name']);
                        print "<option value='$cid'>$cn</option>";
                      } ?>
                    </select>
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Issue Date</label>
                    <input type="date" name="issue_date" id="e_issue" class="form-control">
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Due Date</label>
                    <input type="date" name="due_date" id="e_due" class="form-control">
                  </div>
                  <div class="col-12 col-md-4">
                    <label class="form-label">Status</label>
                    <select name="status" id="e_status" class="form-select">
                      <option value="draft">Draft</option>
                      <option value="sent">Sent</option>
                      <option value="partial">Partial</option>
                      <option value="paid">Paid</option>
                      <option value="void">Void</option>
                    </select>
                  </div>
                  <div class="col-12">
                    <label class="form-label">Notes</label>
                    <textarea name="notes" id="e_notes" class="form-control" rows="2"></textarea>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="editInvoiceForm" class="btn btn-primary">Update</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="deleteInvoiceModal" tabindex="-1" aria-hidden="true">
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
                <input type="hidden" name="delete_invoice" value="1">
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
  function init(){
    if (!window.bootstrap) return;
    var editEl = document.getElementById('editInvoiceModal');
    var delEl = document.getElementById('deleteInvoiceModal');
    var editModal = editEl ? new bootstrap.Modal(editEl) : null;
    var delModal = delEl ? new bootstrap.Modal(delEl) : null;

    document.addEventListener('click', function(e){
      var btn = e.target && e.target.closest ? e.target.closest('.js-inv-edit') : null;
      if (!btn || !editModal) return;
      document.getElementById('e_id').value = btn.getAttribute('data-id') || '';
      document.getElementById('e_customer').value = btn.getAttribute('data-customer') || '';
      document.getElementById('e_issue').value = btn.getAttribute('data-issue') || '';
      document.getElementById('e_due').value = btn.getAttribute('data-due') || '';
      document.getElementById('e_status').value = btn.getAttribute('data-status') || 'draft';
      document.getElementById('e_notes').value = btn.getAttribute('data-notes') || '';
      editModal.show();
    });

    document.addEventListener('click', function(e){
      var btn = e.target && e.target.closest ? e.target.closest('.js-inv-del') : null;
      if (!btn || !delModal) return;
      document.getElementById('d_id').value = btn.getAttribute('data-id') || '';
      document.getElementById('d_name').textContent = btn.getAttribute('data-name') || '';
      delModal.show();
    });
  }

  if (document.readyState === 'complete') {
    init();
  } else {
    window.addEventListener('load', init);
  }
})();
</script>

<?php include "footer.php"; ?>
