<?php
include"header.php";
$username=$_SESSION['username'];

$jobs_total = 0;
$job_apps_total = 0;
$job_views_total = 0;

$recent_page = isset($_GET['rv_page']) ? (int)$_GET['rv_page'] : 1;
if ($recent_page < 1) { $recent_page = 1; }
$recent_limit = isset($_GET['rv_limit']) ? (int)$_GET['rv_limit'] : 5;
$allowed_limits = [5, 10, 15, 25, 50];
if (!in_array($recent_limit, $allowed_limits, true)) { $recent_limit = 5; }
$recent_per_page = $recent_limit;

$jobviews_page = isset($_GET['jv_page']) ? (int)$_GET['jv_page'] : 1;
if ($jobviews_page < 1) { $jobviews_page = 1; }
$jobviews_per_page = 15;

$jobs_rs = mysqli_query($con, "SELECT COUNT(*) AS c FROM jobs");
if ($jobs_rs) {
    $jobs_row = mysqli_fetch_assoc($jobs_rs);
    $jobs_total = $jobs_row ? (int)$jobs_row['c'] : 0;
}

$apps_rs = mysqli_query($con, "SELECT COUNT(*) AS c FROM job_applications");
if ($apps_rs) {
    $apps_row = mysqli_fetch_assoc($apps_rs);
    $job_apps_total = $apps_row ? (int)$apps_row['c'] : 0;
}

$has_job_views_col = false;
$col_rs_views = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'views'");
if ($col_rs_views && mysqli_num_rows($col_rs_views) > 0) {
    $has_job_views_col = true;
}

if ($has_job_views_col) {
    $views_rs = mysqli_query($con, "SELECT COALESCE(SUM(COALESCE(views,0)),0) AS s FROM jobs");
    if ($views_rs) {
        $views_row = mysqli_fetch_assoc($views_rs);
        $job_views_total = $views_row ? (int)$views_row['s'] : 0;
    }
}

$has_page_visits_table = false;
$pv_rs = mysqli_query($con, "SHOW TABLES LIKE 'page_visits'");
if ($pv_rs && mysqli_num_rows($pv_rs) > 0) {
    $has_page_visits_table = true;
}

$most_pages = [];
$device_breakdown = [];
$recent_visits = [];
$job_view_visits = [];
$recent_total = 0;
$recent_total_pages = 1;
$jobviews_total = 0;
$jobviews_total_pages = 1;

if ($has_page_visits_table) {
    if (isset($_POST['confirm_delete_job_views'])) {
        mysqli_query(
            $con,
            "DELETE FROM page_visits
             WHERE page_url NOT LIKE '%/dashboard/%'
               AND (
                    page_url LIKE '%jobdetail%'
                 OR page_url LIKE '%jobdetail.php%'
                 OR page_url LIKE '%job-detail%'
                 OR page_url LIKE '%careers%'
                 OR page_url LIKE '%job%'
               )"
        );
        print "<script>window.location='index.php?jv_page=1&rv_page=" . (int)$recent_page . "&rv_limit=" . (int)$recent_limit . "';</script>";
        exit;
    }

    if (isset($_POST['confirm_delete_recent_visits'])) {
        mysqli_query($con, "DELETE FROM page_visits");
        print "<script>window.location='index.php?jv_page=" . (int)$jobviews_page . "&rv_page=1&rv_limit=" . (int)$recent_limit . "';</script>";
        exit;
    }

    $mp_rs = mysqli_query($con, "SELECT page_url, COUNT(*) AS c FROM page_visits GROUP BY page_url ORDER BY c DESC LIMIT 10");
    if ($mp_rs) {
        while ($r = mysqli_fetch_assoc($mp_rs)) {
            $most_pages[] = $r;
        }
    }

    $dev_rs = mysqli_query($con, "SELECT device_type, COUNT(*) AS c FROM page_visits GROUP BY device_type ORDER BY c DESC");
    if ($dev_rs) {
        while ($r = mysqli_fetch_assoc($dev_rs)) {
            $device_breakdown[] = $r;
        }
    }

    $recent_total_rs = mysqli_query($con, "SELECT COUNT(*) AS c FROM page_visits");
    if ($recent_total_rs) {
        $recent_total_row = mysqli_fetch_assoc($recent_total_rs);
        $recent_total = $recent_total_row ? (int)$recent_total_row['c'] : 0;
    }
    $recent_total_pages = (int)ceil($recent_total / $recent_per_page);
    if ($recent_total_pages < 1) { $recent_total_pages = 1; }
    if ($recent_page > $recent_total_pages) { $recent_page = $recent_total_pages; }
    $recent_offset = ($recent_page - 1) * $recent_per_page;

    $rv_rs = mysqli_query($con, "SELECT page_url, ip_address, device_type, location, created_at FROM page_visits ORDER BY id DESC LIMIT $recent_offset,$recent_per_page");
    if ($rv_rs) {
        while ($r = mysqli_fetch_assoc($rv_rs)) {
            $recent_visits[] = $r;
        }
    }

    $jobviews_total_rs = mysqli_query(
        $con,
        "SELECT COUNT(*) AS c
         FROM page_visits
         WHERE page_url NOT LIKE '%/dashboard/%'
           AND (
                page_url LIKE '%jobdetail%'
             OR page_url LIKE '%jobdetail.php%'
             OR page_url LIKE '%job-detail%'
             OR page_url LIKE '%careers%'
             OR page_url LIKE '%job%'
           )"
    );
    if ($jobviews_total_rs) {
        $jobviews_total_row = mysqli_fetch_assoc($jobviews_total_rs);
        $jobviews_total = $jobviews_total_row ? (int)$jobviews_total_row['c'] : 0;
    }
    $jobviews_total_pages = (int)ceil($jobviews_total / $jobviews_per_page);
    if ($jobviews_total_pages < 1) { $jobviews_total_pages = 1; }
    if ($jobviews_page > $jobviews_total_pages) { $jobviews_page = $jobviews_total_pages; }
    $jobviews_offset = ($jobviews_page - 1) * $jobviews_per_page;

    $jv_rs = mysqli_query(
        $con,
        "SELECT page_url, ip_address, device_type, location, created_at
         FROM page_visits
         WHERE page_url NOT LIKE '%/dashboard/%'
           AND (
                page_url LIKE '%jobdetail%'
             OR page_url LIKE '%jobdetail.php%'
             OR page_url LIKE '%job-detail%'
             OR page_url LIKE '%careers%'
             OR page_url LIKE '%job%'
           )
         ORDER BY id DESC
         LIMIT $jobviews_offset,$jobviews_per_page"
    );
    if ($jv_rs) {
        while ($r = mysqli_fetch_assoc($jv_rs)) {
            $job_view_visits[] = $r;
        }
    }
}
?>
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
                        <h4 class="mb-sm-0">Dashboard</h4>

                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript: void(0);">Dashboard</a></li>
                                <li class="breadcrumb-item active">Home</li>
                            </ol>
                        </div>

                    </div>
                </div>
            </div>
            <!-- end page title -->

            <div class="row">
                <div class="col">

                    <div>
                        <div class="row mb-3 pb-1">
                            <div class="col-12">
                                <div class="d-flex align-items-lg-center flex-lg-row flex-column">
                                    <div class="flex-grow-1">
                                        <h4 class="fs-16 mb-1">Hello , <?php print $username;?>!</h4>
                                        <p class="text-muted mb-0">Welcome back to your dashboard.</p>
                                    </div>

                                <div class="modal fade" id="confirmDeleteJobViewsModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">Delete all job view logs?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                                                <form method="post" class="mb-0">
                                                    <button type="submit" name="confirm_delete_job_views" value="1" class="btn btn-danger">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal fade" id="confirmDeleteRecentModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">Delete all recent visit logs?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                                                <form method="post" class="mb-0">
                                                    <button type="submit" name="confirm_delete_recent_visits" value="1" class="btn btn-danger">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                    <div class="mt-3 mt-lg-0">
                                        <form action="javascript:void(0);">

                                        </form>
                                    </div>
                                </div><!-- end card header -->
                            </div>
                            <!--end col-->
                        </div>
                        <!--end row-->

                        <div class="row">
                                    <div class="col-lg-4 col-md-6">
                                        <a href="services.php" class="text-decoration-none text-reset">
                                        <div class="card" style="cursor:pointer;">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm flex-shrink-0">
                                                        <span class="avatar-title bg-light text-primary rounded-circle fs-3">
                                                            <i class="ri-git-merge-fill"></i>
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                    <?php
$result = mysqli_query($con,"SELECT count(*) FROM service");
$row = mysqli_fetch_row($result);
$numrows = $row[0];

?>

                                                        <p class="text-uppercase fw-semibold fs-12 text-muted mb-1"> Total Services</p>
                                                        <h4 class=" mb-0"><span class="counter-value" data-target="<?php print $numrows; ?>"></span></h4>
                                                    </div>

                                                </div>
                                            </div><!-- end card body -->
                                        </div><!-- end card -->
                                        </a>
                                    </div><!-- end col -->
                                    <div class="col-lg-4 col-md-6">
                                        <a href="portfolio.php" class="text-decoration-none text-reset">
                                        <div class="card" style="cursor:pointer;">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm flex-shrink-0">
                                                        <span class="avatar-title bg-light text-primary rounded-circle fs-3">
                                                            <i class="ri-server-line"></i>
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                    <?php
$result = mysqli_query($con,"SELECT count(*) FROM portfolio");
$rowx = mysqli_fetch_row($result);
$nux = $rowx[0];

?>
                                                        <p class="text-uppercase fw-semibold fs-12 text-muted mb-1"> Total Portfolio</p>
                                                        <h4 class=" mb-0"><span class="counter-value" data-target="<?php print $nux; ?>"></span></h4>
                                                    </div>

                                                </div>
                                            </div><!-- end card body -->
                                        </div><!-- end card -->
                                        </a>
                                    </div><!-- end col -->
                                    <div class="col-lg-4 col-md-6">
                                        <a href="bloglist.php" class="text-decoration-none text-reset">
                                        <div class="card" style="cursor:pointer;">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm flex-shrink-0">
                                                        <span class="avatar-title bg-light text-primary rounded-circle fs-3">
                                                            <i class="ri-pages-line"></i>
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                    <?php
$result = mysqli_query($con,"SELECT count(*) FROM blog");
$rod = mysqli_fetch_row($result);
$nud = $rod[0];

?>
                                                        <p class="text-uppercase fw-semibold fs-12 text-muted mb-1"> Total Blog</p>
                                                        <h4 class=" mb-0"><span class="counter-value" data-target="<?php print $nud; ?>"></span></h4>
                                                    </div>

                                                </div>
                                            </div><!-- end card body -->
                                        </div><!-- end card -->
                                        </a>
                                    </div><!-- end col -->
                                    <div class="col-lg-4 col-md-6">
                                        <a href="jobs.php" class="text-decoration-none text-reset">
                                        <div class="card" style="cursor:pointer;">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm flex-shrink-0">
                                                        <span class="avatar-title bg-light text-primary rounded-circle fs-3">
                                                            <i class="ri-briefcase-4-line"></i>
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <p class="text-uppercase fw-semibold fs-12 text-muted mb-1"> Total Jobs</p>
                                                        <h4 class=" mb-0"><span class="counter-value" data-target="<?php print (int)$jobs_total; ?>"></span></h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </a>
                                    </div>

                                    <div class="col-lg-4 col-md-6">
                                        <a href="job-applications.php" class="text-decoration-none text-reset">
                                        <div class="card" style="cursor:pointer;">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm flex-shrink-0">
                                                        <span class="avatar-title bg-light text-primary rounded-circle fs-3">
                                                            <i class="ri-file-list-3-line"></i>
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <p class="text-uppercase fw-semibold fs-12 text-muted mb-1"> Total Applicants</p>
                                                        <h4 class=" mb-0"><span class="counter-value" data-target="<?php print (int)$job_apps_total; ?>"></span></h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </a>
                                    </div>

                                    <div class="col-lg-4 col-md-6">
                                        <div class="card" role="button" data-bs-toggle="modal" data-bs-target="#jobViewsModal" style="cursor:pointer;">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm flex-shrink-0">
                                                        <span class="avatar-title bg-light text-primary rounded-circle fs-3">
                                                            <i class="ri-eye-line"></i>
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <p class="text-uppercase fw-semibold fs-12 text-muted mb-1"> Total Job Views</p>
                                                        <h4 class=" mb-0"><span class="counter-value" data-target="<?php print (int)$job_views_total; ?>"></span></h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal fade" id="jobViewsModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-xl modal-dialog-scrollable">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Job Views - Viewer Details</h5>
                                                <?php if ($has_page_visits_table) { ?>
                                                    <button type="button" class="btn btn-sm btn-danger ms-auto me-2" data-bs-toggle="modal" data-bs-target="#confirmDeleteJobViewsModal">Delete All</button>
                                                <?php } ?>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <?php if ($has_page_visits_table) { ?>
                                                    <div class="table-responsive">
                                                        <table class="table table-striped table-sm align-middle mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Page</th>
                                                                    <th>IP Address</th>
                                                                    <th>Device</th>
                                                                    <th>Location</th>
                                                                    <th>Time</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php
                                                                if (count($job_view_visits) < 1) {
                                                                    print "<tr><td colspan='5' class='text-center text-muted'>No job view logs yet. Open a job details page (from the public site) to generate viewer records.</td></tr>";
                                                                }
                                                                foreach ($job_view_visits as $v) {
                                                                    $pu = htmlspecialchars($v['page_url']);
                                                                    $ip = htmlspecialchars($v['ip_address']);
                                                                    $dv = htmlspecialchars($v['device_type']);
                                                                    $lc = htmlspecialchars($v['location']);
                                                                    $tm = htmlspecialchars($v['created_at']);
                                                                    print "<tr><td style='word-break:break-all;'>$pu</td><td>$ip</td><td>$dv</td><td>$lc</td><td>$tm</td></tr>";
                                                                }
                                                                ?>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <?php if ($jobviews_total_pages > 1) { ?>
                                                        <nav class="mt-3" aria-label="Job views pagination">
                                                            <ul class="pagination pagination-sm mb-0">
                                                                <?php
                                                                $prev = $jobviews_page - 1;
                                                                $next = $jobviews_page + 1;
                                                                $rv_keep = (int)$recent_page;
                                                                $prev_disabled = $jobviews_page <= 1 ? ' disabled' : '';
                                                                $next_disabled = $jobviews_page >= $jobviews_total_pages ? ' disabled' : '';
                                                                print "<li class='page-item$prev_disabled'><a class='page-link' href='index.php?jv_page=$prev&rv_page=$rv_keep#jobViewsModal'>Prev</a></li>";
                                                                print "<li class='page-item disabled'><span class='page-link'>Page " . (int)$jobviews_page . " of " . (int)$jobviews_total_pages . "</span></li>";
                                                                print "<li class='page-item$next_disabled'><a class='page-link' href='index.php?jv_page=$next&rv_page=$rv_keep#jobViewsModal'>Next</a></li>";
                                                                ?>
                                                            </ul>
                                                        </nav>
                                                    <?php } ?>
                                                <?php } else { ?>
                                                    <div class="alert alert-warning mb-0">Analytics table <strong>page_visits</strong> not found.</div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <?php if ($has_page_visits_table) { ?>
                                    <div class="row mt-3">
                                        <div class="col-12 col-lg-6">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5 class="card-title mb-0">Most Visited Pages</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table class="table table-striped table-sm align-middle mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Page</th>
                                                                    <th class="text-end">Visits</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php foreach ($most_pages as $p) {
                                                                    $pu = htmlspecialchars($p['page_url']);
                                                                    $pc = (int)$p['c'];
                                                                    print "<tr><td style='word-break:break-all;'>$pu</td><td class='text-end'>$pc</td></tr>";
                                                                } ?>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12 col-lg-6">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5 class="card-title mb-0">Devices Used</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table class="table table-striped table-sm align-middle mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Device</th>
                                                                    <th class="text-end">Visits</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php foreach ($device_breakdown as $d) {
                                                                    $dt = htmlspecialchars($d['device_type']);
                                                                    $dc = (int)$d['c'];
                                                                    print "<tr><td>$dt</td><td class='text-end'>$dc</td></tr>";
                                                                } ?>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header d-flex align-items-center">
                                                    <h5 class="card-title mb-0">Recent Visits</h5>
                                                    <form method="get" class="ms-auto d-flex align-items-center">
                                                        <input type="hidden" name="rv_page" value="<?php print (int)$recent_page; ?>">
                                                        <input type="hidden" name="jv_page" value="<?php print (int)$jobviews_page; ?>">
                                                        <label class="me-2 mb-0 text-muted">Rows</label>
                                                        <select name="rv_limit" class="form-select form-select-sm me-2" onchange="this.form.submit()" style="width:auto;">
                                                            <?php
                                                            foreach ($allowed_limits as $lim) {
                                                                $sel = $lim === $recent_limit ? ' selected' : '';
                                                                print "<option value='$lim'$sel>$lim</option>";
                                                            }
                                                            ?>
                                                        </select>
                                                    </form>
                                                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteRecentModal">Delete All</button>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table class="table table-striped table-sm align-middle mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Page</th>
                                                                    <th>IP Address</th>
                                                                    <th>Device</th>
                                                                    <th>Location</th>
                                                                    <th>Time</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <?php foreach ($recent_visits as $v) {
                                                                    $pu = htmlspecialchars($v['page_url']);
                                                                    $ip = htmlspecialchars($v['ip_address']);
                                                                    $dv = htmlspecialchars($v['device_type']);
                                                                    $lc = htmlspecialchars($v['location']);
                                                                    $tm = htmlspecialchars($v['created_at']);
                                                                    print "<tr><td style='word-break:break-all;'>$pu</td><td>$ip</td><td>$dv</td><td>$lc</td><td>$tm</td></tr>";
                                                                } ?>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <?php if ($recent_total_pages > 1) { ?>
                                                        <nav class="mt-3" aria-label="Recent visits pagination">
                                                            <ul class="pagination pagination-sm mb-0">
                                                                <?php
                                                                $prev_rv = $recent_page - 1;
                                                                $next_rv = $recent_page + 1;
                                                                $jv_keep = (int)$jobviews_page;
                                                                $prev_disabled_rv = $recent_page <= 1 ? ' disabled' : '';
                                                                $next_disabled_rv = $recent_page >= $recent_total_pages ? ' disabled' : '';
                                                                $rv_lim_keep = (int)$recent_limit;
                                                                print "<li class='page-item$prev_disabled_rv'><a class='page-link' href='index.php?rv_page=$prev_rv&jv_page=$jv_keep&rv_limit=$rv_lim_keep'>Prev</a></li>";
                                                                print "<li class='page-item disabled'><span class='page-link'>Page " . (int)$recent_page . " of " . (int)$recent_total_pages . "</span></li>";
                                                                print "<li class='page-item$next_disabled_rv'><a class='page-link' href='index.php?rv_page=$next_rv&jv_page=$jv_keep&rv_limit=$rv_lim_keep'>Next</a></li>";
                                                                ?>
                                                            </ul>
                                                        </nav>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <?php } else { ?>
                                    <div class="row mt-3">
                                        <div class="col-12">
                                            <div class="alert alert-warning mb-0">Analytics table <strong>page_visits</strong> not found. Run the SQL migration to enable most visited pages, devices, and IP tracking.</div>
                                        </div>
                                    </div>
                                <?php } ?>

                    </div> <!-- end .h-100-->

                </div> <!-- end col -->


            </div>

        </div>
        <!-- container-fluid -->
    </div>
    <!-- End Page-content -->
    <?php include"footer.php";?>
