<?php
ob_start();
include "header.php";

$expense_id = (int)($_GET['id'] ?? 0);
$is_pdf = isset($_GET['pdf']) && (string)$_GET['pdf'] === '1';
$autoprint = isset($_GET['print']) && (string)$_GET['print'] === '1';

if ($expense_id < 1) {
    echo "Invalid receipt.";
    exit;
}

$x_rs = mysqli_query(
    $con,
    "SELECT e.*, c.name AS category_name, emp.full_name AS employee_name
     FROM finance_expenses e
     LEFT JOIN finance_expense_categories c ON c.id=e.category_id
     LEFT JOIN employees emp ON emp.id=e.employee_id
     WHERE e.id=$expense_id
     LIMIT 1"
);
$x = $x_rs ? mysqli_fetch_assoc($x_rs) : null;
if (!$x) {
    echo "Receipt not found.";
    exit;
}

$payment_id = !empty($x['payment_id']) ? (int)$x['payment_id'] : 0;

$category = !empty($x['category_name']) ? (string)$x['category_name'] : '';
$vendor = !empty($x['vendor']) ? (string)$x['vendor'] : '';
$description = !empty($x['description']) ? (string)$x['description'] : '';
$amount = (float)$x['amount'];
$expense_date = !empty($x['expense_date']) ? (string)$x['expense_date'] : '';
$employee = !empty($x['employee_name']) ? (string)$x['employee_name'] : '';
$payment_method = !empty($x['payment_method']) ? (string)$x['payment_method'] : '';
$reference = !empty($x['reference']) ? (string)$x['reference'] : '';
$receipt_file = !empty($x['receipt_file']) ? (string)$x['receipt_file'] : '';
$created_at = !empty($x['created_at']) ? (string)$x['created_at'] : '';

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

$logo_src = $logo_path;
$abs_logo_path = realpath(__DIR__ . '/' . $logo_path);
if ($is_pdf && $abs_logo_path && file_exists($abs_logo_path)) {
    $ext = strtolower(pathinfo($abs_logo_path, PATHINFO_EXTENSION));
    $mime = 'image/png';
    if ($ext === 'jpg' || $ext === 'jpeg') { $mime = 'image/jpeg'; }
    elseif ($ext === 'webp') { $mime = 'image/webp'; }
    $data = @file_get_contents($abs_logo_path);
    if ($data !== false) {
        $logo_src = 'data:' . $mime . ';base64,' . base64_encode($data);
    } else {
        $logo_src = 'file:///' . str_replace('\\', '/', $abs_logo_path);
    }
}

$rcpt_no = 'EXP-' . str_pad((string)$expense_id, 6, '0', STR_PAD_LEFT);
$today = date('Y-m-d');

ob_start();
?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Expense Receipt <?php print htmlspecialchars($rcpt_no); ?></title>
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

      .page{width:210mm;margin:0 auto;padding:0;}
      .sheet{background:var(--bg);border:1px solid var(--border);border-radius:16px;overflow:hidden;box-shadow:0 10px 34px rgba(15,23,42,.10);position:relative;}

      .decor{position:absolute;border-radius:999px;pointer-events:none;z-index:0;}
      .decor.tr{width:160mm;height:160mm;top:-110mm;right:-110mm;background:var(--primary);opacity:.12;}
      .decor.bl{width:160mm;height:160mm;bottom:-85mm;left:-85mm;background:var(--accent);opacity:.10;}

      .watermark{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);z-index:1;pointer-events:none;width:160mm;max-width:90%;text-align:center;}
      .watermark img{width:100%;height:auto;opacity:.18;}

      .topbar{padding:14px 22px;border-bottom:1px solid rgba(226,232,240,.9);display:flex;gap:14px;align-items:center;background:transparent;position:relative;z-index:2;}
      .brand{display:flex;gap:12px;align-items:center;}
      .brand img{height:58px;max-width:320px;object-fit:contain;}
      .brand-title{font-weight:800;letter-spacing:.2px;}
      .tag{margin-left:auto;text-align:right;}
      .tag .label{font-size:12px;color:var(--muted);}
      .tag .value{font-size:18px;font-weight:900;color:var(--accent_dark);}

      .content{padding:18px 22px;position:relative;z-index:2;}
      .grid{display:flex;flex-wrap:wrap;margin:-8px;}
      .col{flex:1;min-width:260px;padding:8px;}
      .card{border:1px solid rgba(226,232,240,.9);border-radius:12px;padding:14px;background:rgba(255,255,255,.82);box-shadow:0 8px 22px rgba(15,23,42,.05);}
      .card h4{margin:0 0 8px 0;font-size:13px;letter-spacing:.3px;text-transform:uppercase;color:var(--muted);}
      .row{display:flex;justify-content:space-between;gap:12px;margin:6px 0;}
      .row .k{color:var(--muted);font-size:12px;}
      .row .v{font-weight:800;font-size:12px;text-align:right;}

      .pill{display:inline-block;padding:4px 8px;border-radius:999px;border:1px solid var(--border);font-size:12px;}
      .pill.success{border-color:rgba(22,163,74,.3);background:rgba(22,163,74,.08);color:var(--success);font-weight:900;}

      .totals{width:100%;margin-top:14px;}
      .totals .box{width:340px;border:1px solid var(--border);border-radius:12px;padding:12px;margin-left:auto;}
      .totals .box .grand{padding-top:8px;margin-top:8px;border-top:1px dashed var(--border);}
      .totals .box .grand .v{font-size:16px;color:var(--accent);}

      .notes{margin-top:14px;border-left:4px solid var(--primary);background:#f8fafc;padding:10px 12px;border-radius:10px;white-space:pre-line;}

      .footer{padding:12px 22px;border-top:1px solid var(--border);display:flex;gap:10px;justify-content:space-between;align-items:center;flex-wrap:wrap;position:relative;z-index:2;}
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

      @page{size:A4;margin:0;}
      @media print{
        body{background:#fff;}
        .page{width:auto;min-height:auto;margin:0;padding:0;}
        .sheet{border:none;border-radius:0;box-shadow:none;}
        .btns{display:none !important;}
        .hint{display:none !important;}
        *{-webkit-print-color-adjust:exact;print-color-adjust:exact;}
      }
      @media screen{ .page{margin:10mm auto;} }
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
            <div class="label">Expense Receipt</div>
            <div class="value"><?php print htmlspecialchars($rcpt_no); ?></div>
            <div class="label">Date: <?php print htmlspecialchars($today); ?></div>
          </div>
        </div>

        <div class="content">
          <div class="grid">
            <div class="col">
              <div class="card">
                <h4>Issued By</h4>
                <div style="font-weight:800;font-size:13px;"><?php print htmlspecialchars($company_name); ?></div>
                <?php if (strlen(trim($company_email))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_email); ?></div><?php } ?>
                <?php if (strlen(trim($company_phone))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_phone); ?></div><?php } ?>
                <?php if (strlen(trim($company_url))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_url); ?></div><?php } ?>
              </div>
            </div>

            <div class="col">
              <div class="card">
                <h4>Vendor / Payee</h4>
                <div style="font-weight:800;font-size:13px;"><?php print htmlspecialchars($vendor); ?></div>
                <?php if (strlen(trim($employee))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars('Employee: ' . $employee); ?></div><?php } ?>
                <?php if (strlen(trim($category))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars('Category: ' . $category); ?></div><?php } ?>
              </div>
            </div>

            <div class="col">
              <div class="card">
                <h4>Details</h4>
                <div class="row"><div class="k">Expense Date</div><div class="v"><?php print htmlspecialchars(strlen($expense_date) ? $expense_date : $today); ?></div></div>
                <div class="row"><div class="k">Method</div><div class="v"><?php print htmlspecialchars($payment_method); ?></div></div>
                <div class="row"><div class="k">Reference</div><div class="v"><?php print htmlspecialchars($reference); ?></div></div>
                <div class="row"><div class="k">Recorded</div><div class="v"><?php print htmlspecialchars($created_at); ?></div></div>
              </div>
            </div>
          </div>

          <div class="totals">
            <div class="box">
              <div class="row"><div class="k">Amount</div><div class="v"><span class="pill success">KES <?php print number_format($amount,2); ?></span></div></div>
              <div class="row grand"><div class="k" style="font-weight:800;">Total</div><div class="v" style="font-weight:900;">KES <?php print number_format($amount,2); ?></div></div>
            </div>
          </div>

          <?php if (strlen(trim($description)) > 0) { ?>
            <div class="notes"><?php print htmlspecialchars($description); ?></div>
          <?php } ?>

          <?php if (strlen(trim($receipt_file)) > 0 && !$is_pdf) { ?>
            <div style="margin-top:12px;">
              <a href="uploads/expenses/<?php print htmlspecialchars($receipt_file); ?>" target="_blank" style="font-size:12px;text-decoration:underline;color:var(--accent_dark);">Open attached receipt file</a>
            </div>
          <?php } ?>

          <?php if ($payment_id > 0 && !$is_pdf) { ?>
            <div style="margin-top:10px;">
              <a href="payslip-view.php?id=<?php print (int)$payment_id; ?>" target="_blank" style="font-size:12px;text-decoration:underline;color:var(--accent_dark);">Open related payslip</a>
            </div>
          <?php } ?>
        </div>

        <div class="footer">
          <div>
            <div class="small">This document confirms the expense recorded.</div>
            <div class="hint">For best print/PDF quality: disable “Headers and footers” and enable “Background graphics” in the print dialog.</div>
          </div>
          <div class="btns">
            <button class="btn" onclick="window.close();">Close</button>
            <?php if (!$is_pdf) { ?>
              <a class="btn" href="expense-receipt-view.php?id=<?php print $expense_id; ?>&pdf=1" target="_blank" style="text-decoration:none;display:inline-block;">Download PDF</a>
            <?php } ?>
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
$html = ob_get_clean();

if ($is_pdf) {
    $autoload = __DIR__ . '/../vendor/autoload.php';
    if (!file_exists($autoload)) {
        echo $html;
        exit;
    }

    require_once $autoload;
    if (!class_exists('Dompdf\\Dompdf')) {
        echo $html;
        exit;
    }

    $options = new Dompdf\Options();
    $options->set('isRemoteEnabled', true);
    $options->set('isHtml5ParserEnabled', true);

    $dompdf = new Dompdf\Dompdf($options);
    $dompdf->loadHtml($html, 'UTF-8');
    $dompdf->setPaper('A4', 'portrait');
    $dompdf->render();
    $dompdf->stream('expense_receipt_' . $rcpt_no . '.pdf', ['Attachment' => true]);
    exit;
}

echo $html;
