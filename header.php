<?php include "z_db.php";?>
<?php
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
?>
<!doctype html>
<html class="no-js" lang="en">
<?php
    $rrs=mysqli_query($con,"SELECT * FROM section_title Where id=1");
$rs = mysqli_fetch_array($rrs);
$test_title = "$rs[test_title]";
$test_text="$rs[test_text]";
$enquiry_title="$rs[enquiry_title]";
$enquiry_text="$rs[enquiry_text]";
$enquiry_text="$rs[enquiry_text]";
$contact_title="$rs[contact_title]";
$contact_text="$rs[contact_text]";
$port_title="$rs[port_title]";
$port_text="$rs[port_text]";
$service_title="$rs[service_title]";
$service_text="$rs[service_text]";
$why_title="$rs[why_title]";
$why_text="$rs[why_text]";
$about_title="$rs[about_title]";
$about_text="$rs[about_text]";

$vision_text = isset($rs['vision_text']) ? $rs['vision_text'] : '';
$mission_text = isset($rs['mission_text']) ? $rs['mission_text'] : '';
$values_text = isset($rs['values_text']) ? $rs['values_text'] : '';
$impact_text = isset($rs['impact_text']) ? $rs['impact_text'] : '';

if (strlen(trim($vision_text)) < 1) {
    $vision_text = "To be the leading technology company in Africa and beyond, empowering businesses through innovative, reliable, and transformative digital solutions.";
}

if (strlen(trim($mission_text)) < 1) {
    $mission_text = "To provide high-end technology solutions that streamline business operations, enhance effectiveness and productivity, and optimize costs, enabling our clients to thrive in a digital-first world.";
}

if (strlen(trim($values_text)) < 1) {
    $values_text = "1. Integrity - We act with honesty, transparency, and accountability in all our interactions.\n\n2. Excellence - We strive for high-quality solutions that exceed client expectations.\n\n3. Innovation - We continuously embrace new ideas, technologies, and approaches to drive business transformation.\n\n4. Customer-Centricity - Our clients’ success is our top priority; we deliver solutions tailored to their needs.\n\n5. Collaboration & Teamwork - We believe in the power of partnerships, teamwork, and knowledge sharing to achieve superior results.\n\n6. Ethics & Responsibility - We conduct business responsibly, respecting people, society, and the environment.";
}

if (strlen(trim($impact_text)) < 1) {
    $impact_text = "By leveraging cutting-edge technology, Timesten Technologies empowers businesses to operate more efficiently, reduce operational costs, and scale sustainably, contributing to economic growth and digital transformation across Africa and beyond.";
}
?>



<?php
    $rt=mysqli_query($con,"SELECT * FROM sitecontact where id=1");
    $tr = mysqli_fetch_array($rt);
    $phone1 = "$tr[phone1]";
    $phone2 = "$tr[phone2]";
    $email1 = "$tr[email1]";
    $email2 = "$tr[email2]";
    $longitude = "$tr[longitude]";
    $latitude = "$tr[latitude]";
?>
<!-- Mirrored from theme-land.com/digimx/demo/index.php by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 11 Jul 2022 15:12:40 GMT -->
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta property="og:site_name" content="Timesten Technologies">

    <!-- SEO Meta Description -->
    <meta name="description" content="Timesten Technologies delivers top-tier technology services that help businesses succeed in the digital age. With a focus on quality and innovation." />
    <meta name="author" content="TimesTen Technologies">
    <?php
    $rr=mysqli_query($con,"SELECT * FROM siteconfig where id=1");
    $r = mysqli_fetch_array($rr);
    $site_title = "$r[site_title]";
    $site_about = "$r[site_about]";
    $site_footer = "$r[site_footer]";
    $follow_text = "$r[follow_text]";
?>
    <!-- Title  -->
    <title><?php print $site_title ?> - Leading Tech Solutions in Kenya</title>

    <!-- Favicon  -->
    <link rel="icon" href="assets/img/Timestenfavicon.png">

    <!-- ***** All CSS Files ***** -->

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Style css -->
    <link rel="stylesheet" href="assets/css/style.css?v=<?php print @filemtime('assets/css/style.css'); ?>">

    <!-- Responsive css -->
    <link rel="stylesheet" href="assets/css/responsive.css?v=<?php print @filemtime('assets/css/responsive.css'); ?>">
    <script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What services does Timesten Technologies offer?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Timesten Technologies provides a wide range of tech services including website development, mobile app development, cloud solutions, and custom software development tailored to businesses."
      }
    },
    {
      "@type": "Question",
      "name": "Where is Timesten Technologies located?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Timesten Technologies is based in Kenya and offers digital solutions to clients locally and globally."
      }
    },
    {
      "@type": "Question",
      "name": "How can I contact Timesten Technologies?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "You can contact us through our website contact form or by email at timestenkenya@gmail.com. We’re also available on phone at +254718883983."
      }
    },
    {
      "@type": "Question",
      "name": "Does Timesten Technologies build eCommerce websites?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Yes, we specialize in building fully functional eCommerce websites including payment gateway integration and inventory management features."
      }
    },
    {
      "@type": "Question",
      "name": "What industries does Timesten Technologies serve?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "We serve a wide range of industries including education, healthcare, retail, logistics, and fintech with customized technology solutions."
      }
    }
  ]
}
</script>
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Timesten Technologies",
  "url": "https://timestentechnologies.co.ke",
  "logo": "https://timestentechnologies.co.ke/dashboard/uploads/logo/46176917logo.png",
  "description": "TimesTen Technologies offers smart digital solutions including web development, POS systems, AI automation, API integration, and ERP systems.",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "Our Services",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Intelligent POS Systems",
          "description": "Feature-rich Point of Sale systems for retail and hospitality businesses."
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "AI-Driven Automation & Data Analytics",
          "description": "Use AI to automate tasks and gain insights for better decision-making."
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Graphic Design & Brand Identity",
          "description": "Creative graphic design services to establish a strong brand presence."
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "API Integration Services",
          "description": "Connect systems and enhance functionality through seamless API integration."
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Smart ERP Systems",
          "description": "Agile ERP solutions that streamline operations and support strategic growth."
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Web Development & SEO",
          "description": "Responsive and SEO-optimized websites with custom graphics."
        }
      }
    ]
  },
  "sameAs": [
    "https://www.facebook.com/timestentechnologies",
    "https://twitter.com/timestentech",
    "https://linkedin.com/company/timestentechnologies"
  ]
}
</script>

    <style>
    .navbar-brand-regular,
.navbar-brand-sticky {
    width: 200px; /* Adjust the width as needed */
    height: auto; /* Maintain aspect ratio */
    filter: brightness(1.1) contrast(1.2); /* Enhance image clarity */
}

</style>

</head>

<body>
    <!--====== Preloader Area Start ======-->
    <div id="preloader">
        <!-- Digimax Preloader -->
        <div id="digimax-preloader" class="digimax-preloader">
            <!-- Preloader Animation -->
            <div class="preloader-animation">
                <!-- Spinner -->
                <div class="spinner"></div>
                <!-- Loader -->
                <div class="loader">
                    <span data-text-preloader="T" class="animated-letters">T</span>
                    <span data-text-preloader="I" class="animated-letters">I</span>
                    <span data-text-preloader="M" class="animated-letters">M</span>
                    <span data-text-preloader="E" class="animated-letters">E</span>
                    <span data-text-preloader="S" class="animated-letters">S</span>
                    <span data-text-preloader="T" class="animated-letters">T</span>
                    <span data-text-preloader="E" class="animated-letters">E</span>
                    <span data-text-preloader="N" class="animated-letters">N</span>
                    <span data-text-preloader="T" class="animated-letters">T</span>
                    <span data-text-preloader="E" class="animated-letters">E</span>
                    <span data-text-preloader="C" class="animated-letters">C</span>
                    <span data-text-preloader="H" class="animated-letters">H</span>
                    <span data-text-preloader="N" class="animated-letters">N</span>
                    <span data-text-preloader="O" class="animated-letters">O</span>
                    <span data-text-preloader="L" class="animated-letters">L</span>
                    <span data-text-preloader="O" class="animated-letters">O</span>
                    <span data-text-preloader="G" class="animated-letters">G</span>
                    <span data-text-preloader="I" class="animated-letters">I</span>
                    <span data-text-preloader="E" class="animated-letters">E</span>
                    <span data-text-preloader="S" class="animated-letters">S</span>
                </div>
                <p class="fw-5 text-center text-uppercase">Connecting...</p>
            </div>
            <!-- Loader Animation -->
            <div class="loader-animation">
                <div class="row h-100">
                    <!-- Single Loader -->
                    <div class="col-3 single-loader p-0">
                        <div class="loader-bg"></div>
                    </div>
                    <!-- Single Loader -->
                    <div class="col-3 single-loader p-0">
                        <div class="loader-bg"></div>
                    </div>
                    <!-- Single Loader -->
                    <div class="col-3 single-loader p-0">
                        <div class="loader-bg"></div>
                    </div>
                    <!-- Single Loader -->
                    <div class="col-3 single-loader p-0">
                        <div class="loader-bg"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--====== Preloader Area End ======-->

    <!--====== Scroll To Top Area Start ======-->
    <!--<div id="scrollUp" title="Scroll To Top">-->
    <!--    <i class="fas fa-arrow-up"></i>-->
    <!--</div>-->
    <!--====== Scroll To Top Area End ======-->

    <div class="main overflow-hidden">
        <!-- ***** Header Start ***** -->
        <header id="header">
            <!-- Navbar -->
            <nav data-aos="zoom-out" data-aos-delay="800" class="navbar navbar-expand">
                <div class="container header">
                    <!-- Navbar Brand-->
                    <?php
    $sticky_ufile = "";
    $has_sticky_col = false;
    $col_rs = mysqli_query($con, "SHOW COLUMNS FROM logo LIKE 'sticky_ufile'");
    if ($col_rs && mysqli_num_rows($col_rs) > 0) {
        $has_sticky_col = true;
    }

    if ($has_sticky_col) {
        $rt=mysqli_query($con,"SELECT ufile, sticky_ufile FROM logo where id=1");
        $tr = mysqli_fetch_array($rt);
        $ufile = "$tr[ufile]";
        $sticky_ufile = isset($tr['sticky_ufile']) ? $tr['sticky_ufile'] : "";
    } else {
        $rt=mysqli_query($con,"SELECT ufile FROM logo where id=1");
        $tr = mysqli_fetch_array($rt);
        $ufile = "$tr[ufile]";
    }

    $sticky_logo_to_use = $ufile;
    if (!empty($sticky_ufile) && strlen(trim($sticky_ufile)) > 0) {
        $sticky_logo_to_use = $sticky_ufile;
    }
?>

                    <a class="navbar-brand" href="index.php">
                        <img class="navbar-brand-regular" src="dashboard/uploads/logo/<?php print $ufile?>" alt="brand-logo">
                        <img class="navbar-brand-sticky" src="dashboard/uploads/logo/<?php print $sticky_logo_to_use?>" alt="sticky brand-logo"></a>
                    <div class="ml-auto"></div>
                    <!-- Navbar -->
                    <ul class="navbar-nav items">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Home </a>

                        </li>
                        <li class="nav-item">
                            <a href="about" class="nav-link">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a href="services" class="nav-link">Services</a>
                        </li>
                        <li class="nav-item">
                            <a href="portfolio" class="nav-link">Portfolio</a>
                        </li>

                        <li class="nav-item">
                            <a href="blog" class="nav-link">Blog</a>
                        </li>

                        <li class="nav-item">
                            <a href="careers" class="nav-link">Careers</a>
                        </li>

                    </ul>
                    <!-- Navbar Icons -->
                    <ul class="navbar-nav icons">
                    <?php
   $q="SELECT * FROM  social ORDER BY id DESC LIMIT 5";
 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$id="$ro[id]";
    $fa="$ro[fa]";
    $social_link="$ro[social_link]";

print "
<li class='nav-item social'>
<a href='$social_link' class='nav-link'><i class='fab $fa'></i></a>
</li>
";
error_reporting(E_ALL);
ini_set('display_errors', 1);
}?>
                    </ul>

                    <!-- Navbar Toggler -->
                    <ul class="navbar-nav toggle">
                        <li class="nav-item">
                            <a href="#" class="nav-link" data-toggle="modal" data-target="#menu">
                                <i class="fas fa-bars toggle-icon m-0"></i>
                            </a>
                        </li>
                    </ul>

                    <!-- Navbar Action Button -->
                    <ul class="navbar-nav action">
                        <li class="nav-item ml-3">
                            <a href="contact" class="btn ml-lg-auto btn-bordered-white"><i class="fas fa-paper-plane contact-icon mr-md-2"></i>Contact Us</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        </div>
        <!-- ***** Header End ***** -->

