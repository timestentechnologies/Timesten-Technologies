<?php
ob_start();
include "z_db.php";

session_start();
if (!isset($_SESSION['username'])) {
    print "
                <script language='javascript'>
                    window.location = 'login.php';
                </script>
            ";
    exit;
}

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
     (SELECT e.expense_date AS tx_date, 'OUT' AS tx_type, e.amount AS tx_amount, CONCAT('Expense: ', COALESCE(e.vendor,'')) AS tx_ref,
             COALESCE(NULLIF(TRIM(e.vendor),''), NULLIF(TRIM(c.name),''), 'Expense') AS tx_party
      FROM finance_expenses e
      LEFT JOIN finance_expense_categories c ON c.id=e.category_id
      WHERE e.expense_date BETWEEN '$from_sql' AND '$to_sql')
     ORDER BY tx_date DESC"
);
if ($tx_rs) {
    while ($r = mysqli_fetch_assoc($tx_rs)) { $rows[] = $r; }
}

$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = isset($_SERVER['HTTP_HOST']) ? (string)$_SERVER['HTTP_HOST'] : '';
$basePath = isset($_SERVER['SCRIPT_NAME']) ? rtrim(str_replace('\\', '/', dirname((string)$_SERVER['SCRIPT_NAME'])), '/') : '';
$publicBase = $scheme . '://' . $host . $basePath;

if (isset($_GET['pdf']) && $_GET['pdf'] === '1') {
    $company_name = '';
    $company_url = '';
    $company_phone = '';
    $company_email = '';
    $company_address = '';

    $sc_rs = mysqli_query($con, "SELECT site_title, site_url FROM siteconfig WHERE id=1 LIMIT 1");
    $sc = $sc_rs ? mysqli_fetch_assoc($sc_rs) : null;
    if ($sc) {
        if (!empty($sc['site_title'])) { $company_name = (string)$sc['site_title']; }
        if (!empty($sc['site_url'])) { $company_url = (string)$sc['site_url']; }
    }
    if (strlen($company_name) < 1) { $company_name = 'Statement'; }

    $has_addr_col = false;
    $col_rs2 = mysqli_query($con, "SHOW COLUMNS FROM sitecontact LIKE 'address'");
    $has_addr_col = ($col_rs2 && mysqli_num_rows($col_rs2) > 0);
    $ct_sql = $has_addr_col ? "SELECT phone1, email1, address FROM sitecontact WHERE id=1 LIMIT 1" : "SELECT phone1, email1 FROM sitecontact WHERE id=1 LIMIT 1";
    $ct_rs = mysqli_query($con, $ct_sql);
    $ct = $ct_rs ? mysqli_fetch_assoc($ct_rs) : null;
    if ($ct) {
        $company_phone = !empty($ct['phone1']) ? (string)$ct['phone1'] : '';
        $company_email = !empty($ct['email1']) ? (string)$ct['email1'] : '';
        if ($has_addr_col && !empty($ct['address'])) {
            $company_address = (string)$ct['address'];
        }
    }

    $logo_src = '';
    mysqli_query($con, "CREATE TABLE IF NOT EXISTS invoice_settings (id INT PRIMARY KEY, invoice_logo VARCHAR(255) NULL, updated_at DATETIME NULL)");
    mysqli_query($con, "INSERT INTO invoice_settings (id, invoice_logo, updated_at) SELECT 1, '', NOW() WHERE NOT EXISTS (SELECT 1 FROM invoice_settings WHERE id=1)");
    $invset_rs = mysqli_query($con, "SELECT invoice_logo FROM invoice_settings WHERE id=1 LIMIT 1");
    $invset = $invset_rs ? mysqli_fetch_assoc($invset_rs) : null;
    if ($invset && !empty($invset['invoice_logo'])) {
        $logo_src = $publicBase . '/uploads/logo/' . rawurlencode((string)$invset['invoice_logo']);
    }

    $title = 'Statement';
    $sub = 'From ' . htmlspecialchars($from) . ' to ' . htmlspecialchars($to);
    $safe_name = htmlspecialchars($company_name);
    $safe_addr = htmlspecialchars($company_address);
    $safe_phone = htmlspecialchars($company_phone);
    $safe_email = htmlspecialchars($company_email);
    $safe_url = htmlspecialchars($company_url);
    $logo_html = '';
    if (strlen(trim($logo_src)) > 5) {
        $logo_html = "<img src='" . htmlspecialchars($logo_src) . "' style='height:52px;max-width:220px;object-fit:contain;' alt='Logo'>";
    }

    $html = "<!doctype html><html><head><meta charset='utf-8'><style>
      @page{size:A4;margin:0;}
      body{font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#0f172a;margin:0;padding:0;background:#fff;}
      .page{width:210mm;min-height:297mm;margin:0 auto;background:#fff;}
      .sheet{position:relative;width:210mm;min-height:297mm;overflow:hidden;}
      .wrap{position:relative;z-index:2;padding:18px 22px;}

      .decor{position:absolute;z-index:1;pointer-events:none;border-radius:999px;opacity:.22;}
      .decor.tr{right:-48mm;top:-46mm;width:120mm;height:120mm;background:#fde68a;}
      .decor.bl{left:-56mm;bottom:-58mm;width:140mm;height:140mm;background:#ddd6fe;}

      .watermark{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);z-index:1;pointer-events:none;width:160mm;max-width:90%;text-align:center;}
      .watermark img{width:100%;height:auto;opacity:.10;}

      .hdr{display:table;width:100%;margin-bottom:14px;}
      .hdr .l{display:table-cell;vertical-align:top;width:45%;}
      .hdr .r{display:table-cell;vertical-align:top;width:55%;text-align:right;}
      .name{font-weight:800;font-size:14px;margin-top:2px;}
      .muted{color:#64748b;line-height:1.4;}
      .h1{font-size:18px;font-weight:900;margin:0 0 4px 0;}
      .range{color:#475569;margin:0;}
      table{width:100%;border-collapse:collapse;margin-top:10px;}
      th,td{border-bottom:1px solid #e5e7eb;padding:8px 6px;text-align:left;}
      th{background:#f8fafc;color:#475569;font-size:11px;text-transform:uppercase;letter-spacing:.3px;}
      td.num,th.num{text-align:right;}
      .in{color:#16a34a;font-weight:700;}
      .out{color:#dc2626;font-weight:700;}
    </style></head><body><div class='page'><div class='sheet'><div class='decor tr'></div><div class='decor bl'></div>";
    if (strlen(trim($logo_src)) > 5) {
        $html .= "<div class='watermark'><img src='" . htmlspecialchars($logo_src) . "' alt=''></div>";
    }
    $html .= "<div class='wrap'>";
    $html .= "<div class='hdr'><div class='l'>" . $logo_html . "<div class='name'>" . $safe_name . "</div>";
    if (strlen($safe_addr)) { $html .= "<div class='muted'>" . nl2br($safe_addr) . "</div>"; }
    $line = '';
    if (strlen($company_phone)) { $line .= $safe_phone; }
    if (strlen($company_email)) { $line .= (strlen($line) ? ' | ' : '') . $safe_email; }
    if (strlen($company_url)) { $line .= (strlen($line) ? ' | ' : '') . $safe_url; }
    if (strlen($line)) { $html .= "<div class='muted'>" . $line . "</div>"; }
    $html .= "</div><div class='r'><div class='h1'>" . htmlspecialchars($title) . "</div><div class='range'>" . $sub . "</div></div></div>";

    $html .= "<table><thead><tr><th>Date</th><th>Type</th><th>Party</th><th>Reference</th><th class='num'>Amount</th></tr></thead><tbody>";
    foreach ($rows as $r) {
        $dt = htmlspecialchars((string)$r['tx_date']);
        $tp = htmlspecialchars((string)$r['tx_type']);
        $pt = htmlspecialchars((string)$r['tx_party']);
        $rf = htmlspecialchars((string)$r['tx_ref']);
        $am = (float)$r['tx_amount'];
        $cls = $tp === 'IN' ? 'in' : 'out';
        $html .= "<tr><td>$dt</td><td class='$cls'>$tp</td><td>$pt</td><td>$rf</td><td class='num $cls'>" . number_format($am, 2) . "</td></tr>";
    }
    if (count($rows) < 1) {
        $html .= "<tr><td colspan='5' class='muted'>No transactions in this range.</td></tr>";
    }
    $html .= "</tbody></table></div></div></div></body></html>";

    $autoload = __DIR__ . '/../vendor/autoload.php';
    if (!file_exists($autoload)) {
        header('Content-Type: text/html; charset=utf-8');
        echo $html;
        exit;
    }
    require_once $autoload;
    if (!class_exists('Dompdf\\Dompdf')) {
        header('Content-Type: text/html; charset=utf-8');
        echo $html;
        exit;
    }
    $options = new Dompdf\Options();
    $options->set('isRemoteEnabled', true);
    $dompdf = new Dompdf\Dompdf($options);
    $dompdf->loadHtml($html);
    $dompdf->setPaper('A4', 'portrait');
    $dompdf->render();
    $fn = 'statement_' . preg_replace('/[^0-9\-]/', '', $from) . '_to_' . preg_replace('/[^0-9\-]/', '', $to) . '.pdf';
    $dompdf->stream($fn, array('Attachment' => true));
    exit;
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

<?php
include "header.php";
include "sidebar.php";
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
            <div class="col-12 col-md-3">
              <label class="form-label">Search</label>
              <input type="text" id="statementSearch" class="form-control" placeholder="Type to filter...">
            </div>
            <div class="col-12 col-md-3 d-flex gap-2">
              <button type="submit" class="btn btn-primary">Apply</button>
              <a class="btn btn-soft-secondary" href="statement.php?from=<?php print urlencode($from); ?>&to=<?php print urlencode($to); ?>&export=1">Export CSV</a>
              <a class="btn btn-soft-primary" href="statement.php?from=<?php print urlencode($from); ?>&to=<?php print urlencode($to); ?>&pdf=1" target="_blank">Export PDF</a>
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
            <table class="table table-striped align-middle mb-0" id="statementTable">
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

<script>
(function(){
  var input = document.getElementById('statementSearch');
  var table = document.getElementById('statementTable');
  if (!input || !table) return;
  var tbody = table.querySelector('tbody');
  if (!tbody) return;

  function filter(){
    var q = (input.value || '').toLowerCase().trim();
    var rows = tbody.querySelectorAll('tr');
    rows.forEach(function(tr){
      var t = (tr.innerText || '').toLowerCase();
      tr.style.display = (q === '' || t.indexOf(q) !== -1) ? '' : 'none';
    });
  }

  input.addEventListener('input', filter);
})();
</script>
