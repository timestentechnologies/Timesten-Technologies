<?php
ob_start();
include "z_db.php";
session_start();
if (!isset($_SESSION['username'])) {
    print "<script>window.location='login.php';</script>";
    exit;
}

$pay_id = (int)($_GET['id'] ?? 0);
$is_pdf = isset($_GET['pdf']) && (string)$_GET['pdf'] === '1';
$autoprint = isset($_GET['print']) && (string)$_GET['print'] === '1';

if ($pay_id < 1) {
    echo "Invalid payslip.";
    exit;
}

$p_rs = mysqli_query(
    $con,
    "SELECT p.*, e.full_name, e.email, e.phone, e.job_title, e.comp_type, e.comp_amount
     FROM employee_payments p
     LEFT JOIN employees e ON e.id=p.employee_id
     WHERE p.id=$pay_id
     LIMIT 1"
);
$p = $p_rs ? mysqli_fetch_assoc($p_rs) : null;
if (!$p) {
    echo "Payslip not found.";
    exit;
}

$employee_name = !empty($p['full_name']) ? (string)$p['full_name'] : ('Employee #' . (int)$p['employee_id']);
$employee_email = !empty($p['email']) ? (string)$p['email'] : '';
$employee_phone = !empty($p['phone']) ? (string)$p['phone'] : '';
$employee_job = !empty($p['job_title']) ? (string)$p['job_title'] : '';
$comp_type = !empty($p['comp_type']) ? (string)$p['comp_type'] : '';
$comp_amount = isset($p['comp_amount']) ? (string)$p['comp_amount'] : '';

$amount = (float)$p['amount'];
$deductions = isset($p['deductions']) ? (float)$p['deductions'] : 0.0;
$deduction_lines = [];
$deduction_lines_sum = 0.0;
$dl_rs = mysqli_query($con, "SELECT title, amount FROM employee_payment_deductions WHERE payment_id=$pay_id ORDER BY id ASC");
if ($dl_rs) {
    while ($r = mysqli_fetch_assoc($dl_rs)) {
        $t = !empty($r['title']) ? (string)$r['title'] : '';
        $a = isset($r['amount']) ? (float)$r['amount'] : 0.0;
        if (strlen(trim($t)) > 0 && $a > 0) {
            $deduction_lines[] = ['title' => $t, 'amount' => $a];
            $deduction_lines_sum += $a;
        }
    }
}
if ($deduction_lines_sum > 0) {
    $deductions = $deduction_lines_sum;
}
$net_amount = max(0.0, $amount - $deductions);
$pay_date = !empty($p['pay_date']) ? (string)$p['pay_date'] : '';
$payment_method = !empty($p['payment_method']) ? (string)$p['payment_method'] : '';
$reference = !empty($p['reference']) ? (string)$p['reference'] : '';
$notes = !empty($p['notes']) ? (string)$p['notes'] : '';
$created_at = !empty($p['created_at']) ? (string)$p['created_at'] : '';

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

$pay_no = 'PAY-' . str_pad((string)$pay_id, 6, '0', STR_PAD_LEFT);
$today = date('Y-m-d');

$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
$path = isset($_SERVER['SCRIPT_NAME']) ? rtrim(str_replace('payslip-view.php', '', $_SERVER['SCRIPT_NAME']), '/') : '';
$base = $scheme . '://' . $host . $path;
$doc_link = $base . '/payslip-view.php?id=' . $pay_id;

ob_start();
?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Payslip <?php print htmlspecialchars($pay_no); ?></title>
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
            <div class="label">Payslip</div>
            <div class="value"><?php print htmlspecialchars($pay_no); ?></div>
            <div class="label">Date: <?php print htmlspecialchars($today); ?></div>
          </div>
        </div>

        <div class="content">
          <div class="grid">
            <div class="col">
              <div class="card">
                <h4>Paid By</h4>
                <div style="font-weight:800;font-size:13px;"><?php print htmlspecialchars($company_name); ?></div>
                <?php if (strlen(trim($company_email))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_email); ?></div><?php } ?>
                <?php if (strlen(trim($company_phone))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_phone); ?></div><?php } ?>
                <?php if (strlen(trim($company_url))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($company_url); ?></div><?php } ?>
              </div>
            </div>

            <div class="col">
              <div class="card">
                <h4>Employee</h4>
                <div style="font-weight:800;font-size:13px;"><?php print htmlspecialchars($employee_name); ?></div>
                <?php if (strlen(trim($employee_job))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($employee_job); ?></div><?php } ?>
                <?php if (strlen(trim($employee_email))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($employee_email); ?></div><?php } ?>
                <?php if (strlen(trim($employee_phone))>0) { ?><div style="font-size:12px;color:var(--muted);"><?php print htmlspecialchars($employee_phone); ?></div><?php } ?>
              </div>
            </div>

            <div class="col">
              <div class="card">
                <h4>Payment Details</h4>
                <div class="row"><div class="k">Pay Date</div><div class="v"><?php print htmlspecialchars(strlen($pay_date) ? $pay_date : $today); ?></div></div>
                <div class="row"><div class="k">Method</div><div class="v"><?php print htmlspecialchars($payment_method); ?></div></div>
                <div class="row"><div class="k">Reference</div><div class="v"><?php print htmlspecialchars($reference); ?></div></div>
                <div class="row"><div class="k">Created</div><div class="v"><?php print htmlspecialchars($created_at); ?></div></div>
              </div>
            </div>
          </div>

          <div class="totals">
            <div class="box">
              <div class="row"><div class="k">Gross Pay</div><div class="v"><span class="pill success">KES <?php print number_format($amount,2); ?></span></div></div>
              <div class="row"><div class="k">Deductions</div><div class="v">KES <?php print number_format($deductions,2); ?></div></div>
              <?php if (count($deduction_lines) > 0) { ?>
                <?php foreach ($deduction_lines as $dl) { ?>
                  <div class="row"><div class="k" style="padding-left:14px;">- <?php print htmlspecialchars((string)$dl['title']); ?></div><div class="v">KES <?php print number_format((float)$dl['amount'],2); ?></div></div>
                <?php } ?>
              <?php } ?>
              <div class="row"><div class="k">Compensation</div><div class="v"><?php
                $c = trim((string)$comp_type);
                $a = trim((string)$comp_amount);
                $t = '';
                if (strlen($c)) {
                    $t = ucfirst($c);
                    if (strlen($a)) { $t .= ' - ' . $a; }
                } elseif (strlen($a)) {
                    $t = $a;
                }
                print htmlspecialchars($t);
              ?></div></div>
              <div class="row grand"><div class="k" style="font-weight:800;">Net Pay</div><div class="v" style="font-weight:900;">KES <?php print number_format($net_amount,2); ?></div></div>
            </div>
          </div>

          <?php if (strlen(trim($notes)) > 0) { ?>
            <div class="notes"><?php print htmlspecialchars($notes); ?></div>
          <?php } ?>
        </div>

        <div class="footer">
          <div>
            <div class="small">This document confirms the payment made to the employee.</div>
            <div class="hint">For best print/PDF quality: disable “Headers and footers” and enable “Background graphics” in the print dialog.</div>
          </div>
          <div class="btns">
            <button class="btn" onclick="window.close();">Close</button>
            <?php if (!$is_pdf) { ?>
              <a class="btn" href="payslip-view.php?id=<?php print $pay_id; ?>&pdf=1" target="_blank" style="text-decoration:none;display:inline-block;">Download PDF</a>
              <button class="btn" type="button" id="btnSendEmail" data-to="<?php print htmlspecialchars($employee_email); ?>">Send Email</button>
            <?php } ?>
            <button class="btn primary" onclick="window.print();">Print</button>
          </div>
        </div>
      </div>
    </div>

    <?php if ($autoprint) { ?>
      <script>window.addEventListener('load', function(){ setTimeout(function(){ window.print(); }, 300); });</script>
    <?php } ?>

    <?php if (!$is_pdf) { ?>
    <script>
    (function(){
      var btn = document.getElementById('btnSendEmail');
      if (!btn) return;
      btn.addEventListener('click', function(){
        var to = (btn.getAttribute('data-to') || '').trim();
        if (!to) {
          to = prompt('Send to email:', '');
        } else {
          to = prompt('Send to email:', to);
        }
        if (!to) return;
        var msg = prompt('Message (optional):', 'Please find your payslip attached as a link.');
        var fd = new FormData();
        fd.append('send_doc_email', '1');
        fd.append('to_emails', to);
        fd.append('doc_title', <?php print json_encode('Payslip ' . $pay_no); ?>);
        fd.append('doc_url', <?php print json_encode($doc_link); ?>);
        if (msg) fd.append('message', msg);

        btn.disabled = true;
        fetch('documents.php', { method: 'POST', body: fd, credentials: 'same-origin' })
          .then(function(r){ return r.json(); })
          .then(function(data){
            btn.disabled = false;
            if (data && data.status === 'success') {
              alert('Email sent.');
            } else {
              alert((data && data.message) ? data.message : 'Failed to send email');
            }
          })
          .catch(function(){
            btn.disabled = false;
            alert('Failed to send email');
          });
      });
    })();
    </script>
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
    $dompdf->stream('payslip_' . $pay_no . '.pdf', ['Attachment' => true]);
    exit;
}

echo $html;
