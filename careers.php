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
                        $has_views_col = false;
                        $col_rs_views = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'views'");
                        if ($col_rs_views && mysqli_num_rows($col_rs_views) > 0) {
                            $has_views_col = true;
                        }

                        $views_select_sql = $has_views_col ? "j.views" : "0 AS views";
                        $q = "SELECT j.*, $views_select_sql, COALESCE(apps.c, 0) AS applications_count
                              FROM jobs j
                              LEFT JOIN (
                                  SELECT job_id, COUNT(*) AS c
                                  FROM job_applications
                                  GROUP BY job_id
                              ) apps ON apps.job_id = j.id
                              WHERE j.status='open'
                              ORDER BY j.created_at DESC";

                        $r = mysqli_query($con, $q);
                        if ($r) {
                            while ($row = mysqli_fetch_array($r)) {
                                $id = $row['id'];
                                $title = $row['job_title'];
                                $location = $row['location'];
                                $job_type = $row['job_type'];
                                $short_desc = $row['short_desc'];
                                $deadline = $row['deadline'];

                                $views_count = isset($row['views']) ? (int)$row['views'] : 0;
                                $applications_count = isset($row['applications_count']) ? (int)$row['applications_count'] : 0;

                                $tracker_html = "<p class='mb-2 careers-meta'><strong>Views:</strong> $views_count</p>";
                                $tracker_html .= "<p class='mb-2 careers-meta'><strong>Applications:</strong> $applications_count</p>";

                                $salary = isset($row['salary']) ? $row['salary'] : '';
                                $salary_html = '';
                                if (strlen(trim($salary)) > 0) {
                                    $salary_safe = htmlspecialchars($salary);
                                    $salary_html = "<p class='mb-2 careers-meta'><strong>Salary:</strong> $salary_safe</p>";
                                }

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
                                        $tracker_html
                                        $salary_html
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
