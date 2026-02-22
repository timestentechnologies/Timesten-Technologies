<?php
include "header.php";
include "sidebar.php";

// Connect and sanitize ID
$todo = mysqli_real_escape_string($con, $_GET['id']);

// Fetch existing service record
$query = "SELECT * FROM service WHERE id='$todo'";
$result = mysqli_query($con, $query);
$row = mysqli_fetch_assoc($result);

$service_title = $row['service_title'];
$service_desc = $row['service_desc'];
$service_detail = $row['service_detail'];
$service_url = isset($row['service_url']) ? $row['service_url'] : '';
$existing_file = $row['ufile'];

$status = "OK";
$msg = "";
$errormsg = "";

// Handle form submission
if (isset($_POST['save'])) {
    $service_title = mysqli_real_escape_string($con, $_POST['service_title']);
    $service_desc = mysqli_real_escape_string($con, $_POST['service_desc']);
    $service_detail = mysqli_real_escape_string($con, $_POST['service_detail']);
    $service_url = mysqli_real_escape_string($con, $_POST['service_url']);

    $update_image_sql = "";
    $new_file_name = "";

    // Handle file upload if a new one is provided
    if (isset($_FILES['ufile']) && $_FILES['ufile']['error'] === UPLOAD_ERR_OK) {
        $uploads_dir = 'uploads/services';
        $tmp_name = $_FILES["ufile"]["tmp_name"];
        $original_name = basename($_FILES["ufile"]["name"]);
        $random_digit = rand(1000, 9999);
        $new_file_name = $random_digit . '_' . preg_replace("/[^a-zA-Z0-9.]/", "", $original_name);
        $file_type = mime_content_type($tmp_name);
        $allowed_types = ['image/jpeg', 'image/png','image/webp', 'image/jpg'];

        if (in_array($file_type, $allowed_types)) {
            if (move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name")) {
                $update_image_sql = ", ufile = '$new_file_name'";
            } else {
                $msg .= "Image upload failed.<br>";
                $status = "NOTOK";
            }
        } else {
            $msg .= "Only JPG and PNG files are allowed.<br>";
            $status = "NOTOK";
        }
    }

    // Run update query
    if ($status == "OK") {
        $sql = "UPDATE service SET service_title='$service_title', service_desc='$service_desc', service_detail='$service_detail', service_url='$service_url' $update_image_sql WHERE id='$todo'";
        $qb = mysqli_query($con, $sql);

        if ($qb) {
            $errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>
                            Service updated successfully.
                            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                        </div>";
        } else {
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                            Error updating service.
                            <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                        </div>";
        }
    } else {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                        $msg
                        <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                    </div>";
    }
}
?>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <!-- Page Title -->
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Edit Service</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="#">Service</a></li>
                                <li class="breadcrumb-item active">Edit</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form Content -->
            <div class="row">
                <div class="col-xxl-9">
                    <div class="card mt-xxl-n5">
                        <div class="card-header">
                            <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab">
                                        <i class="fas fa-edit"></i> Edit Service
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="card-body p-4">
                            <div class="tab-content">
                                <div class="tab-pane active" id="personalDetails" role="tabpanel">
                                    <?php if ($_SERVER['REQUEST_METHOD'] == 'POST') echo $errormsg; ?>

                                    <form action="" method="post" enctype="multipart/form-data">
                                        <div class="row">

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Service Title</label>
                                                    <input type="text" class="form-control" name="service_title" value="<?php echo $service_title; ?>" required>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Short Description</label>
                                                    <textarea class="form-control" name="service_desc" rows="2" required><?php echo $service_desc; ?></textarea>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Service Detail</label>
                                                    <textarea class="form-control" name="service_detail" rows="3" required><?php echo $service_detail; ?></textarea>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Website URL</label>
                                                    <input type="url" class="form-control" name="service_url" value="<?php echo $service_url; ?>" placeholder="https://example.com">
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Change Photo (optional)</label>
                                                    <input type="file" class="form-control" name="ufile">
                                                    <?php if (!empty($existing_file)): ?>
                                                        <label class="form-label mt-2">Current Image:</label>
                                                        <iframe src="uploads/services/<?php echo $existing_file; ?>" width="150" height="150" frameborder="0"></iframe>
                                                    <?php endif; ?>
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Update Service</button>
                                                </div>
                                            </div>

                                        </div>
                                    </form>

                                </div> <!-- tab-pane -->
                            </div> <!-- tab-content -->
                        </div> <!-- card-body -->
                    </div> <!-- card -->
                </div> <!-- col -->
            </div> <!-- row -->

        </div> <!-- container-fluid -->
    </div> <!-- page-content -->
    <?php include "footer.php"; ?>
</div> <!-- main-content -->
