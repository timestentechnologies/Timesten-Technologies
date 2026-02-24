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
  payment_method VARCHAR(50) NULL,
  reference VARCHAR(120) NULL,
  receipt_file VARCHAR(255) NULL,
  created_at DATETIME NULL
)");

$from = isset($_GET['from']) ? (string)$_GET['from'] : date('Y-m-01');
$to = isset($_GET['to']) ? (string)$_GET['to'] : date('Y-m-d');
$from_sql = mysqli_real_escape_string($con, $from);
$to_sql = mysqli_real_escape_string($con, $to);

$money_in_rs = mysqli_query($con, "SELECT COALESCE(SUM(amount),0) AS s FROM finance_payments WHERE paid_at BETWEEN '$from_sql' AND '$to_sql'");
$money_in_row = $money_in_rs ? mysqli_fetch_assoc($money_in_rs) : null;
$money_in = $money_in_row ? (float)$money_in_row['s'] : 0.0;

$money_out_rs = mysqli_query($con, "SELECT COALESCE(SUM(amount),0) AS s FROM finance_expenses WHERE expense_date BETWEEN '$from_sql' AND '$to_sql'");
$money_out_row = $money_out_rs ? mysqli_fetch_assoc($money_out_rs) : null;
$money_out = $money_out_row ? (float)$money_out_row['s'] : 0.0;

$net = $money_in - $money_out;

$rows = [];
$tx_rs = mysqli_query(
    $con,
    "(SELECT paid_at AS tx_date, 'IN' AS tx_type, amount AS tx_amount, CONCAT('Payment: ', i.invoice_no) AS tx_ref, c.name AS tx_party
      FROM finance_payments p
      JOIN finance_invoices i ON i.id=p.invoice_id
      JOIN finance_customers c ON c.id=p.customer_id
      WHERE p.paid_at BETWEEN '$from_sql' AND '$to_sql')
     UNION ALL
     (SELECT expense_date AS tx_date, 'OUT' AS tx_type, amount AS tx_amount, CONCAT('Expense: ', COALESCE(vendor,'')) AS tx_ref, '' AS tx_party
      FROM finance_expenses e
      WHERE e.expense_date BETWEEN '$from_sql' AND '$to_sql')
     ORDER BY tx_date DESC"
);
if ($tx_rs) {
    while ($r = mysqli_fetch_assoc($tx_rs)) { $rows[] = $r; }
}

if (isset($_GET['export']) && $_GET['export'] === '1') {
    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="statement_' . $from . '_to_' . $to . '.csv"');
    $out = fopen('php://output', 'w');
    fputcsv($out, ['Date', 'Type', 'Party', 'Reference', 'Amount']);
    foreach ($rows as $r) {
        fputcsv($out, [$r['tx_date'], $r['tx_type'], $r['tx_party'], $r['tx_ref'], $r['tx_amount']]);
    }
    fclose($out);
    exit;
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Statement</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">Finance</a></li>
                <li class="breadcrumb-item active">Statement</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <form method="get" class="row g-2 align-items-end">
            <div class="col-12 col-md-3">
              <label class="form-label">From</label>
              <input type="date" name="from" class="form-control" value="<?php print htmlspecialchars($from); ?>">
            </div>
            <div class="col-12 col-md-3">
              <label class="form-label">To</label>
              <input type="date" name="to" class="form-control" value="<?php print htmlspecialchars($to); ?>">
            </div>
            <div class="col-12 col-md-6 d-flex gap-2">
              <button type="submit" class="btn btn-primary">Apply</button>
              <a class="btn btn-soft-secondary" href="statement.php?from=<?php print urlencode($from); ?>&to=<?php print urlencode($to); ?>&export=1">Export CSV</a>
            </div>
          </form>
        </div>
        <div class="card-body">
          <div class="row g-3 mb-3">
            <div class="col-12 col-md-4">
              <div class="p-3 border rounded-3">
                <div class="text-muted">Money In</div>
                <div class="fs-4 fw-semibold text-success"><?php print number_format($money_in,2); ?></div>
              </div>
            </div>
            <div class="col-12 col-md-4">
              <div class="p-3 border rounded-3">
                <div class="text-muted">Money Out</div>
                <div class="fs-4 fw-semibold text-danger"><?php print number_format($money_out,2); ?></div>
              </div>
            </div>
            <div class="col-12 col-md-4">
              <div class="p-3 border rounded-3">
                <div class="text-muted">Net</div>
                <div class="fs-4 fw-semibold"><?php print number_format($net,2); ?></div>
              </div>
            </div>
          </div>

          <div class="table-responsive">
            <table class="table table-striped align-middle mb-0">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Type</th>
                  <th>Party</th>
                  <th>Reference</th>
                  <th class="text-end">Amount</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($rows) < 1) {
                    print "<tr><td colspan='5' class='text-center text-muted'>No transactions in this range.</td></tr>";
                }
                foreach ($rows as $r) {
                    $dt = htmlspecialchars((string)$r['tx_date']);
                    $tp = htmlspecialchars((string)$r['tx_type']);
                    $pt = htmlspecialchars((string)$r['tx_party']);
                    $rf = htmlspecialchars((string)$r['tx_ref']);
                    $am = (float)$r['tx_amount'];
                    $cls = $tp === 'IN' ? 'text-success' : 'text-danger';
                    print "<tr><td>$dt</td><td><span class='fw-semibold $cls'>$tp</span></td><td>$pt</td><td>$rf</td><td class='text-end fw-semibold $cls'>" . number_format($am,2) . "</td></tr>";
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
