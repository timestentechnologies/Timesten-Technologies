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
                                <h4 class="mb-sm-0">Services</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">All</a></li>
                                        <li class="breadcrumb-item active">Services</li>
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
                                    <h5 class="card-title mb-0">Services List</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <?php
                                        $q="SELECT * FROM service ORDER BY id DESC";
                                        $r123 = mysqli_query($con,$q);

                                        while($ro = mysqli_fetch_array($r123))
                                        {
                                            $id="$ro[id]";
                                            $service_title="$ro[service_title]";
                                            $service_desc="$ro[service_desc]";
                                            $ufile="$ro[ufile]";
                                            $service_url="$ro[service_url]";

                                            $image_path = !empty($ufile) ? "uploads/services/$ufile" : "assets/images/placeholder.jpg";
                                            ?>

                                            <div class="col-xl-4 col-md-6">
                                                <div class="card product-card" style="border-top: 4px solid #f97316;">
                                                    <div class="card-body">
                                                        <div class="d-flex align-items-start">
                                                            <div class="flex-shrink-0 me-3">
                                                                <img src="<?php echo $image_path; ?>" alt="<?php echo htmlspecialchars($service_title); ?>" class="avatar-lg rounded" style="object-fit: cover; width: 80px; height: 80px;">
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <h5 class="card-title mb-1"><?php echo htmlspecialchars($service_title); ?></h5>
                                                                <?php if(!empty($service_desc)): ?>
                                                                    <p class="card-text text-muted mb-2" style="font-size: 0.875rem;"><?php echo htmlspecialchars(substr($service_desc, 0, 100)) . (strlen($service_desc) > 100 ? '...' : ''); ?></p>
                                                                <?php endif; ?>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex justify-content-end mt-3">
                                                            <div class='dropdown d-inline-block'>
                                                                <button class='btn btn-soft-secondary btn-sm dropdown' type='button' data-bs-toggle='dropdown' aria-expanded='false'>
                                                                    <i class='ri-more-fill align-middle'></i>
                                                                </button>
                                                                <ul class='dropdown-menu dropdown-menu-end'>
                                                                    <li><a href='editservice.php?id=<?php echo $id; ?>' class='dropdown-item edit-item-btn'><i class='ri-pencil-fill align-bottom me-2 text-muted'></i> Edit</a></li>
                                                                    <li>
                                                                        <a href='deleteservice.php?id=<?php echo $id; ?>' class='dropdown-item remove-item-btn'>
                                                                            <i class='ri-delete-bin-fill align-bottom me-2 text-muted'></i> Delete
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <?php
                                        }
                                        ?>
                                    </div>
                                </div>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->




                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <?php include"footer.php";?>
