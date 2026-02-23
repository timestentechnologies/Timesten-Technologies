<?php
include "header.php";

$errormsg = '';
$successmsg = '';

$current_username = isset($_SESSION['username']) ? $_SESSION['username'] : '';

$admin_username = $current_username;
$admin_password_hash = '';

if (strlen(trim($current_username)) > 0) {
    $stmt = mysqli_prepare($con, "SELECT username, password FROM admin WHERE username = ? LIMIT 1");
    if ($stmt) {
        mysqli_stmt_bind_param($stmt, 's', $current_username);
        mysqli_stmt_execute($stmt);
        mysqli_stmt_bind_result($stmt, $db_username, $db_password);
        if (mysqli_stmt_fetch($stmt)) {
            $admin_username = $db_username;
            $admin_password_hash = $db_password;
        }
        mysqli_stmt_close($stmt);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current_password = isset($_POST['current_password']) ? (string)$_POST['current_password'] : '';
    $new_email = isset($_POST['new_email']) ? trim((string)$_POST['new_email']) : '';
    $new_password = isset($_POST['new_password']) ? (string)$_POST['new_password'] : '';
    $confirm_password = isset($_POST['confirm_password']) ? (string)$_POST['confirm_password'] : '';

    if (strlen(trim($current_password)) < 1) {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Current password is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif (!$admin_password_hash || !password_verify($current_password, $admin_password_hash)) {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Current password is incorrect.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        $did_update = false;

        if (strlen($new_email) > 0 && $new_email !== $admin_username) {
            $stmt_chk = mysqli_prepare($con, "SELECT 1 FROM admin WHERE username = ? LIMIT 1");
            $exists = false;
            if ($stmt_chk) {
                mysqli_stmt_bind_param($stmt_chk, 's', $new_email);
                mysqli_stmt_execute($stmt_chk);
                mysqli_stmt_store_result($stmt_chk);
                $exists = mysqli_stmt_num_rows($stmt_chk) > 0;
                mysqli_stmt_close($stmt_chk);
            }

            if ($exists) {
                $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>That email/username is already taken.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } else {
                $stmt_up = mysqli_prepare($con, "UPDATE admin SET username = ? WHERE username = ? LIMIT 1");
                if ($stmt_up) {
                    mysqli_stmt_bind_param($stmt_up, 'ss', $new_email, $admin_username);
                    mysqli_stmt_execute($stmt_up);
                    mysqli_stmt_close($stmt_up);

                    $_SESSION['username'] = $new_email;
                    $admin_username = $new_email;
                    $did_update = true;
                }
            }
        }

        if (!$errormsg && (strlen($new_password) > 0 || strlen($confirm_password) > 0)) {
            if (strlen($new_password) < 6) {
                $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>New password must be at least 6 characters.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } elseif ($new_password !== $confirm_password) {
                $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>New password and confirm password do not match.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } else {
                $new_hash = password_hash($new_password, PASSWORD_DEFAULT);
                $stmt_pw = mysqli_prepare($con, "UPDATE admin SET password = ? WHERE username = ? LIMIT 1");
                if ($stmt_pw) {
                    mysqli_stmt_bind_param($stmt_pw, 'ss', $new_hash, $admin_username);
                    mysqli_stmt_execute($stmt_pw);
                    mysqli_stmt_close($stmt_pw);
                    $did_update = true;
                }
            }
        }

        if (!$errormsg && $did_update) {
            $successmsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Profile updated successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";

            $stmt_refresh = mysqli_prepare($con, "SELECT password FROM admin WHERE username = ? LIMIT 1");
            if ($stmt_refresh) {
                mysqli_stmt_bind_param($stmt_refresh, 's', $admin_username);
                mysqli_stmt_execute($stmt_refresh);
                mysqli_stmt_bind_result($stmt_refresh, $db_password2);
                if (mysqli_stmt_fetch($stmt_refresh)) {
                    $admin_password_hash = $db_password2;
                }
                mysqli_stmt_close($stmt_refresh);
            }
        }

        if (!$errormsg && !$did_update) {
            $successmsg = "<div class='alert alert-info alert-dismissible alert-outline fade show'>No changes to update.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }
}
?>

<?php include "sidebar.php"; ?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Profile</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                                <li class="breadcrumb-item active">Profile</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12 col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <?php
                            if (!empty($errormsg)) {
                                print $errormsg;
                            }
                            if (!empty($successmsg)) {
                                print $successmsg;
                            }
                            ?>

                            <form method="post">
                                <div class="mb-3">
                                    <label class="form-label">Current Email/Username</label>
                                    <input type="text" class="form-control" value="<?php print htmlspecialchars($admin_username); ?>" disabled>
                                </div>

                                <div class="mb-3">
                                    <label for="new_email" class="form-label">New Email</label>
                                    <input type="email" class="form-control" id="new_email" name="new_email" value="<?php print htmlspecialchars($admin_username); ?>">
                                </div>

                                <hr>

                                <div class="mb-3">
                                    <label for="current_password" class="form-label">Current Password</label>
                                    <input type="password" class="form-control" id="current_password" name="current_password" required>
                                </div>

                                <div class="mb-3">
                                    <label for="new_password" class="form-label">New Password</label>
                                    <input type="password" class="form-control" id="new_password" name="new_password">
                                </div>

                                <div class="mb-3">
                                    <label for="confirm_password" class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirm_password" name="confirm_password">
                                </div>

                                <div class="mt-4">
                                    <button type="submit" class="btn btn-primary">Update Profile</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <?php include "footer.php"; ?>
</div>
