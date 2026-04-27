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

        <!-- Filters Section -->
        <section class="section ptb_100 careers-page" style="padding-bottom: 30px;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-8">
                        <div class="section-heading text-center">
                            <h2>Open Positions</h2>
                            <p class="d-none d-sm-block mt-4">Explore our current opportunities and apply to join our team.</p>
                        </div>
                    </div>
                </div>

                <!-- Filter Controls -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="p-4" style="background: #fff; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                            <div class="row g-3 align-items-end">
                                <div class="col-12 col-md-5">
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-search mr-2"></i>Search Jobs</label>
                                    <input type="text" id="jobSearch" class="form-control" placeholder="Type to search jobs..." style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                </div>
                                <div class="col-12 col-md-4">
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-filter mr-2"></i>Filter by Role</label>
                                    <select id="roleFilter" class="form-control" style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                        <option value="">All Roles</option>
                                        <?php
                                            $role_q = "SELECT DISTINCT job_type FROM jobs WHERE status='open' ORDER BY job_type ASC";
                                            $role_r = mysqli_query($con, $role_q);
                                            if ($role_r) {
                                                while ($role_row = mysqli_fetch_array($role_r)) {
                                                    $role_type = htmlspecialchars($role_row['job_type']);
                                                    print "<option value='$role_type'>$role_type</option>";
                                                }
                                            }
                                        ?>
                                    </select>
                                </div>
                                <div class="col-12 col-md-3">
                                    <button type="button" id="clearFilters" class="btn btn-block" style="background: linear-gradient(135deg, #f67011 0%, #ff8c42 100%); color: white; border: none; border-radius: 10px; padding: 12px 20px; font-weight: 600;">
                                        <i class="fas fa-times mr-2"></i>Clear Filters
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <small id="resultsCount" style="color: #666; font-size: 14px;">Showing all open positions</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row careers-grid" id="openJobsGrid">
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

                                $display_views = 100 + $views_count;
                                $display_applications = 10 + $applications_count;

                                $tracker_html = "<div class='careers-meta d-flex justify-content-between align-items-center gap-2 mb-2'><span><strong>Views:</strong> $display_views</span><span><strong>Applicants:</strong> $display_applications</span></div>";

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
                                        $salary_html
                                        <p class='careers-desc'>$short_desc</p>
                                        <p class='mb-3 careers-meta'><strong>Deadline:</strong> $deadline</p>
                                        $tracker_html
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

        <!-- Past Openings Section -->
        <section class="section ptb_100" style="background: #f8f9fa; padding-top: 50px;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-8">
                        <div class="section-heading text-center mb-4">
                            <h2>Past Openings</h2>
                            <p class="d-none d-sm-block mt-4">Browse our previous job postings for reference.</p>
                        </div>
                    </div>
                </div>

                <!-- Past Jobs Filter Controls -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="p-4" style="background: #fff; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                            <div class="row g-3 align-items-end">
                                <div class="col-12 col-md-5">
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-search mr-2"></i>Search Past Jobs</label>
                                    <input type="text" id="pastJobSearch" class="form-control" placeholder="Type to search past openings..." style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                </div>
                                <div class="col-12 col-md-4">
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-filter mr-2"></i>Filter by Role</label>
                                    <select id="pastRoleFilter" class="form-control" style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                        <option value="">All Roles</option>
                                        <?php
                                            $past_role_q = "SELECT DISTINCT job_type FROM jobs WHERE status='closed' ORDER BY job_type ASC";
                                            $past_role_r = mysqli_query($con, $past_role_q);
                                            if ($past_role_r) {
                                                while ($past_role_row = mysqli_fetch_array($past_role_r)) {
                                                    $past_role_type = htmlspecialchars($past_role_row['job_type']);
                                                    print "<option value='$past_role_type'>$past_role_type</option>";
                                                }
                                            }
                                        ?>
                                    </select>
                                </div>
                                <div class="col-12 col-md-3">
                                    <button type="button" id="clearPastFilters" class="btn btn-block" style="background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%); color: white; border: none; border-radius: 10px; padding: 12px 20px; font-weight: 600;">
                                        <i class="fas fa-times mr-2"></i>Clear
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <small id="pastResultsCount" style="color: #666; font-size: 14px;">Showing all past openings</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row careers-grid" id="pastJobsGrid">
                    <?php
                        $past_q = "SELECT j.*, $views_select_sql, COALESCE(apps.c, 0) AS applications_count
                              FROM jobs j
                              LEFT JOIN (
                                  SELECT job_id, COUNT(*) AS c
                                  FROM job_applications
                                  GROUP BY job_id
                              ) apps ON apps.job_id = j.id
                              WHERE j.status='closed'
                              ORDER BY j.created_at DESC";

                        $past_r = mysqli_query($con, $past_q);
                        if ($past_r && mysqli_num_rows($past_r) > 0) {
                            while ($past_row = mysqli_fetch_array($past_r)) {
                                $past_id = $past_row['id'];
                                $past_title = $past_row['job_title'];
                                $past_location = $past_row['location'];
                                $past_job_type = $past_row['job_type'];
                                $past_short_desc = $past_row['short_desc'];
                                $past_deadline = $past_row['deadline'];

                                print "
                                <div class='col-12 col-md-6 col-lg-4 mb-4 job-card' data-title='" . htmlspecialchars(strtolower($past_title)) . "' data-role='" . htmlspecialchars(strtolower($past_job_type)) . "'>
                                    <div class='single-service p-4 h-100 careers-card' style='opacity: 0.8; background: #f4f4f4;'>
                                        <h3 class='my-2' style='font-size: 18px;'>$past_title</h3>
                                        <p class='mb-2 careers-meta'><strong>Location:</strong> $past_location</p>
                                        <p class='mb-2 careers-meta'><strong>Type:</strong> $past_job_type</p>
                                        <p class='careers-desc' style='font-size: 13px;'>$past_short_desc</p>
                                        <p class='mb-3 careers-meta'><strong>Closed:</strong> $past_deadline</p>
                                        <span class='badge' style='background: #6c757d; color: white; padding: 6px 12px; border-radius: 20px; font-size: 12px;'>Position Filled</span>
                                    </div>
                                </div>
                                ";
                            }
                        } else {
                            print "
                            <div class='col-12 text-center py-5'>
                                <i class='fas fa-folder-open fa-3x mb-3' style='color: #ccc;'></i>
                                <p style='color: #888;'>No past openings available.</p>
                            </div>
                            ";
                        }
                    ?>
                </div>
            </div>
        </section>

        <script>
        // Open Jobs Filtering
        document.addEventListener('DOMContentLoaded', function() {
            const jobSearch = document.getElementById('jobSearch');
            const roleFilter = document.getElementById('roleFilter');
            const clearFilters = document.getElementById('clearFilters');
            const resultsCount = document.getElementById('resultsCount');
            const openJobsGrid = document.getElementById('openJobsGrid');

            function filterOpenJobs() {
                const searchTerm = jobSearch.value.toLowerCase();
                const selectedRole = roleFilter.value.toLowerCase();
                const jobCards = openJobsGrid.querySelectorAll('.col-12.col-md-6.col-lg-4');
                let visibleCount = 0;

                jobCards.forEach(function(card) {
                    const title = card.querySelector('h3').textContent.toLowerCase();
                    const type = card.querySelector('.careers-meta:nth-of-type(2)');
                    const typeText = type ? type.textContent.toLowerCase() : '';

                    const matchesSearch = title.includes(searchTerm);
                    const matchesRole = selectedRole === '' || typeText.includes(selectedRole.toLowerCase());

                    if (matchesSearch && matchesRole) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                resultsCount.textContent = visibleCount + ' position' + (visibleCount !== 1 ? 's' : '') + ' found';
            }

            jobSearch.addEventListener('input', filterOpenJobs);
            roleFilter.addEventListener('change', filterOpenJobs);

            clearFilters.addEventListener('click', function() {
                jobSearch.value = '';
                roleFilter.value = '';
                filterOpenJobs();
            });

            // Past Jobs Filtering
            const pastJobSearch = document.getElementById('pastJobSearch');
            const pastRoleFilter = document.getElementById('pastRoleFilter');
            const clearPastFilters = document.getElementById('clearPastFilters');
            const pastResultsCount = document.getElementById('pastResultsCount');
            const pastJobsGrid = document.getElementById('pastJobsGrid');

            function filterPastJobs() {
                const searchTerm = pastJobSearch.value.toLowerCase();
                const selectedRole = pastRoleFilter.value.toLowerCase();
                const jobCards = pastJobsGrid.querySelectorAll('.job-card');
                let visibleCount = 0;

                jobCards.forEach(function(card) {
                    const title = card.getAttribute('data-title') || '';
                    const role = card.getAttribute('data-role') || '';

                    const matchesSearch = title.includes(searchTerm);
                    const matchesRole = selectedRole === '' || role.includes(selectedRole);

                    if (matchesSearch && matchesRole) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                pastResultsCount.textContent = visibleCount + ' past opening' + (visibleCount !== 1 ? 's' : '') + ' found';
            }

            pastJobSearch.addEventListener('input', filterPastJobs);
            pastRoleFilter.addEventListener('change', filterPastJobs);

            clearPastFilters.addEventListener('click', function() {
                pastJobSearch.value = '';
                pastRoleFilter.value = '';
                filterPastJobs();
            });
        });
        </script>

        <!-- ***** Review Area Start ***** -->
        <section id="review" class="section review-area bg-grey ptb_100 position-relative" style="padding: 65px 0; background-color: #f4f4f4 !important;">
            <div class="shape shape-top" style="z-index: 0;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#f4f4f4">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
                c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
                c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
            <div class="container" style="position: relative; z-index: 1;">
                <div class="row">
                    <div class="col-12">
                        <div class="section-heading text-center">
                            <h2><?php print $test_title; ?></h2>
                        </div>
                        <p class="mt-1 mb-5 text-start" style="max-width: 100%; color: #555; font-size: 16px; line-height: 1.8;"><?php print $test_text;?></p>
                    </div>
                </div>
                <div class="row">
                    <div class="client-reviews owl-carousel">
                        <?php
				   $q="SELECT * FROM  testimony ORDER BY id DESC LIMIT 6";


 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$name="$ro[name]";
	$position="$ro[position]";
    $message="$ro[message]";
    $ufile="$ro[ufile]";

print "

<div class='single-review p-5' style='background: #fff; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); transition: all 0.3s ease; margin: 15px;'>
<!-- Review Content -->
<div class='review-content'>
    <!-- Quotation Icon -->
    <div style='color: #f67011; font-size: 40px; margin-bottom: 15px; line-height: 1;'>\"</div>
    <!-- Review Text -->
    <div class='review-text'>
        <p style='color: #555; line-height: 1.7; font-style: italic;'>$message</p>
    </div>
</div>
<!-- Reviewer -->
<div class='reviewer media mt-4 align-items-center'>
    <!-- Reviewer Thumb -->
    <div class='reviewer-thumb flex-shrink-0'>
        <img class='avatar-lg rounded-circle' style='width: 60px; height: 60px; object-fit: cover; border: 3px solid #f67011;' src='dashboard/uploads/testimony/$ufile' alt='img'>
    </div>
    <!-- Reviewer Media -->
    <div class='reviewer-meta media-body align-self-center ml-3'>
        <h5 style='color: #3b1b6a; font-weight: 700; font-size: 16px; margin-bottom: 2px;'>$name</h5>
        <h6 style='color: #f67011; font-weight: 600; font-size: 13px; margin-bottom: 0;'>$position</h6>
    </div>
</div>
</div>


";
}
?>
                    </div>
                </div>
            </div>
            <div class="shape shape-bottom" style="z-index: 0;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7
        c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>
        <!-- ***** Review Area End ***** -->

        <!--====== Call To Action Area Start ======-->
        <section class="section cta-area bg-overlay orangish-gradient ptb_100">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-10">
                        <!-- Section Heading -->
                        <div class="section-heading text-center m-0">
                            <h2 class="text-white"><?php print $enquiry_title; ?></h2>
                            <p class="text-white mt-4"><?php print $enquiry_text; ?></p>
                            <a href="#" class="btn btn-bordered-white mt-4" data-toggle="modal" data-target="#bookMeetingModal">Book a Meeting</a>
                            <!-- <a href="contact" class="btn btn-bordered-white mt-4">Contact Us</a> -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--====== Call To Action Area End ======-->

<?php include "footer.php"; ?>
