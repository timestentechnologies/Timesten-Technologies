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
                                <h4 class="mb-sm-0">Edit Blog</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Blog</a></li>
                                        <li class="breadcrumb-item active">Edit</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- end page title -->
                    <?php
					 $query="SELECT * FROM  blog where id='$todo' ";


 $result = mysqli_query($con,$query);
$i=0;
while($row = mysqli_fetch_array($result))
{
	$id="$row[id]";
	$blog_title="$row[blog_title]";
	$blog_desc="$row[blog_desc]";
    $blog_detail="$row[blog_detail]";
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
                                                <i class="fas fa-home"></i> Edit Blog
                                            </a>
                                        </li>


                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$blog_title = mysqli_real_escape_string($con,$_POST['blog_title']);
$blog_desc = mysqli_real_escape_string($con,$_POST['blog_desc']);
$blog_detail = mysqli_real_escape_string($con,$_POST['blog_detail']);

// Handle image upload if a new file is selected
if(!empty($_FILES["ufile"]["name"])) {
    $uploads_dir = 'uploads/blog';

    // Delete old image if it exists
    if(!empty($current_image) && file_exists("$uploads_dir/$current_image")) {
        unlink("$uploads_dir/$current_image");
    }

    $tmp_name = $_FILES["ufile"]["tmp_name"];
    $name = basename($_FILES["ufile"]["name"]);
    $random_digit = rand(0000,9999);
    $new_file_name = $random_digit.$name;

    if(move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name")) {
        // Update query with new image
        $qb = mysqli_query($con,"update blog set blog_title='$blog_title', blog_desc='$blog_desc', blog_detail='$blog_detail', ufile='$new_file_name' where id='$todo'");
    } else {
        $status = "NOTOK";
        $msg = "Failed to upload image. Please try again.";
    }
} else {
    // Update without changing image
    $qb = mysqli_query($con,"update blog set blog_title='$blog_title', blog_desc='$blog_desc', blog_detail='$blog_detail' where id='$todo'");
}

if($status=="OK")
{
		if($qb){
		    	$errormsg= "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
                 Blog Updated successfully.
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
                                                            <label for="firstnameInput" class="form-label"> Blog Title</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="blog_title" value="<?php print $blog_title ?>" placeholder="Enter Service Title">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Short Description</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="blog_desc" rows="2"><?php print $blog_desc ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Blog Detail</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="blog_detail" rows="3"><?php print $blog_detail ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Current Image</label>
                                                            <?php if(!empty($current_image)): ?>
                                                                <div class="mb-2">
                                                                    <img src="uploads/blog/<?php echo htmlspecialchars($current_image); ?>" 
                                                                         alt="Current Blog Image" 
                                                                         style="max-width: 200px; height: auto;" 
                                                                         class="img-thumbnail">
                                                                </div>
                                                            <?php endif; ?>
                                                            <input type="file" class="form-control" name="ufile">
                                                            <small class="text-muted">Leave empty to keep current image</small>
                                                        </div>
                                                    </div>

                                                    <!--end col-->

                                                    <!--end col-->
                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Blog</button>

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
