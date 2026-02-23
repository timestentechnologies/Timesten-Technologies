<?php
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS document_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  created_at DATETIME NULL
)");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NULL,
  title VARCHAR(255) NOT NULL,
  doc_type VARCHAR(20) NOT NULL,
  file_name VARCHAR(255) NULL,
  original_name VARCHAR(255) NULL,
  link_url TEXT NULL,
  uploaded_by VARCHAR(120) NULL,
  related_employee_id INT NULL,
  created_at DATETIME NULL
)");

$errormsg = '';
$successmsg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['name'])) {
    $name = trim((string)$_POST['name']);
    if (strlen($name) < 2) {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Category name is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        $name_s = mysqli_real_escape_string($con, $name);
        $exists_q = mysqli_query($con, "SELECT 1 FROM document_categories WHERE name='$name_s' LIMIT 1");
        if ($exists_q && mysqli_num_rows($exists_q) > 0) {
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Category already exists.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            mysqli_query($con, "INSERT INTO document_categories (name, created_at) VALUES ('$name_s', NOW())");
            $successmsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Category created.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_id'])) {
    $delete_id = (int)$_POST['delete_id'];
    if ($delete_id > 0) {
        $has_docs_q = mysqli_query($con, "SELECT 1 FROM documents WHERE category_id=$delete_id LIMIT 1");
        if ($has_docs_q && mysqli_num_rows($has_docs_q) > 0) {
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Cannot delete category that has documents. Move/delete documents first.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            mysqli_query($con, "DELETE FROM document_categories WHERE id=$delete_id LIMIT 1");
            $successmsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Category deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }
}

$cats = [];
$cat_q = mysqli_query($con, "SELECT c.id, c.name, COALESCE(d.cnt,0) AS cnt
  FROM document_categories c
  LEFT JOIN (SELECT category_id, COUNT(*) AS cnt FROM documents GROUP BY category_id) d
  ON d.category_id = c.id
  ORDER BY c.name ASC");
if ($cat_q) {
    while ($r = mysqli_fetch_assoc($cat_q)) {
        $cats[] = $r;
    }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Document Categories</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="documents.php">Documents</a></li>
                <li class="breadcrumb-item active">Categories</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php
      if (!empty($errormsg)) { print $errormsg; }
      if (!empty($successmsg)) { print $successmsg; }
      ?>

      <div class="row">
        <div class="col-12 col-lg-5">
          <div class="card">
            <div class="card-header"><h5 class="card-title mb-0">Add Category</h5></div>
            <div class="card-body">
              <form method="post">
                <div class="mb-3">
                  <label class="form-label" for="name">Category Name</label>
                  <input type="text" class="form-control" id="name" name="name" placeholder="e.g. HR, Finance, Legal" required>
                </div>
                <button type="submit" class="btn btn-primary">Save</button>
              </form>
            </div>
          </div>
        </div>

        <div class="col-12 col-lg-7">
          <div class="card">
            <div class="card-header"><h5 class="card-title mb-0">All Categories</h5></div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-striped table-sm align-middle mb-0">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th class="text-end">Documents</th>
                      <th class="text-end">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    if (count($cats) < 1) {
                        print "<tr><td colspan='3' class='text-center text-muted'>No categories yet.</td></tr>";
                    }
                    foreach ($cats as $c) {
                        $id = (int)$c['id'];
                        $nm = htmlspecialchars($c['name']);
                        $cnt = (int)$c['cnt'];
                        print "<tr><td>$nm</td><td class='text-end'>$cnt</td><td class='text-end'>";
                        print "<a class='btn btn-sm btn-soft-primary' href='documents.php?cat=$id'>Open</a> ";
                        print "<form method='post' class='d-inline' onsubmit=\"return confirm('Delete this category?');\">";
                        print "<input type='hidden' name='delete_id' value='$id'>";
                        print "<button type='submit' class='btn btn-sm btn-soft-danger'>Delete</button>";
                        print "</form>";
                        print "</td></tr>";
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
  </div>
  <?php include "footer.php"; ?>
</div>
