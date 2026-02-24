<?php
ob_start();

$invoice_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$is_print = isset($_GET['print']) && (string)$_GET['print'] === '1';
$is_pdf = isset($_GET['pdf']) && (string)$_GET['pdf'] === '1';

if ($is_print || $is_pdf) {
    include "z_db.php";
    session_start();
    if (!isset($_SESSION['username'])) {
        print "<script>window.location='login.php';</script>";
        exit;
    }

    mysqli_query($con, "CREATE TABLE IF NOT EXISTS invoice_settings (
      id INT PRIMARY KEY,
      invoice_logo VARCHAR(255) NULL,
      updated_at DATETIME NULL
    )");
    mysqli_query(
        $con,
        "INSERT INTO invoice_settings (id, invoice_logo, updated_at)
         SELECT 1, '', NOW()
         WHERE NOT EXISTS (SELECT 1 FROM invoice_settings WHERE id=1)"
    );

    mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_customers (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(160) NOT NULL,
      email VARCHAR(160) NULL,
      phone VARCHAR(80) NULL,
      service VARCHAR(160) NULL,
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
      tax_rate DECIMAL(6,2) NULL,
      tax_exempt TINYINT(1) NULL,
      total DECIMAL(12,2) NULL,
      amount_paid DECIMAL(12,2) NULL,
      created_at DATETIME NULL,
      UNIQUE KEY uniq_invoice_no (invoice_no)
     )");

    $col_tax_rate = mysqli_query($con, "SHOW COLUMNS FROM finance_invoices LIKE 'tax_rate'");
    if (!$col_tax_rate || mysqli_num_rows($col_tax_rate) < 1) {
        @mysqli_query($con, "ALTER TABLE finance_invoices ADD COLUMN tax_rate DECIMAL(6,2) NULL AFTER subtotal");
    }
    $col_tax_exempt = mysqli_query($con, "SHOW COLUMNS FROM finance_invoices LIKE 'tax_exempt'");
    if (!$col_tax_exempt || mysqli_num_rows($col_tax_exempt) < 1) {
        @mysqli_query($con, "ALTER TABLE finance_invoices ADD COLUMN tax_exempt TINYINT(1) NULL AFTER tax_rate");
    }
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

    if ($invoice_id < 1) {
        print "<script>window.location='invoices.php';</script>";
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

    $items = [];
    $it_rs = mysqli_query($con, "SELECT * FROM finance_invoice_items WHERE invoice_id=$invoice_id ORDER BY id ASC");
    if ($it_rs) {
        while ($r = mysqli_fetch_assoc($it_rs)) { $items[] = $r; }
    }

    $items_rs2 = mysqli_query($con, "SELECT COALESCE(SUM(line_total),0) AS s FROM finance_invoice_items WHERE invoice_id=$invoice_id");
    $items_row2 = $items_rs2 ? mysqli_fetch_assoc($items_rs2) : null;
    $subtotal = $items_row2 ? (float)$items_row2['s'] : 0.0;

    $pay_rs2 = mysqli_query($con, "SELECT COALESCE(SUM(amount),0) AS s FROM finance_payments WHERE invoice_id=$invoice_id");
    $pay_row2 = $pay_rs2 ? mysqli_fetch_assoc($pay_rs2) : null;
    $paid = $pay_row2 ? (float)$pay_row2['s'] : 0.0;

    $tax_rate = isset($invoice['tax_rate']) ? (float)$invoice['tax_rate'] : 0.0;
    $tax_exempt = !empty($invoice['tax_exempt']) ? 1 : 0;
    if ($tax_rate < 0) { $tax_rate = 0.0; }
    if ($tax_rate > 100) { $tax_rate = 100.0; }
    $tax_amount = $tax_exempt ? 0.0 : (($subtotal * $tax_rate) / 100.0);

    $total = $subtotal + $tax_amount;
    $balance = $total - $paid;

    $company_name = 'TimesTen Technologies';
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

    $col_rs = mysqli_query($con, "SHOW COLUMNS FROM sitecontact LIKE 'address'");
    $has_addr_col = ($col_rs && mysqli_num_rows($col_rs) > 0);

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

    $logo_path = 'assets/images/logo-dark.png';

    $invset_rs = mysqli_query($con, "SELECT invoice_logo FROM invoice_settings WHERE id=1 LIMIT 1");
    $invset = $invset_rs ? mysqli_fetch_assoc($invset_rs) : null;
    if ($invset && !empty($invset['invoice_logo'])) {
        $logo_path = 'uploads/logo/' . (string)$invset['invoice_logo'];
    }

    $lg_rs = mysqli_query($con, "SELECT ufile FROM logo LIMIT 1");
    $lg = $lg_rs ? mysqli_fetch_row($lg_rs) : null;
    if ($logo_path === 'assets/images/logo-dark.png' && $lg && !empty($lg[0])) {
        $logo_path = 'uploads/logo/' . $lg[0];
    }

    $logo_src = $logo_path;
    if ($is_pdf) {
        $logo_abs = @realpath(__DIR__ . '/' . $logo_path);
        if ($logo_abs && is_file($logo_abs)) {
            $mime = '';
            if (function_exists('finfo_open')) {
                $fi = @finfo_open(FILEINFO_MIME_TYPE);
                if ($fi) {
                    $mime = (string)@finfo_file($fi, $logo_abs);
                    @finfo_close($fi);
                }
            }
            if (strlen($mime) < 3) {
                $ext = strtolower((string)pathinfo($logo_abs, PATHINFO_EXTENSION));
                if ($ext === 'png') { $mime = 'image/png'; }
                elseif ($ext === 'jpg' || $ext === 'jpeg') { $mime = 'image/jpeg'; }
                elseif ($ext === 'gif') { $mime = 'image/gif'; }
                elseif ($ext === 'svg') { $mime = 'image/svg+xml'; }
            }

            $bin = @file_get_contents($logo_abs);
            if ($bin !== false && strlen($mime) > 3) {
                $logo_src = 'data:' . $mime . ';base64,' . base64_encode($bin);
            } else {
                $logo_src = 'file://' . $logo_abs;
            }
        }
    }

    $inv_no = htmlspecialchars((string)$invoice['invoice_no']);
    $cust_name = htmlspecialchars((string)$invoice['customer_name']);
    $cust_email = htmlspecialchars((string)$invoice['customer_email']);
    $cust_phone = htmlspecialchars((string)$invoice['customer_phone']);
    $cust_address = htmlspecialchars((string)$invoice['customer_address']);
    $issue_date = htmlspecialchars((string)$invoice['issue_date']);
    $due_date = htmlspecialchars((string)$invoice['due_date']);
    $notes = (string)$invoice['notes'];

    $today = date('Y-m-d');
    $autoprint = isset($_GET['autoprint']) && (string)$_GET['autoprint'] === '1';

    ?>
    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Invoice <?php print $inv_no; ?></title>
      <style>
        :root{
          --primary:#f97316;
          --accent:#7c3aed;
          --accent_dark:#4c1d95;
          --success:#16a34a;
          --danger:#dc2626;
          --text:#0f172a;
          --muted:#64748b;
          --border:#e5e7eb;
          --bg:#ffffff;
          --panel:#f3f6fb;
        }
        *{box-sizing:border-box;}
        html, body{margin:0;padding:0;background:var(--panel);font-family:Arial, Helvetica, sans-serif;color:var(--text);}

        /* A4 canvas (works consistently for both Print and Dompdf PDF) */
        .page{width:210mm;margin:0 auto;padding:0;}
        .sheet{background:var(--bg);border:1px solid var(--border);border-radius:16px;overflow:hidden;box-shadow:0 10px 34px rgba(15,23,42,.10);position:relative;}

        /* Decorative shapes (use real DOM nodes because Dompdf may ignore :before/:after) */
        .decor{position:absolute;border-radius:999px;pointer-events:none;z-index:0;}
        .decor.tr{width:160mm;height:160mm;top:-110mm;right:-110mm;background:var(--primary);opacity:.12;}
        .decor.bl{width:160mm;height:160mm;bottom:-85mm;left:-85mm;background:var(--accent);opacity:.10;}

        .topbar{padding:14px 22px;border-bottom:1px solid rgba(226,232,240,.9);display:flex;gap:14px;align-items:center;background:transparent;}
        .brand{display:flex;gap:12px;align-items:center;}
        .brand img{height:58px;max-width:320px;object-fit:contain;}
        .brand-title{font-weight:800;letter-spacing:.2px;}
        .tag{margin-left:auto;text-align:right;}
        .tag .label{font-size:12px;color:var(--muted);}
        .tag .value{font-size:18px;font-weight:900;color:var(--accent_dark);}

        .content{padding:18px 22px;position:relative;z-index:1;}
        /* Avoid relying on flex gap (Dompdf may not support it reliably) */
        .grid{display:flex;flex-wrap:wrap;margin:-8px;}
        .col{flex:1;min-width:260px;padding:8px;}
        .card{border:1px solid rgba(226,232,240,.9);border-radius:12px;padding:14px;background:rgba(255,255,255,.82);box-shadow:0 8px 22px rgba(15,23,42,.05);}
        .card h4{margin:0 0 8px 0;font-size:13px;letter-spacing:.3px;text-transform:uppercase;color:var(--muted);}
        .row{display:flex;justify-content:space-between;gap:12px;margin:4px 0;}
        .row .k{color:var(--muted);font-size:12px;}
        .row .v{font-weight:700;font-size:12px;text-align:right;}
        .amt.paid{color:var(--success);font-weight:900;}
        .amt.due{color:var(--danger);font-weight:900;}

        table{width:100%;border-collapse:collapse;margin-top:14px;}
        thead th{font-size:12px;text-transform:uppercase;letter-spacing:.35px;color:var(--muted);text-align:left;border-bottom:1px solid rgba(226,232,240,.9);padding:10px 8px;background:rgba(241,245,249,.55);}
        tbody td{padding:10px 8px;border-bottom:1px solid #f1f5f9;font-size:13px;vertical-align:top;}
        td.num, th.num{text-align:right;}
        /* Avoid relying on flex justify-content (Dompdf can misplace) */
        .totals{width:100%;margin-top:14px;}
        .totals .box{width:340px;border:1px solid var(--border);border-radius:12px;padding:12px;margin-left:auto;}
        .totals .box .row .v{font-size:13px;}
        .totals .box .grand{padding-top:8px;margin-top:8px;border-top:1px dashed var(--border);}
        .totals .box .grand .v{font-size:16px;color:var(--accent);}

        .notes{margin-top:14px;border-left:4px solid var(--primary);background:#f8fafc;padding:10px 12px;border-radius:10px;white-space:pre-line;}
        .footer{padding:12px 22px;border-top:1px solid var(--border);display:flex;gap:10px;justify-content:space-between;align-items:center;flex-wrap:wrap;position:relative;z-index:1;}
        .footer .small{font-size:12px;color:var(--muted);}
        .btns{display:flex;gap:8px;}
        .btn{border:1px solid var(--border);background:#fff;padding:8px 10px;border-radius:10px;font-size:12px;cursor:pointer;}
        .btn.primary{border-color:var(--primary);color:var(--primary);}

        .hint{margin-top:10px;font-size:11px;color:var(--muted);}

        .pdf .btns{display:none !important;}
        .pdf .hint{display:none !important;}
        .pdf, .pdf body{background:#fff !important;}
        .pdf .page{margin:0 auto;}
        .pdf .sheet{height:297mm;border:none;border-radius:0;box-shadow:none;}

        /* Dompdf can be unreliable with flex centering; use absolute centering */
        .watermark{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);z-index:1;pointer-events:none;width:160mm;max-width:90%;text-align:center;}
        .watermark img{width:100%;height:auto;opacity:.18;}
        .topbar{position:relative;z-index:2;}
        .content{position:relative;z-index:2;}
        .footer{position:relative;z-index:2;}

        @page{size:A4;margin:0;}
        @media print{
          body{background:#fff;}
          .page{width:auto;min-height:auto;margin:0;padding:0;}
          .sheet{border:none;border-radius:0;box-shadow:none;}
          .btns{display:none !important;}
          .hint{display:none !important;}
          *{-webkit-print-color-adjust:exact;print-color-adjust:exact;}
        }

        @media screen{
          .page{margin:10mm auto;}
        }
      </style>
    </head>
    <body class="<?php print ($is_pdf ? 'pdf' : ''); ?>">
      <div class="page">
        <div class="sheet">
          <div class="decor tr"></div>
          <div class="decor bl"></div>
          <div class="watermark"><img src="<?php print htmlspecialchars($logo_src); ?>" alt=""></div>
          <div class="topbar">
            <div class="brand">
              <img src="<?php print htmlspecialchars($logo_src); ?>" alt="Logo">
              <div>
                <div class="brand-title"><?php print htmlspecialchars($company_name); ?></div>
                <?php if (strlen(trim($company_address)) > 0) { ?>
                  <div class="small" style="color:var(--muted);font-size:12px;white-space:pre-line;"><?php print htmlspecialchars($company_address); ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="tag">
              <div class="label">Invoice</div>
              <div class="value"><?php print $inv_no; ?></div>
              <div class="label">Date: <?php print htmlspecialchars($today); ?></div>
            </div>
          </div>

          <div class="content">
            <div class="grid">
              <div class="col">
                <div class="card">
                  <h4>Billed From</h4>
                  <div style="font-weight:800;font-size:13px;"><?php print htmlspecialchars($company_name); ?></div>
                  <?php if (strlen(trim($company_email))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_email); ?></div><?php } ?>
                  <?php if (strlen(trim($company_phone))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_phone); ?></div><?php } ?>
                  <?php if (strlen(trim($company_url))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_url); ?></div><?php } ?>
                </div>
              </div>
              <div class="col">
                <div class="card">
                  <h4>Billed To</h4>
                  <div style="font-weight:800;font-size:13px;"><?php print $cust_name; ?></div>
                  <?php if (strlen(trim($cust_email))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print $cust_email; ?></div><?php } ?>
                  <?php if (strlen(trim($cust_phone))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print $cust_phone; ?></div><?php } ?>
                  <?php if (strlen(trim($cust_address))>0) { ?><div style="font-size:12px;color:var(--muted);white-space:pre-line;"><?php print $cust_address; ?></div><?php } ?>
                </div>
              </div>
              <div class="col">
                <div class="card">
                  <h4>Details</h4>
                  <div class="row"><div class="k">Issue Date</div><div class="v"><?php print $issue_date; ?></div></div>
                  <div class="row"><div class="k">Due Date</div><div class="v"><?php print $due_date; ?></div></div>
                  <div class="row"><div class="k">Subtotal</div><div class="v"><?php print number_format($subtotal,2); ?></div></div>
                  <div class="row"><div class="k">Tax<?php if (!empty($tax_exempt)) { print ' (Exempt)'; } else { print ' (' . number_format((float)$tax_rate,2) . '%)'; } ?></div><div class="v"><?php print number_format((float)$tax_amount,2); ?></div></div>
                  <div class="row"><div class="k">Total</div><div class="v"><?php print number_format($total,2); ?></div></div>
                  <div class="row"><div class="k">Paid</div><div class="v"><span class="amt paid"><?php print number_format($paid,2); ?></span></div></div>
                  <div class="row"><div class="k">Balance</div><div class="v"><span class="amt due"><?php print number_format($balance,2); ?></span></div></div>
                </div>
              </div>
            </div>

            <table>
              <thead>
                <tr>
                  <th style="width:52%;">Description</th>
                  <th class="num" style="width:12%;">Qty</th>
                  <th class="num" style="width:18%;">Unit Price</th>
                  <th class="num" style="width:18%;">Line Total</th>
                </tr>
              </thead>
              <tbody>
                <?php
                  if (count($items) < 1) {
                      print "<tr><td colspan='4' style='text-align:center;color:#64748b;padding:18px 8px;'>No items yet.</td></tr>";
                  }
                  foreach ($items as $it) {
                      $ds = htmlspecialchars((string)$it['description']);
                      $qt = (float)$it['qty'];
                      $up = (float)$it['unit_price'];
                      $lt = (float)$it['line_total'];
                      print "<tr>";
                      print "<td>$ds</td>";
                      print "<td class='num'>" . number_format($qt,2) . "</td>";
                      print "<td class='num'>" . number_format($up,2) . "</td>";
                      print "<td class='num' style='font-weight:800;'>" . number_format($lt,2) . "</td>";
                      print "</tr>";
                  }
                ?>
              </tbody>
            </table>

            <div class="totals">
              <div class="box">
                <div class="row"><div class="k">Subtotal</div><div class="v"><?php print number_format($subtotal,2); ?></div></div>
                <div class="row"><div class="k">Tax<?php if (!empty($tax_exempt)) { print ' (Exempt)'; } else { print ' (' . number_format((float)$tax_rate,2) . '%)'; } ?></div><div class="v"><?php print number_format((float)$tax_amount,2); ?></div></div>
                <div class="row"><div class="k">Total</div><div class="v" style="font-weight:900;"><?php print number_format($total,2); ?></div></div>
                <div class="row"><div class="k">Paid</div><div class="v"><span class="amt paid"><?php print number_format($paid,2); ?></span></div></div>
                <div class="row grand"><div class="k" style="font-weight:800;">Balance Due</div><div class="v" style="font-weight:900;"><span class="amt due"><?php print number_format($balance,2); ?></span></div></div>
              </div>
            </div>

            <?php if (strlen(trim($notes)) > 0) { ?>
              <div class="notes"><?php print htmlspecialchars((string)$notes); ?></div>
            <?php } ?>
          </div>

          <div class="footer">
            <div>
              <div class="small">Thank you for your business.</div>
              <div class="hint">For best print/PDF quality: disable “Headers and footers” and enable “Background graphics” in the print dialog.</div>
            </div>
            <div class="btns">
              <button class="btn" onclick="window.close();">Close</button>
              <button class="btn primary" onclick="window.print();">Print</button>
            </div>
          </div>
        </div>
      </div>

      <?php if ($autoprint) { ?>
      <script>window.addEventListener('load', function(){ setTimeout(function(){ window.print(); }, 300); });</script>
      <?php } ?>
    </body>
    </html>
    <?php
    if ($is_pdf) {
        $autoload = __DIR__ . '/../vendor/autoload.php';
        if (!file_exists($autoload)) {
            $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>PDF download is not enabled yet. Please install Dompdf (vendor/autoload.php not found).<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            header('Location: invoice-view.php?id=' . $invoice_id);
            exit;
        }

        require_once $autoload;
        if (!class_exists('Dompdf\\Dompdf')) {
            $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>PDF download is not enabled yet. Dompdf class not found.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            header('Location: invoice-view.php?id=' . $invoice_id);
            exit;
        }

        $html = ob_get_clean();
        $options = new Dompdf\Options();
        $options->set('isHtml5ParserEnabled', true);
        $options->set('isRemoteEnabled', true);
        $dompdf = new Dompdf\Dompdf($options);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->loadHtml($html);
        $dompdf->render();
        $filename = 'Invoice-' . preg_replace('/[^A-Za-z0-9_-]+/', '-', (string)$invoice['invoice_no']) . '.pdf';
        $dompdf->stream($filename, ['Attachment' => true]);
        exit;
    }

    exit;
}

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

 mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  description TEXT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  active TINYINT(1) NULL,
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

    $tax_rs = mysqli_query($con, "SELECT tax_rate, tax_exempt, status FROM finance_invoices WHERE id=$invoice_id LIMIT 1");
    $tax_row = $tax_rs ? mysqli_fetch_assoc($tax_rs) : null;
    $tax_rate = $tax_row && isset($tax_row['tax_rate']) ? (float)$tax_row['tax_rate'] : 0.0;
    $tax_exempt = $tax_row && !empty($tax_row['tax_exempt']) ? 1 : 0;
    if ($tax_rate < 0) { $tax_rate = 0.0; }
    if ($tax_rate > 100) { $tax_rate = 100.0; }
    $tax_amount = $tax_exempt ? 0.0 : (($subtotal * $tax_rate) / 100.0);

    $pay_rs = mysqli_query($con, "SELECT COALESCE(SUM(amount),0) AS s FROM finance_payments WHERE invoice_id=$invoice_id");
    $pay_row = $pay_rs ? mysqli_fetch_assoc($pay_rs) : null;
    $paid = $pay_row ? (float)$pay_row['s'] : 0.0;

    $cur_status = $tax_row ? (string)$tax_row['status'] : '';

    $total = $subtotal + $tax_amount;
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

    $tax_amount_sql = (string)((float)$tax_amount);

    mysqli_query(
        $con,
        "UPDATE finance_invoices SET subtotal=$subtotal_sql, total=$total_sql, amount_paid=$paid_sql, status='$new_status_s' WHERE id=$invoice_id LIMIT 1"
    );

    return [
        'subtotal' => $subtotal,
        'total' => $total,
        'paid' => $paid,
        'balance' => $balance,
        'tax_rate' => $tax_rate,
        'tax_exempt' => $tax_exempt,
        'tax_amount' => $tax_amount,
        'status' => $new_status,
    ];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_tax'])) {
    $tax_rate_in = (string)($_POST['tax_rate'] ?? '0');
    $tax_rate = (float)$tax_rate_in;
    $tax_exempt = isset($_POST['tax_exempt']) ? 1 : 0;
    if ($tax_rate < 0) { $tax_rate = 0.0; }
    if ($tax_rate > 100) { $tax_rate = 100.0; }
    $tax_rate_sql = (string)((float)$tax_rate);
    $tax_exempt_sql = $tax_exempt ? '1' : '0';
    mysqli_query($con, "UPDATE finance_invoices SET tax_rate=$tax_rate_sql, tax_exempt=$tax_exempt_sql WHERE id=$invoice_id LIMIT 1");
    finance_recalc_invoice($con, $invoice_id);
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Tax updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: invoice-view.php?id=' . $invoice_id);
    exit;
}

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
    $product_id = (int)($_POST['product_id'] ?? 0);
    $new_product_name = trim((string)($_POST['new_product_name'] ?? ''));
    $new_product_price = (float)($_POST['new_product_price'] ?? 0);
    $desc = trim((string)($_POST['description'] ?? ''));
    $qty = (float)($_POST['qty'] ?? 0);
    $unit = (float)($_POST['unit_price'] ?? 0);

    if ($product_id === 0 && strlen($new_product_name) > 0) {
        if ($new_product_price <= 0 && $unit > 0) {
            $new_product_price = $unit;
        }
        if ($new_product_price <= 0) {
            $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Please enter a unit price for the new product/service.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            header('Location: invoice-view.php?id=' . $invoice_id);
            exit;
        }

        $pname_s = mysqli_real_escape_string($con, $new_product_name);
        $pprice_sql = (string)((float)$new_product_price);
        mysqli_query($con, "INSERT INTO finance_products (name, description, unit_price, active, created_at) VALUES ('$pname_s', '', $pprice_sql, 1, NOW())");
        $product_id = (int)mysqli_insert_id($con);

        if (strlen(trim($desc)) < 1) {
            $desc = $new_product_name;
        }
        if ($unit <= 0) {
            $unit = $new_product_price;
        }
    }

    if ($product_id > 0) {
        $pr_rs = mysqli_query($con, "SELECT name, description, unit_price FROM finance_products WHERE id=$product_id AND (active IS NULL OR active=1) LIMIT 1");
        $pr = $pr_rs ? mysqli_fetch_assoc($pr_rs) : null;
        if ($pr) {
            if (strlen(trim($desc)) < 1) {
                $desc = (string)$pr['name'];
            }
            if ($unit <= 0) {
                $unit = (float)$pr['unit_price'];
            }
        }
    }

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

    $product_sql = $product_id > 0 ? (string)$product_id : 'NULL';

    mysqli_query(
        $con,
        "INSERT INTO finance_invoice_items (invoice_id, product_id, description, qty, unit_price, line_total, created_at)
         VALUES ($invoice_id, $product_sql, '$desc_s', $qty_sql, $unit_sql, $line_sql, NOW())"
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

$products = [];
$pr_rs = mysqli_query($con, "SELECT id, name, unit_price FROM finance_products WHERE (active IS NULL OR active=1) ORDER BY name ASC");
if ($pr_rs) {
    while ($r = mysqli_fetch_assoc($pr_rs)) { $products[] = $r; }
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
            <a href="invoice-view.php?id=<?php print (int)$invoice_id; ?>&print=1&autoprint=1" target="_blank" class="btn btn-soft-secondary btn-sm">Print</a>
            <a href="invoice-view.php?id=<?php print (int)$invoice_id; ?>&pdf=1" class="btn btn-soft-primary btn-sm">Download PDF</a>
            <button type="button" class="btn btn-soft-info btn-sm" id="btnInvoiceEmail" data-to="<?php print htmlspecialchars((string)$invoice['customer_email']); ?>" data-title="<?php print htmlspecialchars('Invoice ' . (string)$invoice['invoice_no']); ?>" data-url="<?php print htmlspecialchars((string)$public_link); ?>">Send Email</button>
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
                <div class="d-flex justify-content-between"><span class="text-muted">Tax<?php if (!empty($summary['tax_exempt'])) { print ' (Exempt)'; } elseif (isset($summary['tax_rate'])) { print ' (' . number_format((float)$summary['tax_rate'],2) . '%)'; } ?></span><span class="fw-semibold"><?php print number_format((float)($summary['tax_amount'] ?? 0),2); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Total</span><span class="fw-semibold"><?php print number_format((float)$summary['total'],2); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Paid</span><span class="fw-semibold"><?php print number_format((float)$summary['paid'],2); ?></span></div>
                <div class="d-flex justify-content-between"><span class="text-muted">Balance</span><span class="fw-semibold"><?php print number_format((float)$summary['balance'],2); ?></span></div>
              </div>

              <form method="post" class="mt-2 p-3 border rounded-3">
                <input type="hidden" name="update_tax" value="1">
                <div class="d-flex align-items-center justify-content-between mb-2">
                  <div class="fw-semibold">Tax Settings</div>
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="tax_exempt" id="tax_exempt" <?php if (!empty($summary['tax_exempt'])) { print 'checked'; } ?>>
                    <label class="form-check-label" for="tax_exempt">Exempt</label>
                  </div>
                </div>
                <div class="input-group input-group-sm">
                  <span class="input-group-text">Rate %</span>
                  <input type="number" step="0.01" class="form-control" name="tax_rate" value="<?php print htmlspecialchars((string)($summary['tax_rate'] ?? 0)); ?>">
                  <button class="btn btn-soft-primary" type="submit">Update</button>
                </div>
              </form>
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
                    <label class="form-label">Product / Service (optional)</label>
                    <select name="product_id" id="product_id" class="form-select">
                      <option value="0">Select...</option>
                      <option value="0" data-new="1">Add new...</option>
                      <?php foreach ($products as $p) {
                        $pid = (int)$p['id'];
                        $pnm = htmlspecialchars((string)$p['name']);
                        $pup = (float)$p['unit_price'];
                        $pup_s = htmlspecialchars((string)$pup);
                        print "<option value='$pid' data-price='$pup_s'>$pnm</option>";
                      } ?>
                    </select>
                  </div>

                  <div class="col-12" id="newProductWrap" style="display:none;">
                    <div class="row g-3">
                      <div class="col-12 col-md-6">
                        <label class="form-label">New Product/Service Name</label>
                        <input type="text" name="new_product_name" id="new_product_name" class="form-control" placeholder="e.g. Website Maintenance">
                      </div>
                      <div class="col-12 col-md-6">
                        <label class="form-label">New Unit Price</label>
                        <input type="number" step="0.01" name="new_product_price" id="new_product_price" class="form-control" placeholder="0.00">
                      </div>
                    </div>
                  </div>

                  <div class="col-12">
                    <label class="form-label">Description</label>
                    <input type="text" name="description" id="description" class="form-control" required>
                  </div>
                  <div class="col-12 col-md-4">
                    <label class="form-label">Qty</label>
                    <input type="number" step="0.01" name="qty" class="form-control" value="1" required>
                  </div>
                  <div class="col-12 col-md-4">
                    <label class="form-label">Unit Price</label>
                    <input type="number" step="0.01" name="unit_price" id="unit_price" class="form-control" value="0" required>
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

      <div class="modal fade" id="invoiceEmailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Send Invoice via Email</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div id="invEmailAlert"></div>
              <form id="invoiceEmailForm">
                <input type="hidden" name="send_doc_email" value="1">
                <input type="hidden" name="doc_title" id="inv_doc_title" value="">
                <input type="hidden" name="doc_url" id="inv_doc_url" value="">
                <div class="mb-3">
                  <label class="form-label">Recipient email(s)</label>
                  <input type="text" class="form-control" name="to_emails" id="inv_to_emails" placeholder="name@example.com, another@example.com">
                  <div class="text-muted small mt-1">Separate multiple emails with commas or spaces.</div>
                </div>
                <div class="mb-0">
                  <label class="form-label">Message (optional)</label>
                  <textarea class="form-control" name="message" id="inv_message" rows="3" placeholder="Write a short message..."></textarea>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-info" id="btnSendInvoiceEmail">Send</button>
            </div>
          </div>
        </div>
      </div>

      <script>
      (function(){
        var btn = document.getElementById('btnInvoiceEmail');
        var modalEl = document.getElementById('invoiceEmailModal');
        var sendBtn = document.getElementById('btnSendInvoiceEmail');
        var alertEl = document.getElementById('invEmailAlert');
        var toEl = document.getElementById('inv_to_emails');
        var titleEl = document.getElementById('inv_doc_title');
        var urlEl = document.getElementById('inv_doc_url');
        var msgEl = document.getElementById('inv_message');
        if (!btn || !modalEl || !sendBtn || !toEl || !titleEl || !urlEl) return;

        var invModal = new bootstrap.Modal(modalEl);

        btn.addEventListener('click', function(){
          if (alertEl) alertEl.innerHTML = '';
          var to = (btn.getAttribute('data-to') || '').trim();
          var t = (btn.getAttribute('data-title') || '').trim();
          var u = (btn.getAttribute('data-url') || '').trim();
          toEl.value = to;
          titleEl.value = t;
          urlEl.value = u;
          if (msgEl && !msgEl.value) {
            msgEl.value = 'Please find your invoice attached as a link.';
          }
          invModal.show();
          setTimeout(function(){ toEl.focus(); }, 250);
        });

        sendBtn.addEventListener('click', function(){
          if (alertEl) alertEl.innerHTML = '';
          var to = (toEl.value || '').trim();
          if (!to) {
            if (alertEl) {
              alertEl.innerHTML = "<div class='alert alert-danger'>Please enter at least one recipient email.</div>";
            }
            return;
          }
          var fd = new FormData(document.getElementById('invoiceEmailForm'));
          sendBtn.disabled = true;
          fetch('documents.php', { method: 'POST', body: fd, credentials: 'same-origin' })
            .then(function(r){ return r.json(); })
            .then(function(data){
              sendBtn.disabled = false;
              if (data && data.status === 'success') {
                if (alertEl) {
                  alertEl.innerHTML = "<div class='alert alert-success'>Email sent.</div>";
                }
              } else {
                if (alertEl) {
                  alertEl.innerHTML = "<div class='alert alert-danger'>" + ((data && data.message) ? data.message : 'Failed to send email') + "</div>";
                }
              }
            })
            .catch(function(){
              sendBtn.disabled = false;
              if (alertEl) {
                alertEl.innerHTML = "<div class='alert alert-danger'>Failed to send email.</div>";
              }
            });
        });
      })();
      </script>

      <script>
      (function(){
        var sel = document.getElementById('product_id');
        var desc = document.getElementById('description');
        var price = document.getElementById('unit_price');
        var wrap = document.getElementById('newProductWrap');
        var npn = document.getElementById('new_product_name');
        var npp = document.getElementById('new_product_price');
        if (!sel || !desc || !price) return;
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

<script>
(function(){
  var sel = document.getElementById('product_id');
  var desc = document.getElementById('description');
  var price = document.getElementById('unit_price');
  var wrap = document.getElementById('newProductWrap');
  var npn = document.getElementById('new_product_name');
  var npp = document.getElementById('new_product_price');
  if (!sel || !desc || !price) return;

  sel.addEventListener('change', function(){
    var opt = sel.options[sel.selectedIndex];
    if (!opt) return;
    var isNew = opt.getAttribute('data-new') === '1';
    if (wrap) {
      wrap.style.display = isNew ? '' : 'none';
      if (!isNew) {
        if (npn) npn.value = '';
        if (npp) npp.value = '';
      }
    }
    if (isNew) {
      return;
    }
    var p = opt.getAttribute('data-price');
    if (p && (price.value === '' || parseFloat(price.value || '0') <= 0)) {
      price.value = p;
    }
    if (opt.value && (!desc.value || desc.value.trim().length < 1)) {
      desc.value = opt.text;
    }
  });
})();
</script>

<?php include "footer.php"; ?>
