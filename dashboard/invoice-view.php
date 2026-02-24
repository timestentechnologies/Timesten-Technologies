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

    $total = $subtotal;
    $balance = $total - $paid;

    $company_name = 'TimesTen Technologies';
    $company_url = '';
    $company_phone = '';
    $company_email = '';

    $sc_rs = mysqli_query($con, "SELECT site_title, site_url FROM siteconfig WHERE id=1 LIMIT 1");
    $sc = $sc_rs ? mysqli_fetch_assoc($sc_rs) : null;
    if ($sc) {
        if (!empty($sc['site_title'])) { $company_name = (string)$sc['site_title']; }
        if (!empty($sc['site_url'])) { $company_url = (string)$sc['site_url']; }
    }

    $ct_rs = mysqli_query($con, "SELECT phone1, email1 FROM sitecontact WHERE id=1 LIMIT 1");
    $ct = $ct_rs ? mysqli_fetch_assoc($ct_rs) : null;
    if ($ct) {
        $company_phone = !empty($ct['phone1']) ? (string)$ct['phone1'] : '';
        $company_email = !empty($ct['email1']) ? (string)$ct['email1'] : '';
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
          --primary:#0d6efd;
          --text:#0f172a;
          --muted:#64748b;
          --border:#e5e7eb;
          --bg:#ffffff;
        }
        *{box-sizing:border-box;}
        body{margin:0;background:#f6f7fb;font-family:Arial, Helvetica, sans-serif;color:var(--text);}
        .page{max-width:900px;margin:24px auto;padding:0 12px;}
        .sheet{background:var(--bg);border:1px solid var(--border);border-radius:14px;overflow:hidden;box-shadow:0 8px 30px rgba(15,23,42,.08);position:relative;}
        .sheet:before{content:"";position:absolute;top:-140px;right:-140px;width:320px;height:320px;background:radial-gradient(circle at 30% 30%, rgba(13,110,253,.22), rgba(13,110,253,0));border-radius:999px;pointer-events:none;}
        .sheet:after{content:"";position:absolute;bottom:-160px;left:-160px;width:360px;height:360px;background:radial-gradient(circle at 30% 30%, rgba(99,102,241,.16), rgba(99,102,241,0));border-radius:999px;pointer-events:none;}
        .topbar{padding:18px 22px;border-bottom:1px solid var(--border);display:flex;gap:14px;align-items:center;}
        .brand{display:flex;gap:12px;align-items:center;}
        .brand img{height:34px;max-width:220px;object-fit:contain;}
        .brand-title{font-weight:800;letter-spacing:.2px;}
        .tag{margin-left:auto;text-align:right;}
        .tag .label{font-size:12px;color:var(--muted);}
        .tag .value{font-size:18px;font-weight:800;color:var(--primary);}

        .content{padding:18px 22px;position:relative;z-index:1;}
        .grid{display:flex;gap:16px;flex-wrap:wrap;}
        .col{flex:1;min-width:260px;}
        .card{border:1px solid var(--border);border-radius:12px;padding:14px;}
        .card h4{margin:0 0 8px 0;font-size:13px;letter-spacing:.3px;text-transform:uppercase;color:var(--muted);}
        .row{display:flex;justify-content:space-between;gap:12px;margin:4px 0;}
        .row .k{color:var(--muted);font-size:12px;}
        .row .v{font-weight:700;font-size:12px;text-align:right;}

        table{width:100%;border-collapse:collapse;margin-top:14px;}
        thead th{font-size:12px;text-transform:uppercase;letter-spacing:.35px;color:var(--muted);text-align:left;border-bottom:1px solid var(--border);padding:10px 8px;}
        tbody td{padding:10px 8px;border-bottom:1px solid #f1f5f9;font-size:13px;vertical-align:top;}
        td.num, th.num{text-align:right;}
        .totals{display:flex;justify-content:flex-end;margin-top:14px;}
        .totals .box{width:340px;border:1px solid var(--border);border-radius:12px;padding:12px;}
        .totals .box .row .v{font-size:13px;}
        .totals .box .grand{padding-top:8px;margin-top:8px;border-top:1px dashed var(--border);}
        .totals .box .grand .v{font-size:16px;color:var(--primary);}

        .notes{margin-top:14px;border-left:4px solid var(--primary);background:#f8fafc;padding:10px 12px;border-radius:10px;white-space:pre-line;}
        .footer{padding:14px 22px;border-top:1px solid var(--border);display:flex;gap:10px;justify-content:space-between;align-items:center;flex-wrap:wrap;position:relative;z-index:1;}
        .footer .small{font-size:12px;color:var(--muted);}
        .btns{display:flex;gap:8px;}
        .btn{border:1px solid var(--border);background:#fff;padding:8px 10px;border-radius:10px;font-size:12px;cursor:pointer;}
        .btn.primary{border-color:var(--primary);color:var(--primary);}

        @page{size:A4;margin:12mm;}
        @media print{
          body{background:#fff;}
          .page{max-width:none;margin:0;padding:0;}
          .sheet{border:none;border-radius:0;box-shadow:none;}
          .btns{display:none !important;}
        }
      </style>
    </head>
    <body>
      <div class="page">
        <div class="sheet">
          <div class="topbar">
            <div class="brand">
              <img src="<?php print htmlspecialchars($logo_path); ?>" alt="Logo">
              <div>
                <div class="brand-title"><?php print htmlspecialchars($company_name); ?></div>
                <div class="small" style="color:var(--muted);font-size:12px;">
                  <?php if (strlen(trim($company_phone))>0) { print htmlspecialchars($company_phone) . " "; } ?>
                  <?php if (strlen(trim($company_email))>0) { print htmlspecialchars($company_email) . " "; } ?>
                  <?php if (strlen(trim($company_url))>0) { print htmlspecialchars($company_url); } ?>
                </div>
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
                  <div class="row"><div class="k">Paid</div><div class="v"><?php print number_format($paid,2); ?></div></div>
                  <div class="row"><div class="k">Balance</div><div class="v"><?php print number_format($balance,2); ?></div></div>
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
                <div class="row"><div class="k">Paid</div><div class="v"><?php print number_format($paid,2); ?></div></div>
                <div class="row grand"><div class="k" style="font-weight:800;">Balance Due</div><div class="v" style="font-weight:900;"><?php print number_format($balance,2); ?></div></div>
              </div>
            </div>

            <?php if (strlen(trim($notes)) > 0) { ?>
              <div class="notes"><?php print htmlspecialchars((string)$notes); ?></div>
            <?php } ?>
          </div>

          <div class="footer">
            <div class="small">Thank you for your business.</div>
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
        $dompdf = new Dompdf\Dompdf();
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
