<?php include "header.php"; ?>
        <section class="section breadcrumb-area overlay-dark d-flex align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb-content d-flex flex-column align-items-center text-center">
                            <h2 class="text-white text-uppercase mb-3">Careers</h2>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                                <li class="breadcrumb-item text-white active">Careers</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section ptb_100 careers-page">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-8">
                        <div class="section-heading text-center">
                            <h2>Open Positions</h2>
                            <p class="d-none d-sm-block mt-4">Explore our current opportunities and apply to join our team.</p>
                        </div>
                    </div>
                </div>

                <div class="row careers-grid">
                    <?php
                        $q = "SELECT * FROM jobs WHERE status='open' ORDER BY created_at DESC";
                        $r = mysqli_query($con, $q);
                        if ($r) {
                            while ($row = mysqli_fetch_array($r)) {
                                $id = $row['id'];
                                $title = $row['job_title'];
                                $location = $row['location'];
                                $job_type = $row['job_type'];
                                $short_desc = $row['short_desc'];
                                $deadline = $row['deadline'];

                                $cover_image = isset($row['cover_image']) ? $row['cover_image'] : '';
                                $cover_html = '';
                                if (strlen(trim($cover_image)) > 0) {
                                    $safe_cover = htmlspecialchars($cover_image);
                                    $safe_title = htmlspecialchars($title);
                                    $cover_html = "<div class='mb-3' style='overflow:hidden;border-radius:12px;'><img src='dashboard/uploads/jobs/$safe_cover' alt='$safe_title' style='width:100%;height:160px;object-fit:cover;display:block;'></div>";
                                }

                                print "
                                <div class='col-12 col-md-6 col-lg-4 mb-4'>
                                    <div class='single-service p-4 h-100 careers-card'>
                                        $cover_html
                                        <h3 class='my-2'>$title</h3>
                                        <p class='mb-2 careers-meta'><strong>Location:</strong> $location</p>
                                        <p class='mb-2 careers-meta'><strong>Type:</strong> $job_type</p>
                                        <p class='careers-desc'>$short_desc</p>
                                        <p class='mb-3 careers-meta'><strong>Deadline:</strong> $deadline</p>
                                        <a class='btn btn-bordered mt-2 careers-btn' href='jobdetail.php?id=$id'>View & Apply</a>
                                    </div>
                                </div>
                                ";
                            }
                        }
                    ?>
                </div>
            </div>
        </section>

<?php include "footer.php"; ?>
