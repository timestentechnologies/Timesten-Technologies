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

                            $cover_image = "";
                            if (isset($_FILES['cover_image']) && $_FILES['cover_image']['error'] === UPLOAD_ERR_OK) {
                                $uploads_dir = 'uploads/jobs';
                                if (!is_dir($uploads_dir)) {
                                    @mkdir($uploads_dir, 0755, true);
                                }

                                $tmp_name = $_FILES['cover_image']['tmp_name'];
                                $original_name = basename($_FILES['cover_image']['name']);
                                $safe_name = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
                                $random_digit = rand(1000, 9999);
                                $cover_image = $random_digit . '_' . $safe_name;

                                $img_info = @getimagesize($tmp_name);
                                if ($img_info === false) {
                                    $msg .= "Cover image must be a valid image file.<br>";
                                    $status = "NOTOK";
                                    $cover_image = "";
                                } else {
                                    $mime = isset($img_info['mime']) ? $img_info['mime'] : '';
                                    $allowed_mimes = ['image/jpeg', 'image/png', 'image/webp'];
                                    if (!in_array($mime, $allowed_mimes)) {
                                        $msg .= "Cover image must be JPG, PNG, or WEBP.<br>";
                                        $status = "NOTOK";
                                        $cover_image = "";
                                    } else {
                                        if (!move_uploaded_file($tmp_name, $uploads_dir . '/' . $cover_image)) {
                                            $msg .= "Cover image upload failed.<br>";
                                            $status = "NOTOK";
                                            $cover_image = "";
                                        }
                                    }
                                }
                            }

                            $question_texts = isset($_POST['question_text']) && is_array($_POST['question_text']) ? $_POST['question_text'] : array();
                            $question_required = isset($_POST['question_required']) && is_array($_POST['question_required']) ? $_POST['question_required'] : array();

                            if(strlen($job_title) < 5){ $msg .= "Job title must be more than 5 characters.<br>"; $status = "NOTOK"; }
                            if(strlen($short_desc) < 5){ $msg .= "Short description is required.<br>"; $status = "NOTOK"; }
                            if(strlen($job_desc) < 10){ $msg .= "Job description is required.<br>"; $status = "NOTOK"; }
                            if(strlen($requirements) < 5){ $msg .= "Requirements are required.<br>"; $status = "NOTOK"; }
                            if(strlen($location) < 2){ $msg .= "Location is required.<br>"; $status = "NOTOK"; }
                            if(strlen($job_type) < 2){ $msg .= "Job type is required.<br>"; $status = "NOTOK"; }

                            if($status=="OK"){
                                $cover_image_sql = mysqli_real_escape_string($con, $cover_image);

                                $has_cover_col = false;
                                $col_rs = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'cover_image'");
                                if ($col_rs && mysqli_num_rows($col_rs) > 0) {
                                    $has_cover_col = true;
                                }

                                if ($has_cover_col) {
                                    $qb = mysqli_query($con,"INSERT INTO jobs (job_title, short_desc, job_desc, requirements, location, job_type, deadline, status, cover_image, created_at) VALUES ('$job_title', '$short_desc', '$job_desc', '$requirements', '$location', '$job_type', '$deadline', '$job_status', '$cover_image_sql', NOW())");
                                } else {
                                    $qb = mysqli_query($con,"INSERT INTO jobs (job_title, short_desc, job_desc, requirements, location, job_type, deadline, status, created_at) VALUES ('$job_title', '$short_desc', '$job_desc', '$requirements', '$location', '$job_type', '$deadline', '$job_status', NOW())");
                                }
                                if($qb){
                                    $new_job_id = mysqli_insert_id($con);
                                    foreach ($question_texts as $idx => $qt_raw) {
                                        $qt = mysqli_real_escape_string($con, $qt_raw);
                                        if (strlen(trim($qt)) < 1) {
                                            continue;
                                        }
                                        $req = isset($question_required[(string)$idx]) ? 1 : 0;
                                        mysqli_query($con, "INSERT INTO job_questions (job_id, question_text, is_required) VALUES ('$new_job_id', '$qt', '$req')");
                                    }
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
                                    <form action="" method="post" enctype="multipart/form-data">
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
                                                <div class="mb-3">
                                                    <label class="form-label">Cover Image</label>
                                                    <input type="file" class="form-control" name="cover_image" accept="image/png,image/jpeg,image/webp">
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Application Questions</label>
                                                    <div id="jobQuestionsWrapper" class="vstack gap-2">
                                                        <div class="row g-2 align-items-start" data-index="0">
                                                            <div class="col-12 col-lg-9">
                                                                <input type="text" class="form-control" name="question_text[0]" placeholder="Question">
                                                            </div>
                                                            <div class="col-8 col-lg-2">
                                                                <div class="form-check mt-2">
                                                                    <input class="form-check-input" type="checkbox" id="question_required_0" name="question_required[0]" value="1">
                                                                    <label class="form-check-label" for="question_required_0">Required</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-4 col-lg-1 text-end">
                                                                <button type="button" class="btn btn-soft-danger btn-sm" onclick="removeJobQuestion(this)">X</button>
                                                            </div>
                                                        </div>

                                                        <div class="row g-2 align-items-start" data-index="1">
                                                            <div class="col-12 col-lg-9">
                                                                <input type="text" class="form-control" name="question_text[1]" placeholder="Question">
                                                            </div>
                                                            <div class="col-8 col-lg-2">
                                                                <div class="form-check mt-2">
                                                                    <input class="form-check-input" type="checkbox" id="question_required_1" name="question_required[1]" value="1">
                                                                    <label class="form-check-label" for="question_required_1">Required</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-4 col-lg-1 text-end">
                                                                <button type="button" class="btn btn-soft-danger btn-sm" onclick="removeJobQuestion(this)">X</button>
                                                            </div>
                                                        </div>

                                                        <div class="row g-2 align-items-start" data-index="2">
                                                            <div class="col-12 col-lg-9">
                                                                <input type="text" class="form-control" name="question_text[2]" placeholder="Question">
                                                            </div>
                                                            <div class="col-8 col-lg-2">
                                                                <div class="form-check mt-2">
                                                                    <input class="form-check-input" type="checkbox" id="question_required_2" name="question_required[2]" value="1">
                                                                    <label class="form-check-label" for="question_required_2">Required</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-4 col-lg-1 text-end">
                                                                <button type="button" class="btn btn-soft-danger btn-sm" onclick="removeJobQuestion(this)">X</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="mt-2">
                                                        <button type="button" class="btn btn-soft-primary btn-sm" onclick="addJobQuestion()">Add Question</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save" class="btn btn-primary">Add Job</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <script>
                                        function addJobQuestion() {
                                            var wrapper = document.getElementById('jobQuestionsWrapper');
                                            var rows = wrapper.querySelectorAll('[data-index]');
                                            var maxIndex = -1;
                                            rows.forEach(function (r) {
                                                var idx = parseInt(r.getAttribute('data-index') || '-1', 10);
                                                if (!isNaN(idx) && idx > maxIndex) {
                                                    maxIndex = idx;
                                                }
                                            });
                                            var newIndex = maxIndex + 1;

                                            var row = document.createElement('div');
                                            row.className = 'row g-2 align-items-start';
                                            row.setAttribute('data-index', newIndex);

                                            row.innerHTML = "\
                                                <div class='col-12 col-lg-9'>\
                                                    <input type='text' class='form-control' name='question_text[" + newIndex + "]' placeholder='Question'>\
                                                </div>\
                                                <div class='col-8 col-lg-2'>\
                                                    <div class='form-check mt-2'>\
                                                        <input class='form-check-input' type='checkbox' id='question_required_" + newIndex + "' name='question_required[" + newIndex + "]' value='1'>\
                                                        <label class='form-check-label' for='question_required_" + newIndex + "'>Required</label>\
                                                    </div>\
                                                </div>\
                                                <div class='col-4 col-lg-1 text-end'>\
                                                    <button type='button' class='btn btn-soft-danger btn-sm' onclick='removeJobQuestion(this)'>X</button>\
                                                </div>\
                                            ";

                                            wrapper.appendChild(row);
                                        }

                                        function removeJobQuestion(btn) {
                                            var row = btn.closest('[data-index]');
                                            if (row) {
                                                row.remove();
                                            }
                                        }
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <?php include"footer.php";?>
