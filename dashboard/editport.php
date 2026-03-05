<?php
include"header.php";
$todo=  mysqli_real_escape_string($con,$_GET['id']);
include"sidebar.php";

?>

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
                                <h4 class="mb-sm-0">Edit Portfolio</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">User</a></li>
                                        <li class="breadcrumb-item active">Portfolio</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- end page title -->
                    <?php
 $query="SELECT * FROM  portfolio where id='$todo' ";
 $result = mysqli_query($con,$query);
$i=0;
while($row = mysqli_fetch_array($result))
{
 $id="$row[id]";
 $port_title="$row[port_title]";
 $port_desc="$row[port_desc]";
 $port_detail="$row[port_detail]";
 $port_url="$row[port_url]";
 $current_image="$row[ufile]";
}
?>

                    <div class="row">

                        <!--end col-->
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-header">
                                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">
                                                <i class="fas fa-home"></i> Edit Portfolio
                                            </a>
                                        </li>
                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$service_title = mysqli_real_escape_string($con,$_POST['service_title']);
$service_desc = mysqli_real_escape_string($con,$_POST['service_desc']);
$service_detail = mysqli_real_escape_string($con,$_POST['service_detail']);
 $port_url_new = mysqli_real_escape_string($con,$_POST['port_url']);
 $new_file_name = $current_image;
 if(!empty($_FILES["ufile"]["name"])) {
     $uploads_dir = 'uploads/portfolio';
     $tmp_name = $_FILES["ufile"]["tmp_name"];
     $name = basename($_FILES["ufile"]["name"]);
     $random_digit=rand(0000,9999);
     $new_file_name=$random_digit.$name;
     move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name");
 }
 if($status=="OK") {
     $qb=mysqli_query($con,"update portfolio set port_title='$service_title', port_desc='$service_desc', port_detail='$service_detail', port_url='$port_url_new', ufile='$new_file_name' where id='$todo'");
     if($qb){
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
					  mysqli_query($con, "INSERT INTO portfolio_media (portfolio_id, file_path, media_type, created_at) VALUES ('$todo', '$fp', '$mt', NOW())");
				  }
			  }
		  }

         $errormsg= "<div class='alert alert-success alert-dismissible alert-outline fade show'>Portfolio Updated successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
     }
 }
}

                                // Fetch existing media for this portfolio
                                $existing_media = [];
                                $tm_rs2 = mysqli_query($con, "SHOW TABLES LIKE 'portfolio_media'");
                                if ($tm_rs2 && mysqli_num_rows($tm_rs2) > 0) {
                                    $media_rs = mysqli_query($con, "SELECT * FROM portfolio_media WHERE portfolio_id='$todo' ORDER BY created_at DESC");
                                    while ($mrow = mysqli_fetch_assoc($media_rs)) {
                                        $existing_media[] = $mrow;
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
                                                            <input type="text" class="form-control" id="firstnameInput" name="service_title" value="<?php print $port_title ?>" placeholder="Enter Portfolio Title">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Short Description</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="service_desc" rows="2"><?php print $port_desc ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Portfolio Detail</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="service_detail" rows="3"><?php print $port_detail ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="portUrlInput" class="form-label">Website URL</label>
                                                            <input type="url" class="form-control" id="portUrlInput" name="port_url" value="<?php print $port_url ?>" placeholder="https://example.com">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="ufile" class="form-label">Portfolio Image</label>
                                                            <input type="file" class="form-control" id="ufile" name="ufile">
                                                            <?php if(!empty($current_image)) { ?>
                                                                <div class="mt-2">
                                                                    <img src="uploads/portfolio/<?php echo $current_image; ?>" alt="Current Image" style="max-width: 150px; border-radius: 8px;">
                                                                </div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Add More Media (images / video / documents)</label>
                                                            <input type="file" class="form-control" name="media_files[]" multiple>
                                                        </div>
                                                    </div>

                                                    <!-- ===== Existing Media Gallery ===== -->
                                                    <?php if (!empty($existing_media)): ?>
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label class="form-label fw-semibold">Current Media Files</label>
                                                            <div class="d-flex flex-wrap gap-3" id="existing-media-container">
                                                                <?php foreach ($existing_media as $media): ?>
                                                                <div class="position-relative border rounded p-1 text-center" id="media-item-<?php echo $media['id']; ?>" style="width:130px;">

                                                                    <?php if ($media['media_type'] === 'image'): ?>
                                                                        <img src="uploads/portfolio/<?php echo htmlspecialchars($media['file_path']); ?>"
                                                                             alt="media"
                                                                             class="img-fluid rounded"
                                                                             style="width:120px;height:100px;object-fit:cover;">

                                                                    <?php elseif ($media['media_type'] === 'video'): ?>
                                                                        <video width="120" height="100" controls style="object-fit:cover;border-radius:4px;">
                                                                            <source src="uploads/portfolio/<?php echo htmlspecialchars($media['file_path']); ?>">
                                                                        </video>

                                                                    <?php else: ?>
                                                                        <a href="uploads/portfolio/<?php echo htmlspecialchars($media['file_path']); ?>"
                                                                           target="_blank"
                                                                           class="d-flex flex-column align-items-center justify-content-center text-muted text-decoration-none"
                                                                           style="width:120px;height:100px;">
                                                                            <i class="fas fa-file-alt fa-3x mb-1"></i>
                                                                            <small class="text-truncate w-100 px-1"><?php echo htmlspecialchars($media['file_path']); ?></small>
                                                                        </a>
                                                                    <?php endif; ?>

                                                                    <button type="button"
                                                                            class="btn btn-danger btn-sm position-absolute top-0 end-0 p-0 lh-1 remove-media-btn"
                                                                            data-id="<?php echo $media['id']; ?>"
                                                                            title="Remove"
                                                                            style="width:22px;height:22px;font-size:12px;border-radius:50%;">
                                                                        &times;
                                                                    </button>
                                                                </div>
                                                                <?php endforeach; ?>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <?php endif; ?>
                                                    <!-- ===== End Existing Media Gallery ===== -->

                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Portfolio</button>
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


                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <?php include"footer.php";?>
</div>

<!-- ===== Remove Portfolio Media Script ===== -->
<script>
document.querySelectorAll('.remove-media-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
        var mediaId = this.getAttribute('data-id');
        if (!confirm('Are you sure you want to remove this media file?')) return;

        var formData = new FormData();
        formData.append('remove_media_id', mediaId);

        fetch('remove_portfolio_media.php?id=<?php echo urlencode($_GET['id']); ?>', {
            method: 'POST',
            body: formData
        })
        .then(function(res) { return res.json(); })
        .then(function(data) {
            if (data.success) {
                var item = document.getElementById('media-item-' + mediaId);
                if (item) item.remove();
            } else {
                alert('Could not remove: ' + (data.error || 'Unknown error'));
            }
        })
        .catch(function(err) {
            alert('An error occurred: ' + err.message);
        });
    });
});
</script>
<!-- ===== End Remove Portfolio Media Script ===== -->
