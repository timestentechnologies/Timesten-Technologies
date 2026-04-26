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
                                <h4 class="mb-sm-0">Why Choose Us</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">All</a></li>
                                        <li class="breadcrumb-item active">Why Us</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- end page title -->


                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Why Us List</h5>
                                </div>
                                <div class="card-body">
                                    <table id="example" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th data-ordering="false">Icon</th>
                                                <th data-ordering="false">Why Choose Us Title</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>


                                        <?php
				   $q="SELECT * FROM  why_us ORDER BY id DESC";


 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$id="$ro[id]";
	$title="$ro[title]";
	$icon_class="$ro[icon_class]";
	$icon_type="$ro[icon_type]";
	$icon_image="$ro[icon_image]";

  // Build icon display
  $icon_display = '';
  if($icon_type == 'upload' && $icon_image) {
      $icon_display = "<img src='uploads/whyicons/$icon_image' alt='Icon' style='max-height: 40px; max-width: 40px;'>";
  } elseif($icon_class) {
      $icon_display = "<i class='$icon_class fa-2x' style='color: #ff8c00;'></i>";
  } else {
      $icon_display = "<i class='fas fa-star fa-2x' style='color: #ff8c00;'></i>";
  }

  print "<tr>
                  <td>$icon_display</td>
				  <td>$title</td>

          <td>
                                                    <div class='dropdown d-inline-block'>
                                                        <button class='btn btn-soft-secondary btn-sm dropdown' type='button' data-bs-toggle='dropdown' aria-expanded='false'>
                                                            <i class='ri-more-fill align-middle'></i>
                                                        </button>
                                                        <ul class='dropdown-menu dropdown-menu-end'>

                                                            <li>
                                                                <a href='edit-why.php?id=$id' class='dropdown-item'>
                                                                    <i class='ri-pencil-fill align-bottom me-2 text-muted'></i> Edit
                                                                </a>
                                                            </li>

                                                            <li>
                                                                <a href='deletewhy.php?id=$id' class='dropdown-item remove-item-btn'>
                                                                    <i class='ri-delete-bin-fill align-bottom me-2 text-muted'></i> Delete
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>


				  </tr>";

  }
  ?>




                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->




                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <?php include"footer.php";?>
