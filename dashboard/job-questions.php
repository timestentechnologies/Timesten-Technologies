<?php
include"header.php";
include"sidebar.php";
$job_id = mysqli_real_escape_string($con, $_GET['job_id']);

$job_q = mysqli_query($con, "SELECT * FROM jobs WHERE id='$job_id' LIMIT 1");
$job = $job_q ? mysqli_fetch_assoc($job_q) : null;

$errormsg = "";

if(isset($_POST['save_question'])){
    $question_text = mysqli_real_escape_string($con, $_POST['question_text']);
    $is_required = isset($_POST['is_required']) ? 1 : 0;

    if(strlen($question_text) > 1){
        $qb = mysqli_query($con, "INSERT INTO job_questions (job_id, question_text, is_required) VALUES ('$job_id', '$question_text', '$is_required')");
        if($qb){
            $errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Question added successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Failed to add question.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }
}

if(isset($_GET['delete'])){
    $qid = mysqli_real_escape_string($con, $_GET['delete']);
    mysqli_query($con, "DELETE FROM job_questions WHERE id='$qid' AND job_id='$job_id'");
    print "<script>window.location='job-questions.php?job_id=$job_id';</script>";
    exit;
}
?>

<div class="main-content">
 <div class="page-content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
          <h4 class="mb-sm-0">Job Questions</h4>
          <div class="page-title-right">
            <ol class="breadcrumb m-0">
              <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
              <li class="breadcrumb-item"><a href="jobs">Jobs</a></li>
              <li class="breadcrumb-item active">Questions</li>
            </ol>
          </div>
        </div>
      </div>
    </div>

    <?php if($_SERVER['REQUEST_METHOD']=='POST'){ print $errormsg; } ?>

    <?php if(!$job){ ?>
      <div class="alert alert-danger">Job not found.</div>
    <?php } else { ?>

    <div class="row">
      <div class="col-lg-6">
        <div class="card">
          <div class="card-header">
            <h5 class="card-title mb-0">Add Question for: <?php print $job['job_title']; ?></h5>
          </div>
          <div class="card-body">
            <form method="post">
              <div class="mb-3">
                <label class="form-label">Question</label>
                <textarea class="form-control" name="question_text" rows="3" required></textarea>
              </div>
              <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="is_required" name="is_required" value="1">
                <label class="form-check-label" for="is_required">Required</label>
              </div>
              <button type="submit" name="save_question" class="btn btn-primary">Add Question</button>
              <a href="jobs" class="btn btn-soft-secondary">Back</a>
            </form>
          </div>
        </div>
      </div>

      <div class="col-lg-6">
        <div class="card">
          <div class="card-header">
            <h5 class="card-title mb-0">Existing Questions</h5>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered align-middle">
                <thead>
                  <tr>
                    <th>Question</th>
                    <th>Required</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <?php
                    $q = mysqli_query($con, "SELECT * FROM job_questions WHERE job_id='$job_id' ORDER BY id DESC");
                    while($r = mysqli_fetch_assoc($q)){
                      $qid = $r['id'];
                      $qt = $r['question_text'];
                      $req = $r['is_required'] == 1 ? 'Yes' : 'No';
                      print "<tr>
                        <td>$qt</td>
                        <td>$req</td>
                        <td><a class='btn btn-sm btn-danger' href='job-questions.php?job_id=$job_id&delete=$qid'>Delete</a></td>
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
