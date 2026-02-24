<?php include"header.php";?>
<?php include"sidebar.php";?>

<?php
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$row = null;
if ($id > 0) {
    $rs = mysqli_query($con, "SELECT * FROM why_us WHERE id=$id LIMIT 1");
    $row = $rs ? mysqli_fetch_assoc($rs) : null;
}

$status = "OK";
$msg = "";
$errormsg = "";

if (isset($_POST['save']) && $id > 0) {
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $detail = mysqli_real_escape_string($con, $_POST['detail']);

    if (strlen($title) < 2) {
        $msg = $msg . "Title Must Contain A Char.<BR>";
        $status = "NOTOK";
    }
    if (strlen($detail) > 500) {
        $msg = $msg . "Detail Must Not Be More Than 500 Char Long.<BR>";
        $status = "NOTOK";
    }

    if ($status == "OK") {
        $qb = mysqli_query($con, "UPDATE why_us SET title='$title', detail='$detail' WHERE id=$id LIMIT 1");
        if ($qb) {
            $errormsg = "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
               Data updated successfully.
                  <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                  </div>
";
            $rs2 = mysqli_query($con, "SELECT * FROM why_us WHERE id=$id LIMIT 1");
            $row = $rs2 ? mysqli_fetch_assoc($rs2) : $row;
        }
    } elseif ($status !== "OK") {
        $errormsg = "
<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                     " . $msg . " <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> </div>";
    } else {
        $errormsg = "
      <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                 Some Technical Glitch Is There. Please Try Again Later Or Ask Admin For Help.
                 <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                 </div>";
    }
}

$title_v = $row ? (string)$row['title'] : '';
$detail_v = $row ? (string)$row['detail'] : '';
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Edit Why Choose Us</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="why-us.php">Why Choose Us</a></li>
                                        <li class="breadcrumb-item active">Edit</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-3">
                                <div class="card-header">
                                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">
                                                <i class="fas fa-home"></i> Edit Why Choose Us
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="card-body p-4">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="personalDetails" role="tabpanel">

                                        <?php
                                        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                                            print $errormsg;
                                        }
                                        if ($id < 1 || !$row) {
                                            print "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Record not found.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                                        }
                                        ?>

              <form action="" method="post" enctype="multipart/form-data">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Title</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="title" placeholder="Enter Title" value="<?php print htmlspecialchars($title_v); ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Detail</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="detail" rows="3"><?php print htmlspecialchars($detail_v); ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Why Us</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <?php include"footer.php";?>
