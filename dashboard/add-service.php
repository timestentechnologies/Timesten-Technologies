<?php include "header.php"; ?>
<?php include "sidebar.php"; ?>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <!-- start page title -->
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Add Service</h4>

                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript: void(0);">Service</a></li>
                                <li class="breadcrumb-item active">Add</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end page title -->

            <div class="row">
                <!--end col-->
                <div class="col-xxl-9">
                    <div class="card mt-xxl-n5">
                        <div class="card-header">
                            <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">
                                        <i class="fas fa-home"></i> Add Service
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <?php
                        $status = "OK"; // Initial status
                        $msg = "";
                        $errormsg = ""; // Initialize $errormsg

                        if (isset($_POST['save'])) {
                            // Ensure $con is defined and connected
                            $con = new mysqli("localhost", "opulentl_timesten", "Moonlight#911", "opulentl_timestentech");

                            // Check connection
                            if (!$con) {
                                die("Connection failed: " . mysqli_connect_error());
                            }

                            $service_title = mysqli_real_escape_string($con, $_POST['service_title']);
                            $service_desc = mysqli_real_escape_string($con, $_POST['service_desc']);
                            $service_detail = mysqli_real_escape_string($con, $_POST['service_detail']);
                            $service_url = mysqli_real_escape_string($con, $_POST['service_url']);

                            if (strlen($service_title) < 5) {
                                $msg .= "Service Title Must Be More Than 5 Char Length.<br>";
                                $status = "NOTOK";
                            }
                            if (strlen($service_desc) > 150) {
                                $msg .= "Short Description Must Be Less Than 150 Char Length.<br>";
                                $status = "NOTOK";
                            }
                            if (strlen($service_detail) < 15) {
                                $msg .= "Service Detail Must Be More Than 15 Char Length.<br>";
                                $status = "NOTOK";
                            }

                            if (strlen($service_url) > 255) {
                                $msg .= "Service URL Must Be Less Than 255 Char Length.<br>";
                                $status = "NOTOK";
                            }

                            // Check if file was uploaded
                            $new_file_name = ''; // Initialize $new_file_name
                            if (isset($_FILES['ufile']) && $_FILES['ufile']['error'] == UPLOAD_ERR_OK) {
                                $uploads_dir = 'uploads/services';
                                $tmp_name = $_FILES["ufile"]["tmp_name"];
                                $name = basename($_FILES["ufile"]["name"]);
                                $random_digit = rand(0000, 9999);
                                $new_file_name = $random_digit . $name;

                                if (!move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name")) {
                                    $msg .= "File upload failed.<br>";
                                    $status = "NOTOK";
                                }
                            }

                            if ($status == "OK") {
                                $query = "INSERT INTO service (service_title, service_desc, service_detail, service_url, ufile) VALUES ('$service_title', '$service_desc', '$service_detail', '$service_url', '$new_file_name')";
                                $qb = mysqli_query($con, $query);

                                if ($qb) {
                                    $errormsg = "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
    Service has been added successfully.
    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
</div>";
                                } else {
                                    $errormsg = "
<div class='alert alert-danger alert-dismissible alert-outline fade show'>
    Error: " . mysqli_error($con) . "
    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
</div>";
                                }
                            } else {
                                $errormsg = "
<div class='alert alert-danger alert-dismissible alert-outline fade show'>
    $msg
    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
</div>";
                            }

                            // Close the database connection
                            mysqli_close($con);
                        }
                        ?>

                        <div class="card-body p-4">
                            <div class="tab-content">
                                <div class="tab-pane active" id="personalDetails" role="tabpanel">
                                    <?php
                                    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                                        echo $errormsg;
                                    }
                                    ?>
                                    <form action="" method="post" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label for="firstnameInput" class="form-label">Service Title</label>
                                                    <input type="text" class="form-control" id="firstnameInput" name="service_title" placeholder="Enter Service Title">
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label for="firstnameInput" class="form-label">Short Description</label>
                                                    <textarea class="form-control" id="exampleFormControlTextarea5" name="service_desc" rows="2"></textarea>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label for="firstnameInput" class="form-label">Service Detail</label>
                                                    <textarea class="form-control" id="exampleFormControlTextarea5" name="service_detail" rows="3"></textarea>
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label for="serviceUrlInput" class="form-label">Website URL</label>
                                                    <input type="url" class="form-control" id="serviceUrlInput" name="service_url" placeholder="https://example.com">
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label for="firstnameInput" class="form-label">Photo</label>
                                                    <input type="file" class="form-control" id="firstnameInput" name="ufile">
                                                </div>
                                            </div>

                                            <!--end col-->
                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Add Service</button>
                                                </div>
                                            </div>
                                            <!--end col-->
                                        </div>
                                        <!--end row-->
                                    </form>
                                </div>
                                <!--end tab-pane-->
                            </div>
                        </div>
                    </div>
                </div>
                <!--end col-->
            </div>
        </div>
        <!-- container-fluid -->
    </div>
    <!-- End Page-content -->

    <?php include "footer.php"; ?>
</div>
