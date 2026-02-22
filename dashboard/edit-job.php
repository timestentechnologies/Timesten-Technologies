<?php
include"header.php";
include"sidebar.php";
$todo = mysqli_real_escape_string($con, $_GET['id']);

$query = mysqli_query($con, "SELECT * FROM jobs WHERE id='$todo' LIMIT 1");
$row = $query ? mysqli_fetch_assoc($query) : null;

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

    $qb = mysqli_query($con, "UPDATE jobs SET job_title='$job_title', short_desc='$short_desc', job_desc='$job_desc', requirements='$requirements', location='$location', job_type='$job_type', deadline='$deadline', status='$job_status' WHERE id='$todo'");

    if($qb){
        $errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Job updated successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        $query = mysqli_query($con, "SELECT * FROM jobs WHERE id='$todo' LIMIT 1");
        $row = $query ? mysqli_fetch_assoc($query) : $row;
    } else {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Failed to update job.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
}
?>
<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Edit Job</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
                                        <li class="breadcrumb-item active">Edit</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-body p-4">
                                    <?php if($_SERVER['REQUEST_METHOD']=='POST'){ print $errormsg; } ?>
                                    <?php if(!$row){ ?>
                                        <div class="alert alert-danger">Job not found.</div>
                                    <?php } else { ?>
                                    <form action="" method="post">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Job Title</label>
                                                    <input type="text" class="form-control" name="job_title" value="<?php echo $row['job_title']; ?>" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Short Description</label>
                                                    <input type="text" class="form-control" name="short_desc" value="<?php echo $row['short_desc']; ?>" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Location</label>
                                                    <input type="text" class="form-control" name="location" value="<?php echo $row['location']; ?>" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Job Type</label>
                                                    <input type="text" class="form-control" name="job_type" value="<?php echo $row['job_type']; ?>" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Deadline</label>
                                                    <input type="date" class="form-control" name="deadline" value="<?php echo $row['deadline']; ?>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Status</label>
                                                    <select class="form-control" name="status">
                                                        <option value="open" <?php if($row['status']=='open'){ echo 'selected'; } ?>>Open</option>
                                                        <option value="closed" <?php if($row['status']=='closed'){ echo 'selected'; } ?>>Closed</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Job Description</label>
                                                    <textarea class="form-control" name="job_desc" rows="4" required><?php echo $row['job_desc']; ?></textarea>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Requirements</label>
                                                    <textarea class="form-control" name="requirements" rows="4" required><?php echo $row['requirements']; ?></textarea>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Update Job</button>
                                                    <a href="jobs" class="btn btn-soft-secondary">Back</a>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <?php include"footer.php";?>
