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
    $salary = isset($_POST['salary']) ? mysqli_real_escape_string($con, $_POST['salary']) : '';
    $deadline = mysqli_real_escape_string($con,$_POST['deadline']);
    $job_status = mysqli_real_escape_string($con,$_POST['status']);

    $cover_image = "";
    $has_cover_col = false;
    $col_rs = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'cover_image'");
    if ($col_rs && mysqli_num_rows($col_rs) > 0) {
        $has_cover_col = true;
    }

    if ($has_cover_col && isset($_FILES['cover_image']) && $_FILES['cover_image']['error'] === UPLOAD_ERR_OK) {
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
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Cover image must be a valid image file.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $mime = isset($img_info['mime']) ? $img_info['mime'] : '';
            $allowed_mimes = ['image/jpeg', 'image/png', 'image/webp'];
            if (!in_array($mime, $allowed_mimes)) {
                $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Cover image must be JPG, PNG, or WEBP.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                $cover_image = "";
            } else {
                if (!move_uploaded_file($tmp_name, $uploads_dir . '/' . $cover_image)) {
                    $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Cover image upload failed.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                    $cover_image = "";
                }
            }
        }
    }

    $existing_questions = isset($_POST['existing_question']) && is_array($_POST['existing_question']) ? $_POST['existing_question'] : array();
    $existing_required = isset($_POST['existing_required']) && is_array($_POST['existing_required']) ? $_POST['existing_required'] : array();
    $delete_existing = isset($_POST['delete_existing']) && is_array($_POST['delete_existing']) ? $_POST['delete_existing'] : array();

    $new_questions = isset($_POST['new_question_text']) && is_array($_POST['new_question_text']) ? $_POST['new_question_text'] : array();
    $new_required = isset($_POST['new_question_required']) && is_array($_POST['new_question_required']) ? $_POST['new_question_required'] : array();

    $cover_update_sql = "";
    if ($has_cover_col && strlen($cover_image) > 0) {
        $cover_image_sql = mysqli_real_escape_string($con, $cover_image);
        $cover_update_sql = ", cover_image='$cover_image_sql'";
    }

    $salary_update_sql = "";
    $has_salary_col = false;
    $col_rs_salary = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'salary'");
    if ($col_rs_salary && mysqli_num_rows($col_rs_salary) > 0) {
        $has_salary_col = true;
    }
    if ($has_salary_col) {
        $salary_update_sql = ", salary='$salary'";
    }

    $qb = mysqli_query($con, "UPDATE jobs SET job_title='$job_title', short_desc='$short_desc', job_desc='$job_desc', requirements='$requirements', location='$location', job_type='$job_type'$salary_update_sql, deadline='$deadline', status='$job_status'$cover_update_sql WHERE id='$todo'");

    if($qb){
        foreach ($existing_questions as $qid => $qtext_raw) {
            $qid_clean = mysqli_real_escape_string($con, $qid);

            if (isset($delete_existing[(string)$qid])) {
                mysqli_query($con, "DELETE FROM job_questions WHERE id='$qid_clean' AND job_id='$todo'");
                continue;
            }

            $qtext = mysqli_real_escape_string($con, $qtext_raw);
            if (strlen(trim($qtext)) < 1) {
                continue;
            }

            $req = isset($existing_required[(string)$qid]) ? 1 : 0;
            mysqli_query($con, "UPDATE job_questions SET question_text='$qtext', is_required='$req' WHERE id='$qid_clean' AND job_id='$todo'");
        }

        foreach ($new_questions as $idx => $qtext_raw) {
            $qtext = mysqli_real_escape_string($con, $qtext_raw);
            if (strlen(trim($qtext)) < 1) {
                continue;
            }
            $req = isset($new_required[(string)$idx]) ? 1 : 0;
            mysqli_query($con, "INSERT INTO job_questions (job_id, question_text, is_required) VALUES ('$todo', '$qtext', '$req')");
        }

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
                                    <form action="" method="post" enctype="multipart/form-data">
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
                                                    <label class="form-label">Salary</label>
                                                    <input type="text" class="form-control" name="salary" value="<?php echo isset($row['salary']) ? htmlspecialchars($row['salary']) : ''; ?>" placeholder="Amount / Commission / Voluntary / Confidential">
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
                                                <div class="mb-3">
                                                    <label class="form-label">Cover Image</label>
                                                    <input type="file" class="form-control" name="cover_image" accept="image/png,image/jpeg,image/webp">
                                                    <?php if (isset($row['cover_image']) && strlen(trim($row['cover_image'])) > 0) { ?>
                                                        <div class="mt-2">
                                                            <img src="uploads/jobs/<?php echo htmlspecialchars($row['cover_image']); ?>" alt="" style="max-width: 180px; height: auto; border-radius: 8px;">
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Application Questions</label>

                                                    <div class="table-responsive mb-3">
                                                        <table class="table table-bordered align-middle">
                                                            <thead>
                                                                <tr>
                                                                    <th>Question</th>
                                                                    <th style="width: 120px;">Required</th>
                                                                    <th style="width: 120px;">Delete</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php
                                                                    $qq = mysqli_query($con, "SELECT * FROM job_questions WHERE job_id='$todo' ORDER BY id ASC");
                                                                    while($qr = mysqli_fetch_assoc($qq)){
                                                                        $qid = $qr['id'];
                                                                        $qt = $qr['question_text'];
                                                                        $req_checked = $qr['is_required'] == 1 ? 'checked' : '';
                                                                        print "<tr>
                                                                            <td><input type='text' class='form-control' name='existing_question[$qid]' value=\"$qt\"></td>
                                                                            <td class='text-center'>
                                                                                <input class='form-check-input' type='checkbox' name='existing_required[$qid]' value='1' $req_checked>
                                                                            </td>
                                                                            <td class='text-center'>
                                                                                <input class='form-check-input' type='checkbox' name='delete_existing[$qid]' value='1'>
                                                                            </td>
                                                                        </tr>";
                                                                    }
                                                                ?>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div id="newQuestionsWrapper" class="vstack gap-2">
                                                        <div class="row g-2 align-items-start" data-new-index="0">
                                                            <div class="col-12 col-lg-9">
                                                                <input type="text" class="form-control" name="new_question_text[0]" placeholder="New question">
                                                            </div>
                                                            <div class="col-8 col-lg-2">
                                                                <div class="form-check mt-2">
                                                                    <input class="form-check-input" type="checkbox" id="new_question_required_0" name="new_question_required[0]" value="1">
                                                                    <label class="form-check-label" for="new_question_required_0">Required</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-4 col-lg-1 text-end">
                                                                <button type="button" class="btn btn-soft-danger btn-sm" onclick="removeNewQuestion(this)">X</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="mt-2">
                                                        <button type="button" class="btn btn-soft-primary btn-sm" onclick="addNewQuestion()">Add New Question</button>
                                                    </div>
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

                                    <script>
                                        function addNewQuestion() {
                                            var wrapper = document.getElementById('newQuestionsWrapper');
                                            var rows = wrapper.querySelectorAll('[data-new-index]');
                                            var maxIndex = -1;
                                            rows.forEach(function (r) {
                                                var idx = parseInt(r.getAttribute('data-new-index') || '-1', 10);
                                                if (!isNaN(idx) && idx > maxIndex) {
                                                    maxIndex = idx;
                                                }
                                            });
                                            var newIndex = maxIndex + 1;

                                            var row = document.createElement('div');
                                            row.className = 'row g-2 align-items-start';
                                            row.setAttribute('data-new-index', newIndex);

                                            row.innerHTML = "\
                                                <div class='col-12 col-lg-9'>\
                                                    <input type='text' class='form-control' name='new_question_text[" + newIndex + "]' placeholder='New question'>\
                                                </div>\
                                                <div class='col-8 col-lg-2'>\
                                                    <div class='form-check mt-2'>\
                                                        <input class='form-check-input' type='checkbox' id='new_question_required_" + newIndex + "' name='new_question_required[" + newIndex + "]' value='1'>\
                                                        <label class='form-check-label' for='new_question_required_" + newIndex + "'>Required</label>\
                                                    </div>\
                                                </div>\
                                                <div class='col-4 col-lg-1 text-end'>\
                                                    <button type='button' class='btn btn-soft-danger btn-sm' onclick='removeNewQuestion(this)'>X</button>\
                                                </div>\
                                            ";

                                            wrapper.appendChild(row);
                                        }

                                        function removeNewQuestion(btn) {
                                            var row = btn.closest('[data-new-index]');
                                            if (row) {
                                                row.remove();
                                            }
                                        }
                                    </script>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <?php include"footer.php";?>
