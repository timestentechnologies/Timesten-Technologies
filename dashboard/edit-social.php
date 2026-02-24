<?php include"header.php";?>
<?php include"sidebar.php";?>

<?php
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$row = null;
if ($id > 0) {
    $rs = mysqli_query($con, "SELECT * FROM social WHERE id=$id LIMIT 1");
    $row = $rs ? mysqli_fetch_assoc($rs) : null;
}

$status = "OK";
$msg = "";
$errormsg = "";

if (isset($_POST['save']) && $id > 0) {
    $name = mysqli_real_escape_string($con, $_POST['name']);
    $fa = mysqli_real_escape_string($con, $_POST['fa']);
    $social_link = mysqli_real_escape_string($con, $_POST['social_link']);

    if (strlen($name) < 2) {
        $msg = $msg . "Social Network Name Must Contain A Char.<BR>";
        $status = "NOTOK";
    }
    if (strlen($fa) < 1) {
        $msg = $msg . "Fontawesome Must Be At Least 2 Char Long.<BR>";
        $status = "NOTOK";
    }
    if (strlen($social_link) < 5) {
        $msg = $msg . "Social Link Must Be More Than 6 Char Length.<BR>";
        $status = "NOTOK";
    }

    if ($status == "OK") {
        $qb = mysqli_query($con, "UPDATE social SET name='$name', fa='$fa', social_link='$social_link' WHERE id=$id LIMIT 1");
        if ($qb) {
            $errormsg = "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
                 Social Link has been updated successfully.
                  <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                  </div>
";
            $rs2 = mysqli_query($con, "SELECT * FROM social WHERE id=$id LIMIT 1");
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

$name_v = $row ? (string)$row['name'] : '';
$fa_v = $row ? (string)$row['fa'] : '';
$link_v = $row ? (string)$row['social_link'] : '';
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Edit Social</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="social-links.php">Social</a></li>
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
                                                <i class="fas fa-home"></i> Edit Social
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
                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Social Network</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="name" placeholder="Enter Name Of Social Network" value="<?php print htmlspecialchars($name_v); ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Social Fontawesome Code</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="fa" placeholder="fa-envelop-o" value="<?php print htmlspecialchars($fa_v); ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Social Link</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="social_link" placeholder="https://facebook.com/hillsoftsnetwork/" value="<?php print htmlspecialchars($link_v); ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Social</button>

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
