<?php include "header.php"; ?>
<?php include "sidebar.php"; ?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">
            <!-- Start page title -->
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Update Logo</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="#">Logo</a></li>
                                <li class="breadcrumb-item active">Add</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End page title -->

            <div class="row">
                <div class="col-xxl-9">
                    <div class="card mt-xxl-n5">
                        <div class="card-header">
                            <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-bs-toggle="tab" href="#logoUpdate" role="tab">
                                        <i class="fas fa-home"></i> Update Logo
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="card-body p-4">
                            <div class="tab-content">
                                <div class="tab-pane active" id="logoUpdate" role="tabpanel">

                                    <?php
                                    // Initialize status and message variables
                                    $status = "OK";
                                    $msg = "";

                                    // Check if form is submitted
                                    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['save'])) {
                                        $uploads_dir = 'uploads/logo';

                                        // Validate and upload favicon
                                        if (isset($_FILES['xfile']) && $_FILES['xfile']['error'] === UPLOAD_ERR_OK) {
                                            $xfile_tmp_name = $_FILES['xfile']['tmp_name'];
                                            $xfile_name = uniqid() . '-' . basename($_FILES['xfile']['name']);
                                            if (move_uploaded_file($xfile_tmp_name, "$uploads_dir/$xfile_name")) {
                                                $xfile_path = $xfile_name;
                                            } else {
                                                $status = "NOTOK";
                                                $msg .= "Error uploading favicon. ";
                                            }
                                        } else {
                                            $status = "NOTOK";
                                            $msg .= "Favicon file upload error. ";
                                        }

                                        // Validate and upload logo
                                        if (isset($_FILES['ufile']) && $_FILES['ufile']['error'] === UPLOAD_ERR_OK) {
                                            $ufile_tmp_name = $_FILES['ufile']['tmp_name'];
                                            $ufile_name = uniqid() . '-' . basename($_FILES['ufile']['name']);
                                            if (move_uploaded_file($ufile_tmp_name, "$uploads_dir/$ufile_name")) {
                                                $ufile_path = $ufile_name;
                                            } else {
                                                $status = "NOTOK";
                                                $msg .= "Error uploading logo. ";
                                            }
                                        } else {
                                            $status = "NOTOK";
                                            $msg .= "Logo file upload error. ";
                                        }

                                        // Update database if uploads are successful
                                        if ($status == "OK") {
                                            $update_query = "UPDATE logo SET xfile='$xfile_path', ufile='$ufile_path' WHERE id=1";
                                            if (mysqli_query($con, $update_query)) {
                                                echo "<div class='alert alert-success alert-dismissible alert-outline fade show'>
                                                        Data updated successfully.
                                                        <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
                                                      </div>";
                                            } else {
                                                echo "<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                                                        Database update failed: " . mysqli_error($con) . "
                                                        <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
                                                      </div>";
                                            }
                                        } else {
                                            echo "<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                                                    $msg
                                                    <button type='button' class='btn-close' data-bs-dismiss='alert'></button>
                                                  </div>";
                                        }
                                    }

                                    // Fetch current logo and favicon from database
                                    $logo_query = "SELECT * FROM logo WHERE id=1";
                                    $logo_result = mysqli_query($con, $logo_query);
                                    $logo_data = mysqli_fetch_assoc($logo_result);
                                    ?>

                                    <form action="" method="post" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <span>Current Favicon:</span>
                                                <img src="uploads/logo/<?php echo $logo_data['xfile']; ?>" alt="Favicon" style="max-height:120px;">
                                                <div class="mb-3">
                                                    <label for="xfile" class="form-label">Favicon</label>
                                                    <input type="file" class="form-control" id="xfile" name="xfile" required>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <span>Current Logo:</span>
                                                <img src="uploads/logo/<?php echo $logo_data['ufile']; ?>" alt="Logo" style="max-height:120px;">
                                                <div class="mb-3">
                                                    <label for="ufile" class="form-label">Logo</label>
                                                    <input type="file" class="form-control" id="ufile" name="ufile" required>
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Update Logo</button>
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

