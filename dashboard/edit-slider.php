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

        $qb = mysqli_query($con, "UPDATE slider SET slide_title='$slide_title', slide_text='$slide_text'$file_sql WHERE id='$todo'");
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
