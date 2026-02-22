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
         $errormsg= "<div class='alert alert-success alert-dismissible alert-outline fade show'>Portfolio Updated successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
     }
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
