<?php
include "z_db.php";


session_start();
// Check, if username session is NOT set then this page will jump to login page

if (!isset($_SESSION['username'])) {
        print "
				<script language='javascript'>
					window.location = 'login.php';
				</script>
			";
}

// Check, if username session is NOT set then this page will jump to login page
if (isset($_SESSION['username'])) {

 $username = $_SESSION['username'];
}
 else {
    print "
				<script language='javascript'>
					window.location = 'login.php';
				</script>
			";
}

$has_page_visits_table = false;
$pv_rs = mysqli_query($con, "SHOW TABLES LIKE 'page_visits'");
if ($pv_rs && mysqli_num_rows($pv_rs) > 0) {
    $has_page_visits_table = true;
}

if ($has_page_visits_table) {
    $page_url = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '';
    $ip = '';
    if (!empty($_SERVER['HTTP_CF_CONNECTING_IP'])) {
        $ip = $_SERVER['HTTP_CF_CONNECTING_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $parts = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
        $ip = trim($parts[0]);
    } elseif (!empty($_SERVER['REMOTE_ADDR'])) {
        $ip = $_SERVER['REMOTE_ADDR'];
    }

    $user_agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';
    $ua_l = strtolower($user_agent);
    $device = 'Desktop';
    if (strpos($ua_l, 'mobile') !== false || strpos($ua_l, 'android') !== false || strpos($ua_l, 'iphone') !== false) {
        $device = 'Mobile';
    }
    if (strpos($ua_l, 'ipad') !== false || strpos($ua_l, 'tablet') !== false) {
        $device = 'Tablet';
    }

    $location = 'Unknown';
    $ip_s_lookup = mysqli_real_escape_string($con, $ip);
    if (strlen(trim($ip)) > 0) {
        if ($ip === '127.0.0.1' || $ip === '::1' || preg_match('/^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1])\.)/', $ip)) {
            $location = 'Local';
        } else {
            $loc_rs = mysqli_query($con, "SELECT location FROM page_visits WHERE ip_address='$ip_s_lookup' AND location IS NOT NULL AND location<>'' AND location<>'Unknown' ORDER BY id DESC LIMIT 1");
            if ($loc_rs) {
                $loc_row = mysqli_fetch_assoc($loc_rs);
                if ($loc_row && !empty($loc_row['location'])) {
                    $location = $loc_row['location'];
                }
            }

            if ($location === 'Unknown') {
                $geo_json = false;
                if (function_exists('curl_init')) {
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_URL, 'https://ip-api.com/json/' . urlencode($ip) . '?fields=status,country,regionName,city');
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 2);
                    curl_setopt($ch, CURLOPT_TIMEOUT, 3);
                    curl_setopt($ch, CURLOPT_USERAGENT, 'TimestenAnalytics/1.0');
                    $geo_json = curl_exec($ch);
                    curl_close($ch);
                }

                if ($geo_json === false && ini_get('allow_url_fopen')) {
                    $ctx = stream_context_create([
                        'http' => [
                            'timeout' => 2,
                            'header' => "User-Agent: TimestenAnalytics/1.0\r\n"
                        ]
                    ]);
                    $geo_json = @file_get_contents('https://ip-api.com/json/' . urlencode($ip) . '?fields=status,country,regionName,city', false, $ctx);
                }

                if ($geo_json !== false) {
                    $geo = json_decode($geo_json, true);
                    if (is_array($geo) && isset($geo['status']) && $geo['status'] === 'success') {
                        $parts = [];
                        if (!empty($geo['city'])) { $parts[] = $geo['city']; }
                        if (!empty($geo['regionName'])) { $parts[] = $geo['regionName']; }
                        if (!empty($geo['country'])) { $parts[] = $geo['country']; }
                        if (count($parts) > 0) {
                            $location = implode(', ', $parts);
                        }
                    }
                }
            }

            if ($location === 'Unknown') {
                $geo_json2 = false;
                if (function_exists('curl_init')) {
                    $ch2 = curl_init();
                    curl_setopt($ch2, CURLOPT_URL, 'https://ipapi.co/' . urlencode($ip) . '/json/');
                    curl_setopt($ch2, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch2, CURLOPT_CONNECTTIMEOUT, 2);
                    curl_setopt($ch2, CURLOPT_TIMEOUT, 3);
                    curl_setopt($ch2, CURLOPT_USERAGENT, 'TimestenAnalytics/1.0');
                    $geo_json2 = curl_exec($ch2);
                    curl_close($ch2);
                }

                if ($geo_json2 === false && ini_get('allow_url_fopen')) {
                    $ctx2 = stream_context_create([
                        'http' => [
                            'timeout' => 2,
                            'header' => "User-Agent: TimestenAnalytics/1.0\r\n"
                        ]
                    ]);
                    $geo_json2 = @file_get_contents('https://ipapi.co/' . urlencode($ip) . '/json/', false, $ctx2);
                }

                if ($geo_json2 !== false) {
                    $geo2 = json_decode($geo_json2, true);
                    if (is_array($geo2) && empty($geo2['error'])) {
                        $parts2 = [];
                        if (!empty($geo2['city'])) { $parts2[] = $geo2['city']; }
                        if (!empty($geo2['region'])) { $parts2[] = $geo2['region']; }
                        if (!empty($geo2['country_name'])) { $parts2[] = $geo2['country_name']; }
                        if (count($parts2) > 0) {
                            $location = implode(', ', $parts2);
                        }
                    }
                }
            }

            if ($location === 'Unknown') {
                $location = 'Lookup failed';
            }
        }
    }

    $page_url_s = mysqli_real_escape_string($con, $page_url);
    $ip_s = $ip_s_lookup;
    $ua_s = mysqli_real_escape_string($con, $user_agent);
    $device_s = mysqli_real_escape_string($con, $device);
    $location_s = mysqli_real_escape_string($con, $location);
    mysqli_query($con, "INSERT INTO page_visits (page_url, ip_address, user_agent, device_type, location, created_at) VALUES ('$page_url_s', '$ip_s', '$ua_s', '$device_s', '$location_s', NOW())");
}

// Favicon from logo settings (xfile)
$favicon_path = 'assets/images/Timestenfavicon.png';
$header_logo_path_sm = 'assets/images/logo-sm.png';
$header_logo_path_lg = 'assets/images/logo-dark.png';
$logo_rs = mysqli_query($con, "SELECT xfile FROM logo LIMIT 1");
if ($logo_rs) {
    $logo_row = mysqli_fetch_assoc($logo_rs);
    if ($logo_row && !empty($logo_row['xfile'])) {
        $favicon_path = 'uploads/logo/' . $logo_row['xfile'];
    }
}

// Header logo from logo settings (ufile)
$logo_rs2 = mysqli_query($con, "SELECT ufile FROM logo LIMIT 1");
if ($logo_rs2) {
    $logo_row2 = mysqli_fetch_assoc($logo_rs2);
    if ($logo_row2 && !empty($logo_row2['ufile'])) {
        $header_logo_path_sm = 'uploads/logo/' . $logo_row2['ufile'];
        $header_logo_path_lg = 'uploads/logo/' . $logo_row2['ufile'];
    }
}

?>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">


<!-- Mirrored from themesbrand.com/velzon/html/default/index.php by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 24 Jun 2022 20:35:42 GMT -->
<head>

    <meta charset="utf-8" />
    <title>TimesTen Technologies | Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="TimesTen Technologies" name="description" />
    <meta content="Themesbrand" name="author" />
    <base href="/dashboard/">
    <!-- App favicon -->
    <link rel="shortcut icon" href="<?php echo htmlspecialchars($favicon_path); ?>">

    <!-- jsvectormap css -->
    <link href="assets/libs/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css" />

    <!--Swiper slider css-->
    <link href="assets/libs/swiper/swiper-bundle.min.css" rel="stylesheet" type="text/css" />

    <!-- Layout config Js -->
    <script src="assets/js/layout.js"></script>
    <!-- Bootstrap Css -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <!-- custom Css-->
    <link href="assets/css/custom.min.css?v=<?php echo filemtime('assets/css/custom.min.css'); ?>" rel="stylesheet" type="text/css" />

    <style>
        :root { --admin-topbar-offset: 80px; }
        #page-topbar { z-index: 2000 !important; }
        .modal-backdrop { z-index: 1040 !important; }
        .modal { z-index: 1050 !important; top: var(--admin-topbar-offset) !important; height: calc(100% - var(--admin-topbar-offset)) !important; }
        .modal-dialog { margin-top: 1rem; }

        @media (min-width: 1400px) {
            .mt-xxl-n5 { margin-top: 1rem !important; }
        }
    </style>

</head>

<body>

    <!-- Begin page -->
    <div id="layout-wrapper">

        <header id="page-topbar">
    <div class="layout-width">
        <div class="navbar-header">
            <div class="d-flex">
                <!-- LOGO -->
                <div class="navbar-brand-box horizontal-logo">
                    <a href="index.php" class="logo logo-dark">
                        <span class="logo-sm">
                            <img src="<?php print htmlspecialchars($header_logo_path_sm); ?>" alt="" height="22">
                        </span>
                        <span class="logo-lg">
                            <img src="<?php print htmlspecialchars($header_logo_path_lg); ?>" alt="" height="17">
                        </span>
                    </a>

                    <a href="index.php" class="logo logo-light">
                        <span class="logo-sm">
                            <img src="<?php print htmlspecialchars($header_logo_path_sm); ?>" alt="" height="22">
                        </span>
                        <span class="logo-lg">
                            <img src="<?php print htmlspecialchars($header_logo_path_lg); ?>" alt="" height="17">
                        </span>
                    </a>
                </div>

                <!-- App Search-->

            </div>

            <div class="d-flex align-items-center">

                <button type="button" class="btn btn-sm px-3 fs-16 header-item vertical-menu-btn topnav-hamburger" id="topnav-hamburger-icon" aria-label="Toggle Sidebar">
                    <span class="hamburger-icon">
                        <span></span>
                        <span></span>
                        <span></span>
                    </span>
                </button>

                <div class="dropdown d-md-none topbar-head-dropdown header-item">
                    <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle"
                        id="page-header-search-dropdown" data-bs-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false">
                        <i class="bx bx-search fs-22"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
                        aria-labelledby="page-header-search-dropdown">
                        <form class="p-3">
                            <div class="form-group m-0">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search ..."
                                        aria-label="Recipient's username">
                                    <button class="btn btn-primary" type="submit"><i
                                            class="mdi mdi-magnify"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>



                <div class="ms-1 header-item d-none d-sm-flex">
                    <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle"
                        data-toggle="fullscreen">
                        <i class='bx bx-fullscreen fs-22'></i>
                    </button>
                </div>

                <div class="ms-1 header-item d-none d-sm-flex">
                    <button type="button"
                        class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle light-dark-mode">
                        <i class='bx bx-moon fs-22'></i>
                    </button>
                </div>


                <div class="dropdown ms-sm-3 header-item topbar-user">
                    <button type="button" class="btn" id="page-header-user-dropdown" data-bs-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        <span class="d-flex align-items-center">

                            <span class="text-start ms-xl-2">
                                <span class="d-none d-xl-inline-block ms-1 fw-medium user-name-text"><?php print $username;?></span>

                            </span>
                        </span>
                    </button>
                    <div class="dropdown-menu dropdown-menu-end">
                        <!-- item-->
                        <h6 class="dropdown-header">Welcome <?php print $username;?>!</h6>

                        <a class="dropdown-item" href="profile.php"><i
                                class="mdi mdi-account-circle text-muted fs-16 align-middle me-1"></i> <span
                                class="align-middle">Profile</span></a>

                        <a class="dropdown-item" href="logout"><i
                                class="mdi mdi-logout text-muted fs-16 align-middle me-1"></i> <span
                                class="align-middle" data-key="t-logout">Logout</span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
