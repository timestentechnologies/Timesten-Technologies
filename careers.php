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
                                <div class="col-12 col-md-3">
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-search mr-2"></i>Search Jobs</label>
                                    <input type="text" id="jobSearch" class="form-control" placeholder="Type to search jobs..." style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                </div>
                                <div class="col-12 col-md-3">
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-filter mr-2"></i>Filter by Role</label>
                                    <select id="roleFilter" class="form-control" style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                        <option value="">All Roles</option>
                                        <?php
                                            $role_q = "SELECT DISTINCT job_type FROM jobs ORDER BY job_type ASC";
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
                                    <label class="mb-2" style="font-weight: 600; color: #3b1b6a; font-size: 14px;"><i class="fas fa-folder mr-2"></i>Status</label>
                                    <select id="statusFilter" class="form-control" style="border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px;">
                                        <option value="open">Open Positions</option>
                                        <option value="closed">Past Openings</option>
                                        <option value="">All Jobs</option>
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
                                    <small id="resultsCount" style="color: #666; font-size: 14px;">Showing open positions</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row careers-grid" id="jobsGrid">
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
                                $status = $row['status'];
                                $is_closed = ($status === 'closed');

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

                                $card_style = $is_closed ? "opacity: 0.7; background: #f4f4f4;" : "";
                                $deadline_label = $is_closed ? "Closed" : "Deadline";
                                $status_badge = $is_closed ? "<span class='badge' style='background: #6c757d; color: white; padding: 6px 12px; border-radius: 20px; font-size: 12px;'>Position Filled</span>" : "<a class='btn btn-bordered mt-2 careers-btn' href='jobdetail.php?id=$id'>View & Apply</a>";
                                $title_style = $is_closed ? "style='font-size: 18px;'" : "";

                                print "
                                <div class='col-12 col-md-6 col-lg-4 mb-4 job-card' data-title='" . htmlspecialchars(strtolower($title)) . "' data-role='" . htmlspecialchars(strtolower($job_type)) . "' data-status='" . htmlspecialchars($status) . "'>
                                    <div class='single-service p-4 h-100 careers-card' style='$card_style'>
                                        $cover_html
                                        <h3 class='my-2' $title_style>$title</h3>
                                        <p class='mb-2 careers-meta'><strong>Location:</strong> $location</p>
                                        <p class='mb-2 careers-meta'><strong>Type:</strong> $job_type</p>
                                        $salary_html
                                        <p class='careers-desc'>$short_desc</p>
                                        <p class='mb-3 careers-meta'><strong>$deadline_label:</strong> $deadline</p>
                                        " . (!$is_closed ? $tracker_html : "") . "
                                        $status_badge
                                    </div>
                                </div>
                                ";
                            }
                        }
                    ?>
                </div>
            </div>
        </section>

        <script>
        // Jobs Filtering
        document.addEventListener('DOMContentLoaded', function() {
            const jobSearch = document.getElementById('jobSearch');
            const roleFilter = document.getElementById('roleFilter');
            const statusFilter = document.getElementById('statusFilter');
            const clearFilters = document.getElementById('clearFilters');
            const resultsCount = document.getElementById('resultsCount');
            const jobsGrid = document.getElementById('jobsGrid');

            function filterJobs() {
                const searchTerm = jobSearch.value.toLowerCase();
                const selectedRole = roleFilter.value.toLowerCase();
                const selectedStatus = statusFilter.value;
                const jobCards = jobsGrid.querySelectorAll('.job-card');
                let visibleCount = 0;
                let openCount = 0;
                let closedCount = 0;

                jobCards.forEach(function(card) {
                    const title = card.getAttribute('data-title') || '';
                    const role = card.getAttribute('data-role') || '';
                    const status = card.getAttribute('data-status') || '';

                    const matchesSearch = title.includes(searchTerm);
                    const matchesRole = selectedRole === '' || role.includes(selectedRole);
                    const matchesStatus = selectedStatus === '' || status === selectedStatus;

                    if (matchesSearch && matchesRole && matchesStatus) {
                        card.style.display = '';
                        visibleCount++;
                        if (status === 'open') openCount++;
                        else closedCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                let countText = visibleCount + ' job' + (visibleCount !== 1 ? 's' : '') + ' found';
                if (selectedStatus === 'open') countText += ' (' + openCount + ' open)';
                else if (selectedStatus === 'closed') countText += ' (' + closedCount + ' past)';
                else if (openCount > 0 && closedCount > 0) countText += ' (' + openCount + ' open, ' + closedCount + ' past)';

                resultsCount.textContent = countText;
            }

            jobSearch.addEventListener('input', filterJobs);
            roleFilter.addEventListener('change', filterJobs);
            statusFilter.addEventListener('change', filterJobs);

            clearFilters.addEventListener('click', function() {
                jobSearch.value = '';
                roleFilter.value = '';
                statusFilter.value = 'open';
                filterJobs();
            });

            // Initial filter to show only open by default
            filterJobs();
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
