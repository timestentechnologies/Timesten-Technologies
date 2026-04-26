<?php
include"header.php";
include"sidebar.php";

$todo = mysqli_real_escape_string($con, $_GET['id']);
$query = mysqli_query($con, "SELECT * FROM slider WHERE id='$todo' LIMIT 1");
$row = $query ? mysqli_fetch_assoc($query) : null;

$errormsg = "";

if (isset($_POST['save']) && $row) {
    $slide_title = mysqli_real_escape_string($con, $_POST['slide_title']);
    $slide_text = mysqli_real_escape_string($con, $_POST['slide_text']);
    $highlight_words = mysqli_real_escape_string($con, $_POST['highlight_words']);
    $highlight_color = mysqli_real_escape_string($con, $_POST['highlight_color']);
    $typing_effect = isset($_POST['typing_effect']) ? 1 : 0;

    $text_align = isset($_POST['text_align']) ? $_POST['text_align'] : 'left';
    $text_align = ($text_align === 'right') ? 'right' : 'left';
    $text_align_sql = mysqli_real_escape_string($con, $text_align);

    $show_cartoon = isset($_POST['show_cartoon']) ? 1 : 0;

    $status = "OK";
    $msg = "";

    if (strlen($slide_title) < 5) {
        $msg .= "Slider Title Must Be More Than 5 Char Length.<BR>";
        $status = "NOTOK";
    }
    if (strlen($slide_text) > 250) {
        $msg .= "Slider Text description Must Be Less Than 250 Char Length.<BR>";
        $status = "NOTOK";
    }

    $new_file_name = "";
    if (isset($_FILES['ufile']) && $_FILES['ufile']['error'] === UPLOAD_ERR_OK) {
        $uploads_dir = 'uploads/slider';
        if (!is_dir($uploads_dir)) {
            @mkdir($uploads_dir, 0755, true);
        }

        $tmp_name = $_FILES["ufile"]["tmp_name"];
        $name = basename($_FILES["ufile"]["name"]);
        $random_digit = rand(0000, 9999);
        $new_file_name = $random_digit . $name;

        if (!move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name")) {
            $msg .= "Failed to upload image.<BR>";
            $status = "NOTOK";
            $new_file_name = "";
        }
    }

    if ($status === "OK") {
        $file_sql = "";
        if (strlen($new_file_name) > 0) {
            $file_esc = mysqli_real_escape_string($con, $new_file_name);
            $file_sql = ", ufile='$file_esc'";
        }

        $align_sql = "";
        $col_rs = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'text_align'");
        if ($col_rs && mysqli_num_rows($col_rs) > 0) {
            $align_sql = ", text_align='$text_align_sql'";
        }

        $cartoon_sql = "";
        $col_rs2 = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'show_cartoon'");
        if ($col_rs2 && mysqli_num_rows($col_rs2) > 0) {
            $cartoon_sql = ", show_cartoon='$show_cartoon'";
        }

        $highlight_sql = "";
        $col_rs3 = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'highlight_words'");
        if ($col_rs3 && mysqli_num_rows($col_rs3) > 0) {
            $highlight_sql = ", highlight_words='$highlight_words'";
        }

        $highlight_color_sql = "";
        $col_rs4 = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'highlight_color'");
        if ($col_rs4 && mysqli_num_rows($col_rs4) > 0) {
            $highlight_color_sql = ", highlight_color='$highlight_color'";
        }

        $typing_effect_sql = "";
        $col_rs5 = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'typing_effect'");
        if ($col_rs5 && mysqli_num_rows($col_rs5) > 0) {
            $typing_effect_sql = ", typing_effect='$typing_effect'";
        }

        $qb = mysqli_query($con, "UPDATE slider SET slide_title='$slide_title', slide_text='$slide_text'$file_sql$align_sql$cartoon_sql$highlight_sql$highlight_color_sql$typing_effect_sql WHERE id='$todo'");
        if ($qb) {
            $errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Slider updated successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            $query = mysqli_query($con, "SELECT * FROM slider WHERE id='$todo' LIMIT 1");
            $row = $query ? mysqli_fetch_assoc($query) : $row;
        } else {
            $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Failed to update slider.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    } else {
        $errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>" . $msg . "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
}
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Edit Slider</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript: void(0);">Slider</a></li>
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
                                <div class="alert alert-danger">Slide not found.</div>
                                <a href="slider" class="btn btn-soft-secondary">Back</a>
                            <?php } else { ?>
                                <?php $text_align_db = isset($row['text_align']) && $row['text_align'] === 'right' ? 'right' : 'left'; ?>
                                <?php $show_cartoon_db = !isset($row['show_cartoon']) ? 1 : (int)$row['show_cartoon']; ?>
                                <?php $highlight_words_db = isset($row['highlight_words']) ? $row['highlight_words'] : ''; ?>
                                <?php $highlight_color_db = isset($row['highlight_color']) ? $row['highlight_color'] : '#ff8c00'; ?>
                                <?php $typing_effect_db = isset($row['typing_effect']) ? (int)$row['typing_effect'] : 0; ?>
                                <form action="" method="post" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Slider Title</label>
                                                <input type="text" class="form-control" name="slide_title" value="<?php echo htmlspecialchars($row['slide_title']); ?>" required>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Slider Text</label>
                                                <input type="text" class="form-control" name="slide_text" value="<?php echo htmlspecialchars($row['slide_text']); ?>">
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Photo (optional)</label>
                                                <input type="file" class="form-control" name="ufile">
                                                <?php if (!empty($row['ufile'])) { ?>
                                                    <div class="mt-2">
                                                        <img src="uploads/slider/<?php echo htmlspecialchars($row['ufile']); ?>" alt="" style="max-height:150px; border-radius: 8px;">
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Text Position</label>
                                                <select class="form-select" name="text_align">
                                                    <option value="left" <?php if ($text_align_db === 'left') { echo 'selected'; } ?>>Left</option>
                                                    <option value="right" <?php if ($text_align_db === 'right') { echo 'selected'; } ?>>Right</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="show_cartoon" name="show_cartoon" value="1" <?php if (!empty($show_cartoon_db)) { echo 'checked'; } ?>>
                                                    <label class="form-check-label" for="show_cartoon">Show cartoon on homepage</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Highlight Words (comma separated)</label>
                                                <input type="text" class="form-control" name="highlight_words" value="<?php echo htmlspecialchars($highlight_words_db); ?>" placeholder="e.g., digital, solutions, innovative">
                                                <small class="text-muted">Words to highlight in the title</small>
                                            </div>
                                        </div>

                                        <div class="col-lg-3">
                                            <div class="mb-3">
                                                <label class="form-label">Highlight Color</label>
                                                <input type="color" class="form-control form-control-color" name="highlight_color" value="<?php echo htmlspecialchars($highlight_color_db); ?>" title="Choose highlight color">
                                                <small class="text-muted">Default: warm orange</small>
                                            </div>
                                        </div>

                                        <div class="col-lg-3">
                                            <div class="mb-3">
                                                <div class="form-check mt-4">
                                                    <input class="form-check-input" type="checkbox" id="typingEffect" name="typing_effect" value="1" <?php if ($typing_effect_db) { echo 'checked'; } ?>>
                                                    <label class="form-check-label" for="typingEffect">Enable Typing Effect</label>
                                                </div>
                                                <small class="text-muted">Animated typing for highlighted words</small>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="hstack gap-2 justify-content-end">
                                                <button type="submit" name="save" class="btn btn-primary">Update Slider</button>
                                                <a href="slider" class="btn btn-soft-secondary">Back</a>
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
    <?php include"footer.php"; ?>
