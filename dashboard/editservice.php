<?php
include "header.php";
include "sidebar.php";

// Connect and sanitize ID
$todo = mysqli_real_escape_string($con, $_GET['id']);

// Fetch existing service record
$query  = "SELECT * FROM service WHERE id='$todo'";
$result = mysqli_query($con, $query);
$row    = mysqli_fetch_assoc($result);

$service_title  = $row['service_title'];
$service_desc   = $row['service_desc'];
$service_detail = $row['service_detail'];
$service_url    = isset($row['service_url']) ? $row['service_url'] : '';
$existing_file  = $row['ufile'];

$status   = "OK";
$msg      = "";
$errormsg = "";

// Handle form submission
if (isset($_POST['save'])) {
    $service_title  = mysqli_real_escape_string($con, $_POST['service_title']);
    $service_desc   = mysqli_real_escape_string($con, $_POST['service_desc']);
    $service_detail = mysqli_real_escape_string($con, $_POST['service_detail']);
    $service_url    = mysqli_real_escape_string($con, $_POST['service_url']);

    $update_image_sql = "";
    $new_file_name    = "";

    // Handle file upload if a new one is provided
    if (isset($_FILES['ufile']) && $_FILES['ufile']['error'] === UPLOAD_ERR_OK) {
        $uploads_dir   = 'uploads/services';
        $tmp_name      = $_FILES["ufile"]["tmp_name"];
        $original_name = basename($_FILES["ufile"]["name"]);
        $random_digit  = rand(1000, 9999);
        $new_file_name = $random_digit . '_' . preg_replace("/[^a-zA-Z0-9.]/", "", $original_name);
        $file_type     = mime_content_type($tmp_name);
        $allowed_types = ['image/jpeg', 'image/png', 'image/webp', 'image/jpg'];

        if (in_array($file_type, $allowed_types)) {
            if (move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name")) {
                $update_image_sql = ", ufile = '$new_file_name'";
            } else {
                $msg   .= "Image upload failed.<br>";
                $status = "NOTOK";
            }
        } else {
            $msg   .= "Only JPG and PNG files are allowed.<br>";
            $status = "NOTOK";
        }
    }

    // Run update query
    if ($status == "OK") {
        $sql = "UPDATE service SET service_title='$service_title', service_desc='$service_desc', service_detail='$service_detail', service_url='$service_url' $update_image_sql WHERE id='$todo'";
        $qb  = mysqli_query($con, $sql);

        if ($qb) {
            $has_service_media_table = false;
            $tm_rs = mysqli_query($con, "SHOW TABLES LIKE 'service_media'");
            if ($tm_rs && mysqli_num_rows($tm_rs) > 0) {
                $has_service_media_table = true;
            }

            if ($has_service_media_table && isset($_FILES['media_files']) && isset($_FILES['media_files']['name']) && is_array($_FILES['media_files']['name'])) {
                $uploads_dir_extra = 'uploads/services';
                $cnt = count($_FILES['media_files']['name']);
                for ($i = 0; $i < $cnt; $i++) {
                    if (!isset($_FILES['media_files']['error'][$i]) || $_FILES['media_files']['error'][$i] !== UPLOAD_ERR_OK) {
                        continue;
                    }
                    $tmp_name_extra      = $_FILES['media_files']['tmp_name'][$i];
                    $original_name_extra = basename($_FILES['media_files']['name'][$i]);
                    $random_digit_extra  = rand(1000, 9999);
                    $safe_name_extra     = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name_extra);
                    $new_file_extra      = $random_digit_extra . '_' . $safe_name_extra;

                    $file_type_extra = mime_content_type($tmp_name_extra);
                    $media_type = 'document';
                    if (strpos($file_type_extra, 'image/') === 0) {
                        $media_type = 'image';
                    } elseif (strpos($file_type_extra, 'video/') === 0) {
                        $media_type = 'video';
                    }

                    if (move_uploaded_file($tmp_name_extra, "$uploads_dir_extra/$new_file_extra")) {
                        $fp = mysqli_real_escape_string($con, $new_file_extra);
                        $mt = mysqli_real_escape_string($con, $media_type);
                        mysqli_query($con, "INSERT INTO service_media (service_id, file_path, media_type, created_at) VALUES ('$todo', '$fp', '$mt', NOW())");
                    }
                }
            }

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

// Fetch existing media files for this service
$existing_media = [];
$tm_rs2 = mysqli_query($con, "SHOW TABLES LIKE 'service_media'");
if ($tm_rs2 && mysqli_num_rows($tm_rs2) > 0) {
    $media_rs = mysqli_query($con, "SELECT * FROM service_media WHERE service_id='$todo' ORDER BY created_at DESC");
    while ($media_row = mysqli_fetch_assoc($media_rs)) {
        $existing_media[] = $media_row;
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

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Add More Media (images / video / documents)</label>
                                                    <input type="file" class="form-control" name="media_files[]" multiple>
                                                </div>
                                            </div>

                                            <!-- ===== Existing Media Gallery ===== -->
                                            <?php if (!empty($existing_media)): ?>
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold">Current Media Files</label>
                                                    <div class="d-flex flex-wrap gap-3" id="existing-media-container">
                                                        <?php foreach ($existing_media as $media): ?>
                                                        <div class="position-relative border rounded p-1 text-center" id="media-item-<?php echo $media['id']; ?>" style="width:130px;">

                                                            <?php if ($media['media_type'] === 'image'): ?>
                                                                <img src="uploads/services/<?php echo htmlspecialchars($media['file_path']); ?>"
                                                                     alt="media"
                                                                     class="img-fluid rounded"
                                                                     style="width:120px;height:100px;object-fit:cover;">

                                                            <?php elseif ($media['media_type'] === 'video'): ?>
                                                                <video width="120" height="100" controls style="object-fit:cover;border-radius:4px;">
                                                                    <source src="uploads/services/<?php echo htmlspecialchars($media['file_path']); ?>">
                                                                </video>

                                                            <?php else: ?>
                                                                <a href="uploads/services/<?php echo htmlspecialchars($media['file_path']); ?>"
                                                                   target="_blank"
                                                                   class="d-flex flex-column align-items-center justify-content-center text-muted text-decoration-none"
                                                                   style="width:120px;height:100px;">
                                                                    <i class="fas fa-file-alt fa-3x mb-1"></i>
                                                                    <small class="text-truncate w-100 px-1"><?php echo htmlspecialchars($media['file_path']); ?></small>
                                                                </a>
                                                            <?php endif; ?>

                                                            <button type="button"
                                                                    class="btn btn-danger btn-sm position-absolute top-0 end-0 p-0 lh-1 remove-media-btn"
                                                                    data-id="<?php echo $media['id']; ?>"
                                                                    title="Remove"
                                                                    style="width:22px;height:22px;font-size:12px;border-radius:50%;">
                                                                &times;
                                                            </button>
                                                        </div>
                                                        <?php endforeach; ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <?php endif; ?>
                                            <!-- ===== End Existing Media Gallery ===== -->

                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Update Service</button>
                                                </div>
                                            </div>

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
    <?php include "footer.php"; ?>
</div>

<script>
document.querySelectorAll('.remove-media-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
        var mediaId = this.getAttribute('data-id');
        if (!confirm('Are you sure you want to remove this media file?')) return;

        var formData = new FormData();
        formData.append('remove_media_id', mediaId);

        // Calls the dedicated handler file — no header.php conflict
        fetch('remove_service_media.php?id=<?php echo urlencode($_GET['id']); ?>', {
            method: 'POST',
            body: formData
        })
        .then(function(res) { return res.json(); })
        .then(function(data) {
            if (data.success) {
                var item = document.getElementById('media-item-' + mediaId);
                if (item) item.remove();
            } else {
                alert('Could not remove: ' + (data.error || 'Unknown error'));
            }
        })
        .catch(function(err) {
            alert('An error occurred: ' + err.message);
        });
    });
});
</script>
