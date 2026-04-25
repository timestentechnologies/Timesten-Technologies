<?php
ob_start();
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS finance_products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(190) NOT NULL,
  description TEXT NULL,
  qty DECIMAL(12,2) NOT NULL DEFAULT 0,
  unit_price DECIMAL(12,2) NOT NULL DEFAULT 0,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NULL,
  updated_at DATETIME NULL
 )");

$col_rs0 = mysqli_query($con, "SHOW COLUMNS FROM finance_products LIKE 'description'");
if (!$col_rs0 || mysqli_num_rows($col_rs0) < 1) {
    @mysqli_query($con, "ALTER TABLE finance_products ADD COLUMN description TEXT NULL AFTER name");
}

$col_rs_qty = mysqli_query($con, "SHOW COLUMNS FROM finance_products LIKE 'qty'");
if (!$col_rs_qty || mysqli_num_rows($col_rs_qty) < 1) {
    @mysqli_query($con, "ALTER TABLE finance_products ADD COLUMN qty DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER description");
}

$col_rs = mysqli_query($con, "SHOW COLUMNS FROM finance_products LIKE 'active'");
if (!$col_rs || mysqli_num_rows($col_rs) < 1) {
    @mysqli_query($con, "ALTER TABLE finance_products ADD COLUMN active TINYINT(1) NOT NULL DEFAULT 1 AFTER unit_price");
}

$col_rs2 = mysqli_query($con, "SHOW COLUMNS FROM finance_products LIKE 'updated_at'");
if (!$col_rs2 || mysqli_num_rows($col_rs2) < 1) {
    @mysqli_query($con, "ALTER TABLE finance_products ADD COLUMN updated_at DATETIME NULL AFTER created_at");
}

mysqli_query(
    $con,
    "UPDATE finance_products p
     JOIN (
        SELECT product_id, MAX(description) AS d
        FROM finance_invoice_items
        WHERE product_id IS NOT NULL AND product_id > 0
          AND description IS NOT NULL AND TRIM(description) <> ''
        GROUP BY product_id
     ) x ON x.product_id = p.id
     SET p.description = x.d
     WHERE (p.description IS NULL OR TRIM(p.description) = '')
       AND (x.d IS NOT NULL AND TRIM(x.d) <> '')
       AND TRIM(x.d) <> TRIM(p.name)"
);

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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_product'])) {
    $name = trim((string)($_POST['name'] ?? ''));
    $description = trim((string)($_POST['description'] ?? ''));
    $qty = (float)($_POST['qty'] ?? 0);
    $unit_price = (float)($_POST['unit_price'] ?? 0);

    if (strlen($name) < 2) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Product/Service name is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: products.php');
        exit;
    }

    if ($unit_price < 0) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Unit price must be 0 or greater.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: products.php');
        exit;
    }

    if ($qty < 0) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Quantity must be 0 or greater.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: products.php');
        exit;
    }

    $name_s = mysqli_real_escape_string($con, $name);
    $desc_s = mysqli_real_escape_string($con, $description);
    $qty_sql = (string)((float)$qty);
    $price_sql = (string)((float)$unit_price);

    mysqli_query($con, "INSERT INTO finance_products (name, description, qty, unit_price, active, created_at, updated_at) VALUES ('$name_s', '$desc_s', $qty_sql, $price_sql, 1, NOW(), NOW())");
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Product/Service added.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: products.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_product'])) {
    $id = (int)($_POST['id'] ?? 0);
    $name = trim((string)($_POST['name'] ?? ''));
    $description = trim((string)($_POST['description'] ?? ''));
    $qty = (float)($_POST['qty'] ?? 0);
    $unit_price = (float)($_POST['unit_price'] ?? 0);
    $active = (int)($_POST['active'] ?? 1);
    $active = $active ? 1 : 0;

    if ($id < 1 || strlen($name) < 2 || $unit_price < 0 || $qty < 0) {
        $_SESSION['finance_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Invalid product/service data.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        header('Location: products.php');
        exit;
    }

    $name_s = mysqli_real_escape_string($con, $name);
    $desc_s = mysqli_real_escape_string($con, $description);
    $qty_sql = (string)((float)$qty);
    $price_sql = (string)((float)$unit_price);

    mysqli_query($con, "UPDATE finance_products SET name='$name_s', description='$desc_s', qty=$qty_sql, unit_price=$price_sql, active=$active, updated_at=NOW() WHERE id=$id LIMIT 1");
    $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Product/Service updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    header('Location: products.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['toggle_product'])) {
    $id = (int)($_POST['id'] ?? 0);
    $to = (int)($_POST['to'] ?? 0);
    $to = $to ? 1 : 0;

    if ($id > 0) {
        mysqli_query($con, "UPDATE finance_products SET active=$to, updated_at=NOW() WHERE id=$id LIMIT 1");
        $_SESSION['finance_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Product/Service updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }

    header('Location: products.php');
    exit;
}

$products = [];
$rs = mysqli_query($con, "SELECT * FROM finance_products ORDER BY active DESC, name ASC, id DESC");
if ($rs) {
    while ($r = mysqli_fetch_assoc($rs)) {
        $products[] = $r;
    }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Products / Services</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">Finance</a></li>
                <li class="breadcrumb-item active">Products</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php if (strlen($successmsg)) { print $successmsg; } ?>
      <?php if (strlen($errormsg)) { print $errormsg; } ?>

      <div class="card">
        <div class="card-header d-flex align-items-center">
          <h5 class="card-title mb-0">Products / Services</h5>
          <button type="button" class="btn btn-primary btn-sm ms-auto" data-bs-toggle="modal" data-bs-target="#addProductModal">Add Product</button>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped align-middle mb-0">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Description</th>
                  <th class="text-end">Qty</th>
                  <th class="text-end">Unit Price</th>
                  <th>Status</th>
                  <th>Created</th>
                  <th class="text-end">Actions</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($products) < 1) {
                    print "<tr><td colspan='7' class='text-center text-muted'>No products/services yet.</td></tr>";
                }
                foreach ($products as $p) {
                    $id = (int)$p['id'];
                    $nm = htmlspecialchars((string)$p['name']);
                    $ds = htmlspecialchars((string)($p['description'] ?? ''));
                    $qt = (float)($p['qty'] ?? 0);
                    $up = (float)$p['unit_price'];
                    $ac = (int)($p['active'] ?? 1);
                    $dt = htmlspecialchars((string)$p['created_at']);

                    $status = $ac ? "<span class='badge bg-success-subtle text-success'>Active</span>" : "<span class='badge bg-secondary-subtle text-secondary'>Inactive</span>";

                    print "<tr>";
                    print "<td>$nm</td>";
                    print "<td>$ds</td>";
                    print "<td class='text-end'>" . number_format($qt, 2) . "</td>";
                    print "<td class='text-end'>" . number_format($up, 2) . "</td>";
                    print "<td>$status</td>";
                    print "<td>$dt</td>";
                    print "<td class='text-end'>";
                    print "<button type='button' class='btn btn-sm btn-soft-secondary js-prod-edit' data-id='$id' data-name='$nm' data-description='$ds' data-qty='" . htmlspecialchars((string)$qt) . "' data-price='" . htmlspecialchars((string)$up) . "' data-active='$ac'>Edit</button> ";
                    if ($ac) {
                        print "<form method='post' class='d-inline'>";
                        print "<input type='hidden' name='toggle_product' value='1'>";
                        print "<input type='hidden' name='id' value='$id'>";
                        print "<input type='hidden' name='to' value='0'>";
                        print "<button type='submit' class='btn btn-sm btn-soft-danger'>Deactivate</button>";
                        print "</form>";
                    } else {
                        print "<form method='post' class='d-inline'>";
                        print "<input type='hidden' name='toggle_product' value='1'>";
                        print "<input type='hidden' name='id' value='$id'>";
                        print "<input type='hidden' name='to' value='1'>";
                        print "<button type='submit' class='btn btn-sm btn-soft-success'>Activate</button>";
                        print "</form>";
                    }
                    print "</td>";
                    print "</tr>";
                }
                ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Add Product / Service</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="addProductForm">
                <input type="hidden" name="add_product" value="1">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" name="name" required>
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Qty</label>
                    <input type="number" step="0.01" class="form-control" name="qty" value="0" required>
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Unit Price</label>
                    <input type="number" step="0.01" class="form-control" name="unit_price" value="0" required>
                  </div>
                  <div class="col-12">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" rows="2"></textarea>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="addProductForm" class="btn btn-primary">Save</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Product / Service</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form method="post" id="editProductForm">
                <input type="hidden" name="update_product" value="1">
                <input type="hidden" name="id" id="e_id" value="">
                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" id="e_name" name="name" required>
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Qty</label>
                    <input type="number" step="0.01" class="form-control" id="e_qty" name="qty" required>
                  </div>
                  <div class="col-12 col-md-3">
                    <label class="form-label">Unit Price</label>
                    <input type="number" step="0.01" class="form-control" id="e_price" name="unit_price" required>
                  </div>
                  <div class="col-12">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" id="e_description" name="description" rows="2"></textarea>
                  </div>
                  <div class="col-12">
                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" value="1" id="e_active" name="active">
                      <label class="form-check-label" for="e_active">Active</label>
                    </div>
                  </div>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" form="editProductForm" class="btn btn-primary">Update</button>
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
    var editEl = document.getElementById('editProductModal');
    var editModal = editEl ? new bootstrap.Modal(editEl) : null;

    document.addEventListener('click', function(e){
      var btn = e.target && e.target.closest ? e.target.closest('.js-prod-edit') : null;
      if (!btn || !editModal) return;

      document.getElementById('e_id').value = btn.getAttribute('data-id') || '';
      document.getElementById('e_name').value = btn.getAttribute('data-name') || '';
      document.getElementById('e_qty').value = btn.getAttribute('data-qty') || '0';
      document.getElementById('e_price').value = btn.getAttribute('data-price') || '0';
      document.getElementById('e_description').value = btn.getAttribute('data-description') || '';
      document.getElementById('e_active').checked = (btn.getAttribute('data-active') || '0') === '1';

      editModal.show();
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
