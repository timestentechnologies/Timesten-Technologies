<?php
include"header.php";
include"sidebar.php";
$app_id = mysqli_real_escape_string($con, $_GET['id']);

$app_q = mysqli_query($con, "SELECT a.*, j.job_title FROM job_applications a JOIN jobs j ON a.job_id=j.id WHERE a.id='$app_id' LIMIT 1");
$app = $app_q ? mysqli_fetch_assoc($app_q) : null;
?>

<div class="main-content">
 <div class="page-content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
          <h4 class="mb-sm-0">Application Details</h4>
          <div class="page-title-right">
            <ol class="breadcrumb m-0">
              <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
              <li class="breadcrumb-item active">Application</li>
            </ol>
          </div>
        </div>
      </div>
    </div>

    <?php if(!$app){ ?>
      <div class="alert alert-danger">Application not found.</div>
    <?php } else { ?>

    <div class="row">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0"><?php print $app['job_title']; ?> - <?php print $app['full_name']; ?></h5>
            <a href="javascript:history.back()" class="btn btn-soft-secondary btn-sm">Back</a>
          </div>
          <div class="card-body">
            <p><strong>Email:</strong> <?php print $app['email']; ?></p>
            <p><strong>Phone:</strong> <?php print $app['phone']; ?></p>
            <p><strong>Submitted:</strong> <?php print $app['created_at']; ?></p>
            <p><strong>CV:</strong> <a href="uploads/cv/<?php print $app['cv_file']; ?>" target="_blank">Download</a></p>
            <hr>
            <h5>Cover Letter</h5>
            <p><?php echo nl2br($app['cover_letter']); ?></p>
            <hr>
            <h5>Answers</h5>
            <div class="table-responsive">
              <table class="table table-bordered align-middle">
                <thead>
                  <tr>
                    <th>Question</th>
                    <th>Answer</th>
                  </tr>
                </thead>
                <tbody>
                  <?php
                    $ans_q = mysqli_query($con, "SELECT q.question_text, a.answer_text FROM job_application_answers a JOIN job_questions q ON a.question_id=q.id WHERE a.application_id='$app_id' ORDER BY a.id ASC");
                    while($r = mysqli_fetch_assoc($ans_q)){
                      $qt = $r['question_text'];
                      $at = $r['answer_text'];
                      print "<tr><td>$qt</td><td>".nl2br($at)."</td></tr>";
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
