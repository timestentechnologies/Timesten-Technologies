<?php include "z_db.php";?>
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
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- Responsive css -->
    <link rel="stylesheet" href="assets/css/responsive.css">
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
    "sameAs": [
    "https://www.facebook.com/timestentechnologies",
    "https://twitter.com/timestentech",
    "https://linkedin.com/company/timestentechnologies"
  ]
  }
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
    $rt=mysqli_query($con,"SELECT ufile FROM logo where id=1");
    $tr = mysqli_fetch_array($rt);
    $ufile = "$tr[ufile]";
?>

                    <a class="navbar-brand" href="index.php">
                        <img class="navbar-brand-regular" src="dashboard/uploads/logo/<?php print $ufile?>" alt="brand-logo">
                        <img class="navbar-brand-sticky" src="dashboard/uploads/logo/<?php print $ufile?>" alt="sticky brand-logo"></a>
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

