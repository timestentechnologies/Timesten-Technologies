<?php include"header.php";?>
<?php include"sidebar.php";?>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Update Logo</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Logo</a></li>
                                        <li class="breadcrumb-item active">Add</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- end page title -->


                    <div class="row">

                        <!--end col-->
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-header">
                                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">
                                                <i class="fas fa-home"></i> Update Logo
                                            </a>
                                        </li>


                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){

$uploads_dir = 'uploads/logo';

$logo_rs = mysqli_query($con, "SELECT xfile, ufile FROM logo WHERE id=1 LIMIT 1");
$logo_row = $logo_rs ? mysqli_fetch_assoc($logo_rs) : null;
$current_xfile = $logo_row && isset($logo_row['xfile']) ? $logo_row['xfile'] : '';
$current_ufile = $logo_row && isset($logo_row['ufile']) ? $logo_row['ufile'] : '';

$has_sticky_col = false;
$col_rs3 = mysqli_query($con, "SHOW COLUMNS FROM logo LIKE 'sticky_ufile'");
if ($col_rs3 && mysqli_num_rows($col_rs3) > 0) {
    $has_sticky_col = true;
}

$current_sticky_ufile = '';
if ($has_sticky_col) {
    $logo_rs2 = mysqli_query($con, "SELECT sticky_ufile FROM logo WHERE id=1 LIMIT 1");
    $logo_row2 = $logo_rs2 ? mysqli_fetch_assoc($logo_rs2) : null;
    $current_sticky_ufile = $logo_row2 && isset($logo_row2['sticky_ufile']) ? $logo_row2['sticky_ufile'] : '';
}

$new_file = '';
$new_file_name = '';
$new_sticky_file_name = '';

if (isset($_FILES['xfile']) && $_FILES['xfile']['error'] === UPLOAD_ERR_OK) {
    $tmp_name = $_FILES["xfile"]["tmp_name"];
    $name = basename($_FILES["xfile"]["name"]);
    $random_digit = rand(0000,9999);
    $new_file = $random_digit . $name;
    if (!move_uploaded_file($tmp_name, "$uploads_dir/$new_file")) {
        $status = "NOTOK";
        $msg .= "Failed to upload favicon.<BR>";
        $new_file = '';
    }
}

if ($has_sticky_col && isset($_FILES['sticky_ufile']) && $_FILES['sticky_ufile']['error'] === UPLOAD_ERR_OK) {
    $tmp_name = $_FILES["sticky_ufile"]["tmp_name"];
    $name = basename($_FILES["sticky_ufile"]["name"]);
    $random_digit = rand(0000,9999);
    $new_sticky_file_name = $random_digit . $name;
    if (!move_uploaded_file($tmp_name, "$uploads_dir/$new_sticky_file_name")) {
        $status = "NOTOK";
        $msg .= "Failed to upload sticky logo.<BR>";
        $new_sticky_file_name = '';
    }
}

if (isset($_FILES['ufile']) && $_FILES['ufile']['error'] === UPLOAD_ERR_OK) {
    $tmp_name = $_FILES["ufile"]["tmp_name"];
    $name = basename($_FILES["ufile"]["name"]);
    $random_digit = rand(0000,9999);
    $new_file_name = $random_digit . $name;
    if (!move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name")) {
        $status = "NOTOK";
        $msg .= "Failed to upload logo.<BR>";
        $new_file_name = '';
    }
}

if($status=="OK")
{
  $xfile_to_save = (strlen($new_file) > 0) ? $new_file : $current_xfile;
  $ufile_to_save = (strlen($new_file_name) > 0) ? $new_file_name : $current_ufile;
  $sticky_to_save = (strlen($new_sticky_file_name) > 0) ? $new_sticky_file_name : $current_sticky_ufile;

  $xfile_to_save = mysqli_real_escape_string($con, $xfile_to_save);
  $ufile_to_save = mysqli_real_escape_string($con, $ufile_to_save);

  if ($has_sticky_col) {
      $sticky_to_save = mysqli_real_escape_string($con, $sticky_to_save);
      $qb=mysqli_query($con,"update logo set xfile='$xfile_to_save', ufile='$ufile_to_save', sticky_ufile='$sticky_to_save' where id=1");
  } else {
      $qb=mysqli_query($con,"update logo set xfile='$xfile_to_save', ufile='$ufile_to_save' where id=1");
  }

		if($qb){
		    	$errormsg= "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
                 Data updated successfully.
                  <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                  </div>
 "; //printing error if found in validation

		}
	}

        elseif ($status!=="OK") {
            $errormsg= "
<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                     ".$msg." <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> </div>"; //printing error if found in validation


    }
    else{
			$errormsg= "
      <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                 Some Technical Glitch Is There. Please Try Again Later Or Ask Admin For Help.
                 <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                 </div>"; //printing error if found in validation


		}
           }
           ?>



                                <div class="card-body p-4">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="personalDetails" role="tabpanel">
                                        <?php
					 $query="SELECT * FROM  siteconfig where id=1 ";
 $result = mysqli_query($con,$query);
$i=0;
while($row = mysqli_fetch_array($result))
{
	$site_url="$row[site_url]";
}
  ?>
                                     <?php
					 $query="SELECT * FROM  logo where id=1";
 $result = mysqli_query($con,$query);
$i=0;
while($row = mysqli_fetch_array($result))
{
	$xfile="$row[xfile]";
	$ufile="$row[ufile]";
	$sticky_ufile = isset($row['sticky_ufile']) ? $row['sticky_ufile'] : '';
}
  ?>


                                        <?php
if($_SERVER['REQUEST_METHOD'] == 'POST')
						{
						print $errormsg;
						}
   ?>
              <form action="" method="post" enctype="multipart/form-data">
                                                <div class="row">


                                                    <div class="col-lg-6">
                                                     <span>Current Favicon: </span> <img src="uploads/logo/<?php print $xfile; ?>" alt="img" style="max-height:120px;">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Favicon</label>
                                                            <input type="file" class="form-control" id="firstnameInput" name="xfile">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                    <span>Current Logo: </span> <img src="uploads/logo/<?php print $ufile; ?>" alt="img" style="max-height:120px;">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Logo</label>
                                                            <input type="file" class="form-control" id="firstnameInput" name="ufile">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                    <span>Current Sticky Logo: </span>
                                                    <?php if (isset($sticky_ufile) && strlen(trim($sticky_ufile)) > 0) { ?>
                                                        <img src="uploads/logo/<?php print $sticky_ufile; ?>" alt="img" style="max-height:120px;">
                                                    <?php } ?>
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Sticky (White Header) Logo</label>
                                                            <input type="file" class="form-control" id="firstnameInput" name="sticky_ufile">
                                                        </div>
                                                    </div>
                                                    <!--end col-->
                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Logo</button>

                                                        </div>
                                                    </div>
                                                    <!--end col-->
                                                </div>
                                                <!--end row-->
                                            </form>
                                        </div>
                                        <!--end tab-pane-->

                                        <!--end tab-pane-->

                                        <!--end tab-pane-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end col-->
                    </div>


                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <?php include"footer.php";?>
