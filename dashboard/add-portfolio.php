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
                                <h4 class="mb-sm-0">Add Portfolio</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Portfolio</a></li>
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
                                                <i class="fas fa-home"></i> Add Portfolio
                                            </a>
                                        </li>


                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$port_title = mysqli_real_escape_string($con,$_POST['port_title']);
$port_desc = mysqli_real_escape_string($con,$_POST['port_desc']);
$port_detail = mysqli_real_escape_string($con,$_POST['port_detail']);
$port_url = mysqli_real_escape_string($con,$_POST['port_url']);
$tags = mysqli_real_escape_string($con,$_POST['tags']);
$tag_colors = mysqli_real_escape_string($con,$_POST['tag_colors']);
$display_order = isset($_POST['display_order']) && is_numeric($_POST['display_order']) ? intval($_POST['display_order']) : 0;

 if ( strlen($port_title) < 5 ){
$msg=$msg."Portfolio Title Must Be More Than 5 Char Length.<BR>";
$status= "NOTOK";}
 if ( strlen($port_desc) > 150 ){
$msg=$msg."Portfolio description Must Be Less Than 150 Char Length.<BR>";
$status= "NOTOK";}

if ( strlen($port_detail) < 15 ){
  $msg=$msg."Portfolio Detail Must Be More Than 15 Char Length.<BR>";
  $status= "NOTOK";}

 if ( strlen($port_url) > 255 ){
   $msg=$msg."Portfolio URL Must Be Less Than 255 Char Length.<BR>";
   $status= "NOTOK";}
 if ( strlen($tags) > 255 ){
   $msg=$msg."Tags Must Be Less Than 255 Char Length.<BR>";
   $status= "NOTOK";}

$uploads_dir = 'uploads/portfolio';

        $tmp_name = $_FILES["ufile"]["tmp_name"];
        // basename() may prevent filesystem traversal attacks;
        // further validation/sanitation of the filename may be appropriate
        $name = basename($_FILES["ufile"]["name"]);
        $random_digit=rand(0000,9999);
        $new_file_name=$random_digit.$name;

        move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name");

if($status=="OK")
{
$qb=mysqli_query($con,"INSERT INTO portfolio (port_title, port_desc, port_detail, port_url, ufile, tags, tag_colors, display_order) VALUES ('$port_title', '$port_desc', '$port_detail', '$port_url', '$new_file_name', '$tags', '$tag_colors', '$display_order')");


		if($qb){
			$portfolio_id = mysqli_insert_id($con);

			$has_portfolio_media_table = false;
			$tm_rs = mysqli_query($con, "SHOW TABLES LIKE 'portfolio_media'");
			if ($tm_rs && mysqli_num_rows($tm_rs) > 0) {
				$has_portfolio_media_table = true;
			}

			if ($has_portfolio_media_table && isset($_FILES['media_files']) && isset($_FILES['media_files']['name']) && is_array($_FILES['media_files']['name'])) {
				$uploads_dir_extra = 'uploads/portfolio';
				$cnt = count($_FILES['media_files']['name']);
				for ($i = 0; $i < $cnt; $i++) {
					if (!isset($_FILES['media_files']['error'][$i]) || $_FILES['media_files']['error'][$i] !== UPLOAD_ERR_OK) {
						continue;
					}
					$tmp_name_extra = $_FILES['media_files']['tmp_name'][$i];
					$original_name_extra = basename($_FILES['media_files']['name'][$i]);
					$random_digit_extra = rand(1000, 9999);
					$safe_name_extra = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name_extra);
					$new_file_extra = $random_digit_extra . '_' . $safe_name_extra;

					$file_type_extra = mime_content_type($tmp_name_extra);
					$media_type = 'document';
					if (strpos($file_type_extra, 'image/') === 0) {
						$media_type = 'image';
					} elseif (strpos($file_type_extra, 'video/') === 0) {
						$media_type = 'video';
					}

					if (move_uploaded_file($tmp_name_extra, "$uploads_dir_extra/$new_file_extra")) {
						$fp = mysqli_real_escape_string($con, $new_file_extra);
						$mt = mysqli_real_escape_string($con, $media_type);
						mysqli_query($con, "INSERT INTO portfolio_media (portfolio_id, file_path, media_type, created_at) VALUES ('$portfolio_id', '$fp', '$mt', NOW())");
					}
				}
			}

		    	$errormsg= "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
                  Portfolio has been added successfully.
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
                                                            <label for="firstnameInput" class="form-label"> Portfolio Title</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="port_title" placeholder="Enter Portfolio Title">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Short Description</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="port_desc" rows="2"></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Portfolio Detail</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="port_detail" rows="3"></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="portUrlInput" class="form-label">Website URL</label>
                                                            <input type="url" class="form-control" id="portUrlInput" name="port_url" placeholder="https://example.com">
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
                                                            <label class="form-label">Add More Media (images / video / documents)</label>
                                                            <input type="file" class="form-control" name="media_files[]" multiple>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="tagsInput" class="form-label">Tags <small class="text-muted">(comma separated, e.g. Web Design, SEO, Marketing)</small></label>
                                                            <input type="text" class="form-control" id="tagsInput" name="tags" placeholder="Enter tags separated by commas" onchange="updateTagColors()">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="displayOrderInput" class="form-label">Display Order <small class="text-muted">(lower number shows first)</small></label>
                                                            <input type="number" class="form-control" id="displayOrderInput" name="display_order" value="0" min="0">
                                                        </div>
                                                    </div>

                                                    <!-- Tag Color Selection -->
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Tag Colors <small class="text-muted">(select color for each tag)</small></label>
                                                            <div id="tagColorContainer" class="d-flex flex-wrap gap-3">
                                                                <!-- Color selectors will be dynamically added here -->
                                                            </div>
                                                            <input type="hidden" id="tagColorsInput" name="tag_colors" value="">
                                                        </div>
                                                    </div>
                                                    <!--end col-->
                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Add Portfolio</button>

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
