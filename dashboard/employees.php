<?php
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(160) NOT NULL,
  email VARCHAR(160) NULL,
  phone VARCHAR(80) NULL,
  job_title VARCHAR(255) NULL,
  hired_from_application_id INT NULL,
  cv_document_id INT NULL,
  created_at DATETIME NULL
)");

$employees = [];
$q = mysqli_query($con, "SELECT * FROM employees ORDER BY id DESC");
if ($q) {
    while ($r = mysqli_fetch_assoc($q)) {
        $employees[] = $r;
    }
}
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Employees</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                <li class="breadcrumb-item active">Employees</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-header"><h5 class="card-title mb-0">All Employees</h5></div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped table-sm align-middle mb-0">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Job</th>
                  <th>Hired</th>
                </tr>
              </thead>
              <tbody>
                <?php
                if (count($employees) < 1) {
                    print "<tr><td colspan='5' class='text-center text-muted'>No employees yet.</td></tr>";
                }
                foreach ($employees as $e) {
                    $nm = htmlspecialchars($e['full_name']);
                    $em = htmlspecialchars((string)$e['email']);
                    $ph = htmlspecialchars((string)$e['phone']);
                    $jt = htmlspecialchars((string)$e['job_title']);
                    $dt = htmlspecialchars((string)$e['created_at']);
                    print "<tr><td>$nm</td><td>$em</td><td>$ph</td><td>$jt</td><td>$dt</td></tr>";
                }
                ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

    </div>
  </div>
  <?php include "footer.php"; ?>
</div>
