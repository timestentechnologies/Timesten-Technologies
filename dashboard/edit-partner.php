<?php
ob_start();
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS partners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    website_url VARCHAR(255),
    logo VARCHAR(255),
    is_active TINYINT(1) DEFAULT 1,
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) {
    header("Location: partners");
    exit;
}

$rs = mysqli_query($con, "SELECT * FROM partners WHERE id = $id");
if (!$rs || mysqli_num_rows($rs) === 0) {
    header("Location: partners");
    exit;
}

$row = mysqli_fetch_assoc($rs);

$status = "OK";
$msg = "";

if (isset($_POST['save'])) {
    $name = mysqli_real_escape_string($con, $_POST['name']);
    $website_url = mysqli_real_escape_string($con, $_POST['website_url']);
    $is_active = isset($_POST['is_active']) ? 1 : 0;
    $sort_order = isset($_POST['sort_order']) ? (int)$_POST['sort_order'] : 0;

    if (strlen(trim($_POST['name'])) < 2) {
        $msg .= "Partner name must be at least 2 characters.<br>";
        $status = "NOTOK";
    }

    $uploads_dir = 'uploads/partners';
    if (!is_dir($uploads_dir)) {
        @mkdir($uploads_dir, 0755, true);
    }

    $logo_file = $row['logo'];
    if (isset($_FILES['logo']) && isset($_FILES['logo']['tmp_name']) && strlen($_FILES['logo']['tmp_name'])) {
        $tmp_name = $_FILES['logo']['tmp_name'];
        $original_name = basename($_FILES['logo']['name']);
        $safe_name = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
        $random_digit = rand(1000, 9999);
        $logo_file = $random_digit . '_' . $safe_name;
        move_uploaded_file($tmp_name, "$uploads_dir/$logo_file");
    }

    if ($status == "OK") {
        $qb = mysqli_query($con, "UPDATE partners SET name='$name', website_url='$website_url', logo='$logo_file', is_active='$is_active', sort_order='$sort_order' WHERE id=$id");
        if ($qb) {
            header("Location: partners?updated=1");
            exit;
        } else {
            $errormsg = "<div class='alert alert-danger alert-dismissible fade show'>Database error: " . mysqli_error($con) . "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    } else {
        $errormsg = "<div class='alert alert-danger alert-dismissible fade show'>" . $msg . "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
}
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Edit Partner</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="partners">Partners</a></li>
                                        <li class="breadcrumb-item active">Edit</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <?php if (isset($errormsg)) { print $errormsg; } ?>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Partner Details</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Partner Name</label>
                                                    <input type="text" name="name" class="form-control" value="<?php echo htmlspecialchars($row['name']); ?>" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Website URL (optional)</label>
                                                    <input type="text" name="website_url" class="form-control" value="<?php echo htmlspecialchars($row['website_url']); ?>" placeholder="https://example.com">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Logo</label>
                                                    <input type="file" name="logo" class="form-control" accept="image/*">
                                                    <?php if (!empty($row['logo'])) { ?>
                                                        <div class="mt-2">
                                                            <img src="uploads/partners/<?php echo htmlspecialchars($row['logo']); ?>" alt="logo" style="max-height:60px;">
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3">
                                                    <label class="form-label">Sort Order</label>
                                                    <input type="number" name="sort_order" class="form-control" value="<?php echo (int)$row['sort_order']; ?>">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3 mt-4">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="is_active" id="is_active" <?php echo ((int)$row['is_active'] === 1) ? 'checked' : ''; ?>>
                                                        <label class="form-check-label" for="is_active">Active</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <button type="submit" name="save" class="btn btn-primary">Update Partner</button>
                                        <a href="partners" class="btn btn-light">Back</a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <?php include"footer.php";?>
