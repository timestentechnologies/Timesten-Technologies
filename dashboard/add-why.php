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
                                <h4 class="mb-sm-0">Add Why Choose Us</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Why Choose Us</a></li>
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
                                                <i class="fas fa-home"></i> Add Why Choose Us
                                            </a>
                                        </li>


                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$title = mysqli_real_escape_string($con,$_POST['title']);
$detail = mysqli_real_escape_string($con,$_POST['detail']);
$icon_class = mysqli_real_escape_string($con,$_POST['icon_class']);
$icon_type = mysqli_real_escape_string($con,$_POST['icon_type']);

// Handle icon upload
$icon_image = '';
if($icon_type == 'upload' && isset($_FILES['icon_image']) && $_FILES['icon_image']['name'] != '') {
    $target_dir = "uploads/whyicons/";
    if(!is_dir($target_dir)) {
        mkdir($target_dir, 0755, true);
    }
    $file_extension = strtolower(pathinfo($_FILES['icon_image']['name'], PATHINFO_EXTENSION));
    $allowed_extensions = array('jpg', 'jpeg', 'png', 'gif', 'svg');
    if(in_array($file_extension, $allowed_extensions)) {
        $new_filename = time() . '_' . basename($_FILES['icon_image']['name']);
        $target_file = $target_dir . $new_filename;
        if(move_uploaded_file($_FILES['icon_image']['tmp_name'], $target_file)) {
            $icon_image = $new_filename;
        }
    } else {
        $msg=$msg."Invalid file type. Only JPG, PNG, GIF, SVG allowed.<BR>";
        $status= "NOTOK";
    }
}

 if ( strlen($title) < 2 ){
$msg=$msg."Title Must Contain A Char.<BR>";
$status= "NOTOK";}
 if ( strlen($detail) > 500 ){
$msg=$msg."Detail Must Not Be More Than 500 Char Long.<BR>";
$status= "NOTOK";}



if($status=="OK")
{
$qb=mysqli_query($con,"INSERT INTO why_us (title, detail, icon_class, icon_type, icon_image) VALUES ('$title','$detail','$icon_class','$icon_type','$icon_image')");


		if($qb){
		    	$errormsg= "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
               Data added successfully.
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



   <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="titleInput" class="form-label"> Title</label>
                                                            <input type="text" class="form-control" id="titleInput" name="title" placeholder="Enter Title">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Icon Type</label>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="icon_type" id="iconTypeClass" value="class" checked onchange="toggleIconType()">
                                                                <label class="form-check-label" for="iconTypeClass">Font Awesome Icon</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="icon_type" id="iconTypeUpload" value="upload" onchange="toggleIconType()">
                                                                <label class="form-check-label" for="iconTypeUpload">Upload Icon Image</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12" id="iconClassSection">
                                                        <div class="mb-3">
                                                            <label for="iconClassInput" class="form-label">Icon Class (Font Awesome)</label>
                                                            <select class="form-control" id="iconClassInput" name="icon_class">
                                                                <option value="">Select an icon</option>
                                                                <option value="fas fa-check-circle">Check Circle</option>
                                                                <option value="fas fa-star">Star</option>
                                                                <option value="fas fa-heart">Heart</option>
                                                                <option value="fas fa-shield-alt">Shield</option>
                                                                <option value="fas fa-award">Award</option>
                                                                <option value="fas fa-trophy">Trophy</option>
                                                                <option value="fas fa-medal">Medal</option>
                                                                <option value="fas fa-gem">Gem</option>
                                                                <option value="fas fa-crown">Crown</option>
                                                                <option value="fas fa-thumbs-up">Thumbs Up</option>
                                                                <option value="fas fa-lightbulb">Lightbulb</option>
                                                                <option value="fas fa-rocket">Rocket</option>
                                                                <option value="fas fa-bolt">Bolt</option>
                                                                <option value="fas fa-fire">Fire</option>
                                                                <option value="fas fa-cog">Cog</option>
                                                                <option value="fas fa-wrench">Wrench</option>
                                                                <option value="fas fa-tools">Tools</option>
                                                                <option value="fas fa-headset">Headset</option>
                                                                <option value="fas fa-handshake">Handshake</option>
                                                                <option value="fas fa-users">Users</option>
                                                                <option value="fas fa-user-check">User Check</option>
                                                                <option value="fas fa-chart-line">Chart Line</option>
                                                                <option value="fas fa-chart-bar">Chart Bar</option>
                                                                <option value="fas fa-dollar-sign">Dollar Sign</option>
                                                                <option value="fas fa-percent">Percent</option>
                                                                <option value="fas fa-tag">Tag</option>
                                                                <option value="fas fa-tags">Tags</option>
                                                                <option value="fas fa-gift">Gift</option>
                                                                <option value="fas fa-box">Box</option>
                                                                <option value="fas fa-box-open">Box Open</option>
                                                                <option value="fas fa-truck">Truck</option>
                                                                <option value="fas fa-shipping-fast">Shipping Fast</option>
                                                                <option value="fas fa-clock">Clock</option>
                                                                <option value="fas fa-calendar-check">Calendar Check</option>
                                                                <option value="fas fa-phone">Phone</option>
                                                                <option value="fas fa-envelope">Envelope</option>
                                                                <option value="fas fa-comments">Comments</option>
                                                                <option value="fas fa-comment-dots">Comment Dots</option>
                                                                <option value="fas fa-smile">Smile</option>
                                                                <option value="fas fa-globe">Globe</option>
                                                                <option value="fas fa-wifi">Wifi</option>
                                                                <option value="fas fa-lock">Lock</option>
                                                                <option value="fas fa-unlock">Unlock</option>
                                                                <option value="fas fa-key">Key</option>
                                                                <option value="fas fa-database">Database</option>
                                                                <option value="fas fa-server">Server</option>
                                                                <option value="fas fa-cloud">Cloud</option>
                                                                <option value="fas fa-laptop">Laptop</option>
                                                                <option value="fas fa-desktop">Desktop</option>
                                                                <option value="fas fa-mobile-alt">Mobile</option>
                                                                <option value="fas fa-tablet-alt">Tablet</option>
                                                                <option value="fas fa-camera">Camera</option>
                                                                <option value="fas fa-video">Video</option>
                                                                <option value="fas fa-microphone">Microphone</option>
                                                                <option value="fas fa-music">Music</option>
                                                                <option value="fas fa-film">Film</option>
                                                                <option value="fas fa-image">Image</option>
                                                                <option value="fas fa-file">File</option>
                                                                <option value="fas fa-folder">Folder</option>
                                                                <option value="fas fa-book">Book</option>
                                                                <option value="fas fa-bookmark">Bookmark</option>
                                                                <option value="fas fa-flag">Flag</option>
                                                                <option value="fas fa-map-marker-alt">Map Marker</option>
                                                                <option value="fas fa-home">Home</option>
                                                                <option value="fas fa-building">Building</option>
                                                                <option value="fas fa-city">City</option>
                                                            </select>
                                                            <small class="form-text text-muted">Choose from Font Awesome icons</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12" id="iconUploadSection" style="display:none;">
                                                        <div class="mb-3">
                                                            <label for="iconImageInput" class="form-label">Upload Icon Image</label>
                                                            <input type="file" class="form-control" id="iconImageInput" name="icon_image" accept=".jpg,.jpeg,.png,.gif,.svg">
                                                            <small class="form-text text-muted">Upload JPG, PNG, GIF, or SVG icon (max 2MB)</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="detailInput" class="form-label">Detail</label>
                                                            <textarea class="form-control" id="detailInput" name="detail" rows="3"></textarea>
                                                        </div>
                                                    </div>

                                                    <!--end col-->
                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Add Why Us</button>

                                                        </div>
                                                    </div>
                                                    <!--end col-->
                                                </div>
                                                <!--end row-->
                                            </form>
                                        </div>
                                        <!--end tab-pane-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end col-->
                    </div>

<script>
function toggleIconType() {
    var iconType = document.querySelector('input[name="icon_type"]:checked').value;
    if(iconType == 'upload') {
        document.getElementById('iconClassSection').style.display = 'none';
        document.getElementById('iconUploadSection').style.display = 'block';
    } else {
        document.getElementById('iconClassSection').style.display = 'block';
        document.getElementById('iconUploadSection').style.display = 'none';
    }
}
</script>

                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <?php include"footer.php";?>
