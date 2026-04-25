<?php
include"header.php";
include"sidebar.php";
$job_id = mysqli_real_escape_string($con, $_GET['job_id']);

$job_q = mysqli_query($con, "SELECT * FROM jobs WHERE id='$job_id' LIMIT 1");
$job = $job_q ? mysqli_fetch_assoc($job_q) : null;
?>

<div class="main-content">
 <div class="page-content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
          <h4 class="mb-sm-0">Applications</h4>
          <div class="page-title-right">
            <ol class="breadcrumb m-0">
              <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
              <li class="breadcrumb-item"><a href="jobs">Jobs</a></li>
              <li class="breadcrumb-item active">Applications</li>
            </ol>
          </div>
        </div>
      </div>
    </div>

    <?php if(!$job){ ?>
      <div class="alert alert-danger">Job not found.</div>
    <?php } else { ?>

    <div class="row">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0">Applications for: <?php print $job['job_title']; ?></h5>
            <a href="jobs" class="btn btn-soft-secondary btn-sm">Back</a>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table id="example" class="table table-bordered table-striped align-middle" style="width:100%">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Submitted</th>
                  <th>CV</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <?php
                  $q = mysqli_query($con, "SELECT * FROM job_applications WHERE job_id='$job_id' ORDER BY created_at DESC");
                  while($r = mysqli_fetch_assoc($q)){
                    $id = $r['id'];
                    $name = $r['full_name'];
                    $email = $r['email'];
                    $phone = $r['phone'];
                    $created = $r['created_at'];
                    $cv = $r['cv_file'];
                    $cv_link = "uploads/cv/".$cv;

                    print "<tr>
                      <td>$name</td>
                      <td>$email</td>
                      <td>$phone</td>
                      <td>$created</td>
                      <td><a href='$cv_link' target='_blank'>Download</a></td>
                      <td><a class='btn btn-sm btn-primary' href='application-view.php?id=$id'>View</a></td>
                    </tr>";
                  }
                ?>
              </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <?php } ?>
  </div>
 </div>
 <?php include"footer.php";?>
</div>
