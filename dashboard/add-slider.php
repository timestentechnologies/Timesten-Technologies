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
                                <h4 class="mb-sm-0">Add Slider</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Slider</a></li>
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
                                                <i class="fas fa-home"></i> Add Slider
                                            </a>
                                        </li>


                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$slide_title = mysqli_real_escape_string($con,$_POST['slide_title']);
$slide_text = mysqli_real_escape_string($con,$_POST['slide_text']);
$highlight_words = mysqli_real_escape_string($con,$_POST['highlight_words']);

$text_align = isset($_POST['text_align']) ? $_POST['text_align'] : 'left';
$text_align = ($text_align === 'right') ? 'right' : 'left';
$text_align_sql = mysqli_real_escape_string($con, $text_align);

$show_cartoon = isset($_POST['show_cartoon']) ? 1 : 0;

 if ( strlen($slide_title) < 5 ){
$msg=$msg."Slider Title Must Be More Than 5 Char Length.<BR>";
$status= "NOTOK";}
 if ( strlen($slide_text) > 250 ){
$msg=$msg."Slider Text description Must Be Less Than 250 Char Length.<BR>";
$status= "NOTOK";}




$uploads_dir = 'uploads/slider';

        $tmp_name = $_FILES["ufile"]["tmp_name"];
        // basename() may prevent filesystem traversal attacks;
        // further validation/sanitation of the filename may be appropriate
        $name = basename($_FILES["ufile"]["name"]);
        $random_digit=rand(0000,9999);
        $new_file_name=$random_digit.$name;

        move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name");

if($status=="OK")
{
$has_align_col = false;
$col_rs = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'text_align'");
if ($col_rs && mysqli_num_rows($col_rs) > 0) {
    $has_align_col = true;
}

$has_cartoon_col = false;
$col_rs2 = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'show_cartoon'");
if ($col_rs2 && mysqli_num_rows($col_rs2) > 0) {
    $has_cartoon_col = true;
}

$has_highlight_col = false;
$col_rs3 = mysqli_query($con, "SHOW COLUMNS FROM slider LIKE 'highlight_words'");
if ($col_rs3 && mysqli_num_rows($col_rs3) > 0) {
    $has_highlight_col = true;
}

$highlight_sql = '';
if ($has_highlight_col) {
    $highlight_sql = ", highlight_words='$highlight_words'";
}

if ($has_align_col && $has_cartoon_col && $has_highlight_col) {
    $qb=mysqli_query($con,"INSERT INTO slider (slide_title, slide_text, ufile, text_align, show_cartoon, highlight_words) VALUES ('$slide_title', '$slide_text', '$new_file_name', '$text_align_sql', '$show_cartoon', '$highlight_words')");
} elseif ($has_align_col && $has_cartoon_col) {
    $qb=mysqli_query($con,"INSERT INTO slider (slide_title, slide_text, ufile, text_align, show_cartoon) VALUES ('$slide_title', '$slide_text', '$new_file_name', '$text_align_sql', '$show_cartoon')");
} elseif ($has_align_col && !$has_cartoon_col) {
    $qb=mysqli_query($con,"INSERT INTO slider (slide_title, slide_text, ufile, text_align) VALUES ('$slide_title', '$slide_text', '$new_file_name', '$text_align_sql')");
} elseif (!$has_align_col && $has_cartoon_col) {
    $qb=mysqli_query($con,"INSERT INTO slider (slide_title, slide_text, ufile, show_cartoon) VALUES ('$slide_title', '$slide_text', '$new_file_name', '$show_cartoon')");
} else {
    $qb=mysqli_query($con,"INSERT INTO slider (slide_title, slide_text,ufile) VALUES ('$slide_title', '$slide_text', '$new_file_name')");
}


		if($qb){
		    	$errormsg= "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
                 Slider has been added successfully.
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
if($_SERVER['REQUEST_METHOD'] == 'POST')
						{
						print $errormsg;
						}
   ?>
              <form action="" method="post" enctype="multipart/form-data">
                                                <div class="row">



   <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Slider Title</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="slide_title" placeholder="Enter Portfolio Title">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Slider Text</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="slide_text" placeholder="Enter Portfolio Title">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Photo</label>
                                                            <input type="file" class="form-control" id="firstnameInput" name="ufile" >
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Text Position</label>
                                                            <select class="form-select" name="text_align">
                                                                <option value="left" selected>Left</option>
                                                                <option value="right">Right</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" id="show_cartoon" name="show_cartoon" value="1" checked>
                                                                <label class="form-check-label" for="show_cartoon">Show cartoon on homepage</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="highlightWordsInput" class="form-label">Highlight Words (comma separated)</label>
                                                            <input type="text" class="form-control" id="highlightWordsInput" name="highlight_words" placeholder="e.g., digital, solutions, innovative">
                                                            <small class="text-muted">Words to highlight in warm orange color in the title</small>
                                                        </div>
                                                    </div>
                                                    <!--end col-->
                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Upload Slider</button>

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
