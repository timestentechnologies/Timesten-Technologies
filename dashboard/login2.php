<?php
include_once("z_db.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['username'])) {
    $status = "OK"; //initial status
    $msg = "";
    $username = mysqli_real_escape_string($con, $_POST['username']); //fetching details through post method
    $password = mysqli_real_escape_string($con, $_POST['password']);

    if ($status == "OK") {
        // Retrieve user record from database
        $query = "SELECT password FROM admin WHERE username = ?";
        
        if ($stmt = mysqli_prepare($con, $query)) {
            mysqli_stmt_bind_param($stmt, 's', $username);
            mysqli_stmt_execute($stmt);
            mysqli_stmt_store_result($stmt);
            
            // Bind result variables
            mysqli_stmt_bind_result($stmt, $stored_hash);
            mysqli_stmt_fetch($stmt);
            
            // Close statement
            mysqli_stmt_close($stmt);
            
            // Check if password is correct
            if ($stored_hash && password_verify($password, $stored_hash)) {
                session_start();
                $_SESSION['username'] = $username;
                header("Location: index.php");
                exit;
            } else {
                $errormsg = "
                <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                    Username And/Or Password Does Not Match.
                    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                </div>";
            }
        } else {
            $errormsg = "
            <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                Database query failed. Please try again later.
                <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
            </div>";
        }
    } else {
        $errormsg = "
        <div class='alert alert-danger alert-dismissible alert-outline fade show'>
            ".$msg."
            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
        </div>";
    }
}

// Determine favicon from logo settings
$favicon_path = 'assets/images/favicon.ico';
$logo_rs = mysqli_query($con, "SELECT xfile FROM logo WHERE id=1 LIMIT 1");
if ($logo_rs) {
    $logo_row = mysqli_fetch_assoc($logo_rs);
    if ($logo_row && !empty($logo_row['xfile'])) {
        $favicon_path = 'uploads/logo/' . $logo_row['xfile'];
    }
}
?>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">
<head>
  <meta charset="utf-8" />
  <title>Sign In | Timesten Kenya</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
  <meta content="Themesbrand" name="author" />
  <link rel="shortcut icon" href="<?php echo htmlspecialchars($favicon_path); ?>">
  <script src="assets/js/layout.js"></script>
  <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
  <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
  <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" />
  <link href="assets/css/custom.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <div class="auth-page-wrapper auth-bg-cover py-5 d-flex justify-content-center align-items-center min-vh-100">
    <div class="bg-overlay"></div>
    <div class="auth-page-content overflow-hidden pt-lg-5">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="card overflow-hidden">
              <div class="row g-0">
                <div class="col-lg-6">
                  <div class="p-lg-5 p-4 auth-one-bg h-100">
                    <div class="bg-overlay"></div>
                    <div class="position-relative h-100 d-flex flex-column">
                      <div class="mb-4">
                        <?php
                        $rr = mysqli_query($con, "SELECT ufile FROM logo");
                        $r = mysqli_fetch_row($rr);
                        $ufile = $r[0];
                        ?>
                        <a href="index.php" class="d-block">
                          <img src="uploads/logo/<?php echo htmlspecialchars($ufile); ?>" alt="" height="40">
                        </a>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="p-lg-5 p-4">
                    <div>
                      <h5 class="text-primary">Welcome Back !</h5>
                      <p class="text-muted">Sign in to continue into your dashboard.</p>
                    </div>
                    <div class="mt-4">
                      <?php
                      if (isset($errormsg)) {
                        echo $errormsg;
                      }
                      ?>
                      <form class="user" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"], ENT_QUOTES, "utf-8"); ?>" method="post">
                        <div class="mb-3">
                          <label for="username" class="form-label">Username</label>
                          <input type="text" class="form-control" id="username" name="username" placeholder="Enter username">
                        </div>
                        <div class="mb-3">
                          <label class="form-label" for="password-input">Password</label>
                          <div class="position-relative auth-pass-inputgroup mb-3">
                            <input type="password" class="form-control pe-5" name="password" placeholder="Enter password" id="password-input">
                          </div>
                        </div>
                        <div class="mt-4">
                          <button class="btn btn-success w-100" type="submit">Sign In</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <footer class="footer">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="text-center">
              <?php
              $rr = mysqli_query($con, "SELECT site_footer FROM siteconfig");
              $r = mysqli_fetch_row($rr);
              $site_footer = $r[0];
              ?>
              <p class="mb-0">
                <?php echo htmlspecialchars($site_footer); ?>
              </p>
            </div>
          </div>
        </div>
      </div>
    </footer>
  </div>
  <script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/libs/simplebar/simplebar.min.js"></script>
  <script src="assets/libs/node-waves/waves.min.js"></script>
  <script src="assets/libs/feather-icons/feather.min.js"></script>
  <script src="assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
  <script src="assets/js/plugins.js"></script>
  <script src="assets/js/pages/password-addon.init.js"></script>
</body>
</html>
