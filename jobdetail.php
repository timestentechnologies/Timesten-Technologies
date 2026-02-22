<?php
include "header.php";
$todo = mysqli_real_escape_string($con, $_GET["id"]);

$job_q = mysqli_query($con, "SELECT * FROM jobs WHERE id='$todo' AND status='open' LIMIT 1");
$job = $job_q ? mysqli_fetch_assoc($job_q) : null;

$errormsg = "";

if (isset($_POST['apply'])) {
    $full_name = mysqli_real_escape_string($con, $_POST['full_name']);
    $email = mysqli_real_escape_string($con, $_POST['email']);
    $phone = mysqli_real_escape_string($con, $_POST['phone']);
    $cover_letter = mysqli_real_escape_string($con, $_POST['cover_letter']);

    $status = "OK";
    $msg = "";

    if (strlen($full_name) < 3) {
        $msg .= "Full name is required.<br>";
        $status = "NOTOK";
    }

    if (strlen($email) < 5) {
        $msg .= "Email is required.<br>";
        $status = "NOTOK";
    }

    if (strlen($phone) < 7) {
        $msg .= "Phone is required.<br>";
        $status = "NOTOK";
    }

    $cv_file_name = "";
    if (!isset($_FILES['cv']) || $_FILES['cv']['error'] !== UPLOAD_ERR_OK) {
        $msg .= "CV is required.<br>";
        $status = "NOTOK";
    } else {
        $uploads_dir = 'dashboard/uploads/cv';
        $tmp_name = $_FILES['cv']['tmp_name'];
        $original_name = basename($_FILES['cv']['name']);
        $random_digit = rand(1000, 9999);
        $safe_name = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
        $cv_file_name = $random_digit . '_' . $safe_name;

        $file_type = mime_content_type($tmp_name);
        $allowed_types = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
        if (!in_array($file_type, $allowed_types)) {
            $msg .= "CV must be PDF or Word document.<br>";
            $status = "NOTOK";
        } else {
            if (!move_uploaded_file($tmp_name, "$uploads_dir/$cv_file_name")) {
                $msg .= "CV upload failed.<br>";
                $status = "NOTOK";
            }
        }
    }

    if ($status === "OK") {
        $insert_app = mysqli_query($con, "INSERT INTO job_applications (job_id, full_name, email, phone, cover_letter, cv_file, created_at) VALUES ('$todo', '$full_name', '$email', '$phone', '$cover_letter', '$cv_file_name', NOW())");

        if ($insert_app) {
            $app_id = mysqli_insert_id($con);

            $q_q = mysqli_query($con, "SELECT * FROM job_questions WHERE job_id='$todo' ORDER BY id ASC");
            if ($q_q) {
                while ($qrow = mysqli_fetch_assoc($q_q)) {
                    $qid = $qrow['id'];
                    $answer_key = 'question_' . $qid;
                    $ans = isset($_POST[$answer_key]) ? mysqli_real_escape_string($con, $_POST[$answer_key]) : '';
                    mysqli_query($con, "INSERT INTO job_application_answers (application_id, question_id, answer_text) VALUES ('$app_id', '$qid', '$ans')");
                }
            }

            $errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Application submitted successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Failed to submit application. Please try again.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    } else {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>$msg<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
}
?>

        <section class="section breadcrumb-area overlay-dark d-flex align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb-content d-flex flex-column align-items-center text-center">
                            <h2 class="text-white text-uppercase mb-3">Job Details</h2>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                                <li class="breadcrumb-item"><a class="text-uppercase text-white" href="careers.php">Careers</a></li>
                                <li class="breadcrumb-item text-white active">Apply</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section ptb_100 jobdetail-page">
            <div class="container">
                <?php if (!empty($errormsg)) { print $errormsg; } ?>

                <?php if (!$job) { ?>
                    <div class="row justify-content-center">
                        <div class="col-12 col-lg-8">
                            <div class="single-service p-4" style="border: solid 1px #788282;">
                                <h3 class="mb-2">Job not found</h3>
                                <p>The job you are looking for is not available.</p>
                                <a class="service-btn mt-3" href="careers.php">Back to Careers</a>
                            </div>
                        </div>
                    </div>
                <?php } else { ?>
                    <div class="row">
                        <div class="col-12 col-lg-7">
                            <div class="single-service p-4 jobdetail-card jobdetail-card--details" style="border: solid 1px #788282;">
                                <h2 class="mb-2"><?php print $job['job_title']; ?></h2>
                                <p class="mb-2"><strong>Location:</strong> <?php print $job['location']; ?></p>
                                <p class="mb-2"><strong>Type:</strong> <?php print $job['job_type']; ?></p>
                                <p class="mb-2"><strong>Deadline:</strong> <?php print $job['deadline']; ?></p>
                                <hr>
                                <h4 class="mb-2">Overview</h4>
                                <p><?php echo nl2br($job['job_desc']); ?></p>
                                <hr>
                                <h4 class="mb-2">Requirements</h4>
                                <p><?php echo nl2br($job['requirements']); ?></p>
                            </div>
                        </div>

                        <div class="col-12 col-lg-5 mt-4 mt-lg-0">
                            <div class="single-service p-4 jobdetail-card jobdetail-card--apply" style="border: solid 1px #788282;">
                                <h3 class="mb-3">Apply for this role</h3>
                                <form method="post" enctype="multipart/form-data">
                                    <div class="form-group mb-3">
                                        <input type="text" class="form-control" name="full_name" placeholder="Full Name" required>
                                    </div>
                                    <div class="form-group mb-3">
                                        <input type="email" class="form-control" name="email" placeholder="Email" required>
                                    </div>
                                    <div class="form-group mb-3">
                                        <input type="text" class="form-control" name="phone" placeholder="Phone" required>
                                    </div>
                                    <div class="form-group mb-3">
                                        <textarea class="form-control" name="cover_letter" rows="4" placeholder="Cover Letter (optional)"></textarea>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="mb-2"><strong>Upload CV</strong> (PDF/DOC/DOCX)</label>
                                        <input type="file" class="form-control" name="cv" required>
                                    </div>

                                    <?php
                                        $questions = mysqli_query($con, "SELECT * FROM job_questions WHERE job_id='$todo' ORDER BY id ASC");
                                        if ($questions) {
                                            while ($qrow = mysqli_fetch_assoc($questions)) {
                                                $qid = $qrow['id'];
                                                $qtext = $qrow['question_text'];
                                                $required = $qrow['is_required'] == 1 ? 'required' : '';
                                                print "
                                                <div class='form-group mb-3'>
                                                    <label class='mb-2'><strong>$qtext</strong></label>
                                                    <textarea class='form-control' name='question_$qid' rows='3' $required></textarea>
                                                </div>
                                                ";
                                            }
                                        }
                                    ?>

                                    <button type="submit" name="apply" class="btn btn-bordered active btn-block mt-2">
                                        <span class="text-white pr-3"><i class="fas fa-paper-plane"></i></span>Submit Application
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </section>

<?php include "footer.php"; ?>
