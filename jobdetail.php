<?php
include "header.php";
$todo = mysqli_real_escape_string($con, $_GET["id"]);

$has_views_col = false;
$col_rs_views = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'views'");
if ($col_rs_views && mysqli_num_rows($col_rs_views) > 0) {
    $has_views_col = true;
}

$job_q = mysqli_query($con, "SELECT * FROM jobs WHERE id='$todo' AND status='open' LIMIT 1");
$job = $job_q ? mysqli_fetch_assoc($job_q) : null;

$applications_count = 0;
$app_count_q = mysqli_query($con, "SELECT COUNT(*) AS c FROM job_applications WHERE job_id='$todo'");
if ($app_count_q) {
    $app_count_row = mysqli_fetch_assoc($app_count_q);
    $applications_count = $app_count_row ? (int)$app_count_row['c'] : 0;
}

$display_views = ($has_views_col && isset($job['views'])) ? (100 + (int)$job['views']) : 100;
$display_applications = 10 + $applications_count;

if ($job && $has_views_col) {
    mysqli_query($con, "UPDATE jobs SET views = COALESCE(views, 0) + 1 WHERE id='$todo' LIMIT 1");
    if (isset($job['views'])) {
        $job['views'] = (int)$job['views'] + 1;
    } else {
        $job['views'] = 1;
    }
}

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
                                <div class="d-flex justify-content-between align-items-center gap-2 mb-2">
                                    <span><strong>Views:</strong> <?php print (int)$display_views; ?></span>
                                    <span><strong>Applicants:</strong> <?php print (int)$display_applications; ?></span>
                                </div>
                                <?php if (isset($job['salary']) && strlen(trim($job['salary'])) > 0) { ?>
                                    <p class="mb-2"><strong>Salary:</strong> <?php print htmlspecialchars($job['salary']); ?></p>
                                <?php } ?>
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
                                <style>
                                    .job-questions-wizard{border-top:1px solid rgba(120,130,130,.35);margin-top:14px;padding-top:14px}
                                    .job-questions-header{display:flex;align-items:center;justify-content:space-between;gap:10px;margin-bottom:10px}
                                    .job-questions-header .job-questions-count{font-size:13px;opacity:.85}
                                    .job-question-step{display:none}
                                    .job-question-step.is-active{display:block}
                                    .job-questions-nav{display:flex;gap:10px;justify-content:space-between;margin-top:10px}
                                    .job-questions-nav .btn{flex:1}
                                </style>
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
                                        $questions_rs = mysqli_query($con, "SELECT * FROM job_questions WHERE job_id='$todo' ORDER BY id ASC");
                                        $job_questions = [];
                                        if ($questions_rs) {
                                            while ($qrow = mysqli_fetch_assoc($questions_rs)) {
                                                $job_questions[] = $qrow;
                                            }
                                        }
                                        $job_questions_count = count($job_questions);
                                    ?>

                                    <div class="job-questions-wizard" data-total="<?php echo (int)$job_questions_count; ?>">
                                        <div class="job-questions-header">
                                            <div class="job-questions-title"><strong>Questions</strong></div>
                                            <div class="job-questions-count">
                                                <span id="jobQuestionStepCurrent">1</span> / <span id="jobQuestionStepTotal"><?php echo (int)$job_questions_count; ?></span>
                                            </div>
                                        </div>

                                        <?php
                                            if ($job_questions_count > 0) {
                                                $stepIndex = 0;
                                                foreach ($job_questions as $qrow) {
                                                    $qid = $qrow['id'];
                                                    $qtext = $qrow['question_text'];
                                                    $is_required = (int)$qrow['is_required'] === 1 ? '1' : '0';
                                                    $activeClass = $stepIndex === 0 ? ' is-active' : '';
                                                    print "
                                                    <div class='form-group mb-3 job-question-step$activeClass' data-step='$stepIndex'>
                                                        <label class='mb-2'><strong>$qtext</strong></label>
                                                        <textarea class='form-control' name='question_$qid' rows='3' data-required='$is_required'></textarea>
                                                    </div>
                                                    ";
                                                    $stepIndex++;
                                                }
                                            } else {
                                                print "<div class='form-group mb-3'><em>No additional questions for this role.</em></div>";
                                            }
                                        ?>

                                        <div class="job-questions-nav" id="jobQuestionsNav">
                                            <button type="button" class="btn btn-bordered" id="jobQuestionPrev">Previous</button>
                                            <button type="button" class="btn btn-bordered active" id="jobQuestionNext">Next</button>
                                        </div>
                                    </div>

                                    <button type="submit" name="apply" class="btn btn-bordered active btn-block mt-2" id="jobApplySubmit">
                                        <span class="text-white pr-3"><i class="fas fa-paper-plane"></i></span>Submit Application
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </section>

        <script>
            (function () {
                var wizard = document.querySelector('.job-questions-wizard');
                if (!wizard) return;

                var steps = Array.prototype.slice.call(document.querySelectorAll('.job-question-step'));
                var total = steps.length;
                var current = 0;

                var elCurrent = document.getElementById('jobQuestionStepCurrent');
                var elTotal = document.getElementById('jobQuestionStepTotal');
                var btnPrev = document.getElementById('jobQuestionPrev');
                var btnNext = document.getElementById('jobQuestionNext');
                var nav = document.getElementById('jobQuestionsNav');
                var btnSubmit = document.getElementById('jobApplySubmit');
                var form = wizard.closest('form');

                if (elTotal) elTotal.textContent = String(total);

                function setRequiredForActiveStep(activeIdx) {
                    steps.forEach(function (stepEl, idx) {
                        var textarea = stepEl.querySelector('textarea');
                        if (!textarea) return;
                        textarea.required = false;
                        if (idx === activeIdx) {
                            textarea.required = textarea.getAttribute('data-required') === '1';
                        }
                    });
                }

                function render() {
                    if (total === 0) {
                        if (nav) nav.style.display = 'none';
                        if (btnSubmit) btnSubmit.style.display = '';
                        if (elCurrent) elCurrent.textContent = '0';
                        return;
                    }

                    steps.forEach(function (stepEl, idx) {
                        if (idx === current) stepEl.classList.add('is-active');
                        else stepEl.classList.remove('is-active');
                    });

                    if (elCurrent) elCurrent.textContent = String(current + 1);
                    if (btnPrev) btnPrev.disabled = current === 0;

                    var isLast = current === total - 1;
                    if (nav) nav.style.display = isLast ? 'none' : 'flex';
                    if (btnSubmit) btnSubmit.style.display = isLast ? '' : 'none';

                    setRequiredForActiveStep(current);
                }

                if (btnPrev) {
                    btnPrev.addEventListener('click', function () {
                        if (current > 0) {
                            current -= 1;
                            render();
                        }
                    });
                }

                if (btnNext) {
                    btnNext.addEventListener('click', function () {
                        if (form && typeof form.reportValidity === 'function') {
                            if (!form.reportValidity()) return;
                        }
                        if (current < total - 1) {
                            current += 1;
                            render();
                        }
                    });
                }

                render();
            })();
        </script>

<?php include "footer.php"; ?>
