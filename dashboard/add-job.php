<?php include"header.php";?>
<?php include"sidebar.php";?>
<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Add Job</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
                                        <li class="breadcrumb-item active">Add</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <?php
                        $status = "OK";
                        $msg = "";
                        $errormsg = "";

                        if(isset($_POST['save'])){
                            $job_title = mysqli_real_escape_string($con,$_POST['job_title']);
                            $short_desc = mysqli_real_escape_string($con,$_POST['short_desc']);
                            $job_desc = mysqli_real_escape_string($con,$_POST['job_desc']);
                            $requirements = mysqli_real_escape_string($con,$_POST['requirements']);
                            $location = mysqli_real_escape_string($con,$_POST['location']);
                            $job_type = mysqli_real_escape_string($con,$_POST['job_type']);
                            $deadline = mysqli_real_escape_string($con,$_POST['deadline']);
                            $job_status = mysqli_real_escape_string($con,$_POST['status']);

                            if(strlen($job_title) < 5){ $msg .= "Job title must be more than 5 characters.<br>"; $status = "NOTOK"; }
                            if(strlen($short_desc) < 5){ $msg .= "Short description is required.<br>"; $status = "NOTOK"; }
                            if(strlen($job_desc) < 10){ $msg .= "Job description is required.<br>"; $status = "NOTOK"; }
                            if(strlen($requirements) < 5){ $msg .= "Requirements are required.<br>"; $status = "NOTOK"; }
                            if(strlen($location) < 2){ $msg .= "Location is required.<br>"; $status = "NOTOK"; }
                            if(strlen($job_type) < 2){ $msg .= "Job type is required.<br>"; $status = "NOTOK"; }

                            if($status=="OK"){
                                $qb = mysqli_query($con,"INSERT INTO jobs (job_title, short_desc, job_desc, requirements, location, job_type, deadline, status, created_at) VALUES ('$job_title', '$short_desc', '$job_desc', '$requirements', '$location', '$job_type', '$deadline', '$job_status', NOW())");
                                if($qb){
                                    $errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Job added successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                                } else {
                                    $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Failed to add job.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                                }
                            } else {
                                $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>$msg<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                            }
                        }
                    ?>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-header">
                                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">Add Job</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card-body p-4">
                                    <?php if($_SERVER['REQUEST_METHOD']=='POST'){ print $errormsg; } ?>
                                    <form action="" method="post">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Job Title</label>
                                                    <input type="text" class="form-control" name="job_title" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Short Description</label>
                                                    <input type="text" class="form-control" name="short_desc" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Location</label>
                                                    <input type="text" class="form-control" name="location" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Job Type</label>
                                                    <input type="text" class="form-control" name="job_type" placeholder="Full-time / Part-time / Contract" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Deadline</label>
                                                    <input type="date" class="form-control" name="deadline">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Status</label>
                                                    <select class="form-control" name="status">
                                                        <option value="open">Open</option>
                                                        <option value="closed">Closed</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Job Description</label>
                                                    <textarea class="form-control" name="job_desc" rows="4" required></textarea>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Requirements</label>
                                                    <textarea class="form-control" name="requirements" rows="4" required></textarea>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Add Job</button>
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
            <?php include"footer.php";?>
