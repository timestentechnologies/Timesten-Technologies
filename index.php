<?php include "header.php"; ?>
<?php
    $static_rs = mysqli_query($con, "SELECT * FROM static WHERE id=1 LIMIT 1");
    $static_row = $static_rs ? mysqli_fetch_assoc($static_rs) : null;
    $stitle = $static_row && isset($static_row['stitle']) ? $static_row['stitle'] : '';
    $stext = $static_row && isset($static_row['stext']) ? $static_row['stext'] : '';

    $use_slider_mode = false;
    if ($static_row && array_key_exists('slider_mode', $static_row)) {
        $use_slider_mode = ((int)$static_row['slider_mode']) === 1;
    }

    $static_show_cartoon = true;
    if ($static_row && array_key_exists('show_cartoon', $static_row)) {
        $static_show_cartoon = ((int)$static_row['show_cartoon']) === 1;
    }
?>
        <!-- ***** Welcome Area Start ***** -->
        <section id="home" class="section welcome-area bg-overlay overflow-hidden d-flex align-items-center">
            <?php
                $slider_rs = mysqli_query($con, "SELECT * FROM slider ORDER BY id DESC");
                $slider_items = [];
                if ($slider_rs) {
                    while ($srow = mysqli_fetch_assoc($slider_rs)) {
                        $slider_items[] = $srow;
                    }
                }
            ?>

            <?php if ($use_slider_mode && count($slider_items) > 0) { ?>
                <style>
                    .welcome-slider,
                    .welcome-slider .owl-stage-outer,
                    .welcome-slider .owl-stage,
                    .welcome-slider .owl-item,
                    .welcome-slider .welcome-slide {
                        height: 100%;
                    }

                    #heroRow.hero-align-right {
                        flex-direction: row-reverse;
                    }

                    #heroRow.hero-align-right .welcome-intro {
                        text-align: right;
                    }

                    #heroRow.hero-hide-cartoon #heroCartoonCol {
                        display: none;
                    }

                    #heroRow.hero-hide-cartoon #heroTextCol {
                        flex: 0 0 100%;
                        max-width: 100%;
                    }

                    #home .container {
                        position: relative;
                        z-index: 2;
                    }

                    #heroSlideTitle,
                    #heroSlideText {
                        color: #fff;
                        text-shadow: 0 2px 14px rgba(0,0,0,.85);
                    }

                    #heroSlideText {
                        font-weight: 500;
                        opacity: 0.98;
                    }
                </style>
                <div class="welcome-slider owl-carousel" style="position:absolute;inset:0;z-index:0;">
                    <?php
                        foreach ($slider_items as $srow) {
                            $ufile = isset($srow['ufile']) ? $srow['ufile'] : '';
                            $bg = htmlspecialchars($ufile);
                            $slide_title = isset($srow['slide_title']) ? $srow['slide_title'] : '';
                            $slide_text = isset($srow['slide_text']) ? $srow['slide_text'] : '';
                            $text_align = (isset($srow['text_align']) && $srow['text_align'] === 'right') ? 'right' : 'left';
                            $show_cartoon = (isset($srow['show_cartoon']) && (int)$srow['show_cartoon'] === 0) ? '0' : '1';
                            $data_title = htmlspecialchars($slide_title, ENT_QUOTES);
                            $data_text = htmlspecialchars($slide_text, ENT_QUOTES);
                            print "<div class='welcome-slide' data-slide-title='$data_title' data-slide-text='$data_text' data-text-align='$text_align' data-show-cartoon='$show_cartoon' style=\"width:100%;height:100%;background-image:url('dashboard/uploads/slider/$bg');background-size:cover;background-position:center;\"></div>";
                        }
                    ?>
                </div>
                <div style="position:absolute;inset:0;z-index:1;background:rgba(0,0,0,.65);"></div>
            <?php } ?>

            <div class="container">
            <!DOCTYPE html>
<html>
<head>
    <style>
        .star {
            position: absolute;
            background-color: white;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            font-weight:bold;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
        }
       
    </style>
</head>
<body>
    <div id="stars-container"></div>
    
    <script>
        <?php
        // Number of stars
        $numStars = 50;

        // Maximum star size
        $maxSize = 5;

        echo "var stars = [";
        for ($i = 0; $i < $numStars; $i++) {
            $x = mt_rand(0, 100);
            $y = mt_rand(0, 100);
            $size = mt_rand(1, $maxSize);
            echo "{ x: $x, y: $y, size: $size }";
            if ($i < $numStars - 1) {
                echo ",";
            }
        }
        echo "];";
        ?>

        const container = document.getElementById('stars-container');
        stars.forEach(star => {
            const el = document.createElement('div');
            el.classList.add('star');
            el.style.width = `${star.size}px`;
            el.style.height = `${star.size}px`;
            el.style.left = `${star.x}%`;
            el.style.top = `${star.y}%`;
            container.appendChild(el);
        });

        animateStars();

        function animateStars() {
            const starElements = document.querySelectorAll('.star');
            starElements.forEach(star => {
                const x = Math.random() * 100;
                const y = Math.random() * 100;
                const duration = Math.random() * 5 + 1;
                const delay = Math.random() * 3;
                star.style.transition = `transform ${duration}s ease-in-out ${delay}s, opacity 0.9s`;
                star.style.transform = `translate(${x}%, ${y}%)`;
                star.style.opacity = '1';

                setTimeout(() => {
                    star.style.transition = `opacity 0.3s`;
                    star.style.opacity = '0';
                }, 1000);
            });
            setTimeout(animateStars, 2000);
        }
    </script>
</body>
</html>
         
                <?php
                    $first_align = 'left';
                    $first_show_cartoon = $static_show_cartoon ? '1' : '0';

                    if ($use_slider_mode && count($slider_items) > 0) {
                        $first_slide = $slider_items[0];
                        if (isset($first_slide['text_align']) && $first_slide['text_align'] === 'right') {
                            $first_align = 'right';
                        }
                        if (isset($first_slide['show_cartoon']) && (int)$first_slide['show_cartoon'] === 0) {
                            $first_show_cartoon = '0';
                        } else {
                            $first_show_cartoon = '1';
                        }
                    }

                    $hero_row_class = '';
                    if ($use_slider_mode && count($slider_items) > 0 && $first_align === 'right') {
                        $hero_row_class .= ' hero-align-right';
                    }
                    if ($first_show_cartoon === '0') {
                        $hero_row_class .= ' hero-hide-cartoon';
                    }
                ?>
                <div class="row align-items-center<?php print $hero_row_class; ?>" id="heroRow">
                    <!-- Welcome Intro Start -->
                    <div class="col-12 col-md-7" id="heroTextCol">
                        <div class="welcome-intro">
                            <?php if ($use_slider_mode && count($slider_items) > 0) { ?>
                                <?php
                                    $first_slide = $slider_items[0];
                                    $first_title = isset($first_slide['slide_title']) && strlen(trim($first_slide['slide_title'])) > 0 ? $first_slide['slide_title'] : $stitle;
                                    $first_text = isset($first_slide['slide_text']) && strlen(trim($first_slide['slide_text'])) > 0 ? $first_slide['slide_text'] : $stext;
                                ?>
                                <h1 class="text-white" id="heroSlideTitle"><?php print htmlspecialchars($first_title); ?></h1>
                                <p class="text-white my-4" id="heroSlideText"><?php print htmlspecialchars($first_text); ?></p>
                            <?php } else { ?>
                                <h1 class="text-white"><?php print $stitle?></h1>
                                <p class="text-white my-4"><?php print $stext?></p>
                            <?php } ?>
                            <!-- Buttons -->
                            <div class="button-group mb-5">
                                <a href="portfolio.php" class="btn btn-bordered-white">Browse Projects</a>
                                <a href="contact.php" class="btn btn-bordered-white">Contact Us</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-5" id="heroCartoonCol">
                        <!-- Welcome Thumb -->
                        <div class="welcome-thumb-wrapper mt-5 mt-md-0">
                            <span class="welcome-thumb-1">
                                <img class="welcome-animation d-block ml-auto" src="assets/img/welcome/thumb_1.png" alt="">
                            </span>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Shape Bottom -->
            <div class="shape shape-bottom" style="z-index: 0;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>
        <!-- ***** Welcome Area End ***** -->

        <!-- ***** Promo Area Start ***** -->
        <section class="section promo-area ptb_100">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <!-- Section Heading -->
                        <div class="section-heading text-left">
                            <h2><?php print $why_title; ?></h2>
                            <p class="d-none d-sm-block mt-4"><?php print $why_text; ?></p>
                        </div>
                    </div>
                </div>
                <div class="row">


                <?php
				   $q="SELECT * FROM  why_us ORDER BY id DESC LIMIT 3";


 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$title="$ro[title]";
	$detail="$ro[detail]";

print "
<div class='col-12 col-md-6 col-lg-4 res-margin'>
<!-- Single Promo -->
<div class='single-promo color-1 bg-hover hover-bottom text-center p-5'>
    <h3 class='mb-3'>$title</h3>
    <p>$detail</p>
</div>
</div>
";
}
?>




                </div>
            </div>
        </section>
        <!-- ***** Promo Area End ***** -->

        <!-- ***** Content Area Start ***** -->

        <!-- ***** Content Area End ***** -->

        <!-- ***** Content Area Start ***** -->

        <!-- ***** Content Area End ***** -->

        <!-- ***** Service Area End ***** -->
        <section id="service" class="section service-area bg-grey ptb_150">
            <!-- Shape Top -->
            <div class="shape shape-top">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
                c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
                c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <!-- Section Heading -->
                        <div class="section-heading text-left">
                            <h2><?php print $service_title?></h2>
                            <p class="d-none d-sm-block mt-4"><?php print $service_text?></p>
                        </div>
                    </div>
                </div>
                <div class="row g-4">

                <?php
				   $qs="SELECT * FROM  service ORDER BY id DESC LIMIT 6";


 $r1 = mysqli_query($con,$qs);

while($rod = mysqli_fetch_array($r1))
{
	$id="$rod[id]";
	$serviceg="$rod[service_title]";
	$service_desc="$rod[service_desc]";

print "
<div class='col-12 col-md-6 col-lg-4 mb-4'>
<!-- Single Service -->
<div class='single-service p-5 h-100 position-relative' style='background: #fff; border-radius: 16px; border-top: 4px solid #f67011; box-shadow: 0 4px 20px rgba(0,0,0,0.08); transition: all 0.3s ease;'>
    <h3 class='mb-3' style='color: #3b1b6a; font-weight: 700; font-size: 20px;'>$serviceg</h3>
    <p style='color: #666; line-height: 1.6; margin-bottom: 20px;'>$service_desc</p>
    <a class='btn' style='background: linear-gradient(135deg, #f67011 0%, #ff8c42 100%); color: #fff; border-radius: 8px; padding: 10px 25px; font-weight: 600; transition: all 0.3s ease;' href='servicedetail.php?id=$id'>Learn More</a>
</div>
</div>

";
}
?>
                   </div>
            </div>
            <!-- Shape Bottom -->
            <div class="shape shape-bottom" style="z-index: 0;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>
        <!-- ***** Service Area End ***** -->

        <!-- ***** Portfolio Area Start ***** -->
        <section id="portfolio" class="portfolio-area overflow-hidden ptb_100">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <!-- Section Heading -->
                        <div class="section-heading text-left">
                            <h2><?php print $port_title?></h2>
                            <p class="mt-4 mb-5"><?php print $port_text?></p>
                        </div>
                    </div>
                </div>
                <!-- Portfolio Items -->
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="row g-5">

                        <?php
                           $q="SELECT * FROM  portfolio ORDER BY id DESC LIMIT 6";

                        $r123 = mysqli_query($con,$q);

                        while($ro = mysqli_fetch_array($r123))
                        {

                            $id="$ro[id]";
                            $port_title="$ro[port_title]";
                            $port_desc="$ro[port_desc]";
                            $ufile="$ro[ufile]";

                        print "
                        <div class='col-12 col-sm-6 col-lg-4 mb-4'>
                            <div class='single-case-studies h-100'>
                                <a href='portdetail.php?id=$id' class='d-block position-relative overflow-hidden rounded-3'>
                                    <img src='dashboard/uploads/portfolio/$ufile' alt='$port_title' class='w-100 h-100 object-fit-cover' style='aspect-ratio: 16/9;'>
                                </a>
                                <div class='text-center mt-2 px-2 pb-3'>
                                    <h5 class='fw-bold mb-1'>$port_title</h5>
                                    <p class='mb-0 small'>$port_desc</p>
                                </div>
                            </div>
                        </div>
                        ";
                        }
                        ?>

                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-12 text-center">
                        <a href="portfolio" class="btn btn-bordered mt-5">View More</a>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Portfolio Area End ***** -->

        <!-- ***** Price Plan Area Start ***** (COMMENTED OUT)

        <?php
            include_once "pricing_data.php";
            $pricing_settings = pricing_get_settings($con);
            $pricing_plans = pricing_get_plans($con, true);

            $pricing_heading = $pricing_settings && isset($pricing_settings['heading']) ? $pricing_settings['heading'] : 'Pricing Plans';
            $pricing_subheading = $pricing_settings && isset($pricing_settings['subheading']) ? $pricing_settings['subheading'] : '';
        ?>
        <section id="pricing" class="section bg-grey ptb_150 position-relative">
            <div class="shape shape-top" style="z-index: 0;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
                c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
                c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
            <div class="container" style="position: relative; z-index: 1;">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-7">
                        <div class="section-heading text-center">
                            <h2><?php print htmlspecialchars($pricing_heading); ?></h2>
                            <?php if (strlen(trim($pricing_subheading)) > 0) { ?>
                                <p class="d-none d-sm-block mt-4"><?php print htmlspecialchars($pricing_subheading); ?></p>
                            <?php } ?>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center align-items-stretch">
                    <?php foreach ($pricing_plans as $plan) {
                        $name = isset($plan['name']) ? $plan['name'] : '';
                        $price = isset($plan['price']) ? $plan['price'] : '';
                        $period = isset($plan['billing_period']) ? $plan['billing_period'] : '';
                        $desc = isset($plan['short_desc']) ? $plan['short_desc'] : '';
                        $features = isset($plan['features']) ? $plan['features'] : '';
                        $featured = isset($plan['is_featured']) && (int)$plan['is_featured'] === 1;
                        $btn_text = isset($plan['button_text']) && strlen(trim($plan['button_text'])) > 0 ? $plan['button_text'] : 'Contact Us';
                        $btn_link = isset($plan['button_link']) && strlen(trim($plan['button_link'])) > 0 ? $plan['button_link'] : 'contact';

                        $feature_items = [];
                        foreach (preg_split("/\r\n|\r|\n/", (string)$features) as $line) {
                            $line = trim($line);
                            if (strlen($line) > 0) {
                                $feature_items[] = $line;
                            }
                        }
                    ?>
                        <div class="col-12 col-md-6 col-lg-4 mb-4 d-flex">
                            <div class="single-price-plan text-center p-5 w-100 position-relative d-flex flex-column" style="
                                border: solid 1px #e6e6e6;
                                border-radius: 14px;
                                border-top: 4px solid #f67011;
                                min-height: 100%;
                                <?php print $featured ? 'box-shadow: 0 18px 45px rgba(246,112,17,0.15);' : ''; ?>">
                                <?php if ($featured) { ?>
                                    <div class="popular-badge" style="
                                        position: absolute;
                                        top: -12px;
                                        right: 20px;
                                        background: linear-gradient(135deg, #f67011 0%, #ff8c42 100%);
                                        color: #fff;
                                        font-size: 12px;
                                        font-weight: 600;
                                        padding: 5px 15px;
                                        border-radius: 20px;
                                        text-transform: uppercase;
                                        letter-spacing: 0.5px;
                                        box-shadow: 0 4px 12px rgba(246,112,17,0.3);
                                    ">Most Popular</div>
                                <?php } ?>
                                <div class="flex-grow-1">
                                    <h3 class="mb-2"><?php print htmlspecialchars($name); ?></h3>
                                    <div class="my-3" style="font-size: 34px; font-weight: 800; color: #3b1b6a;">
                                        <?php print htmlspecialchars($price); ?>
                                    </div>
                                    <?php if (strlen(trim($period)) > 0) { ?>
                                        <div class="text-muted mb-3" style="font-size: 14px;">
                                            <?php print htmlspecialchars($period); ?>
                                        </div>
                                    <?php } ?>
                                    <?php if (strlen(trim($desc)) > 0) { ?>
                                        <p class="mb-4" style="font-size: 15px; color: #555;"><?php print htmlspecialchars($desc); ?></p>
                                    <?php } ?>

                                    <?php if (count($feature_items) > 0) { ?>
                                        <ul class="list-unstyled text-start mb-0 px-2" style="width: 100%;">
                                            <?php foreach ($feature_items as $fi) { ?>
                                                <li class="mb-2 d-flex align-items-start" style="font-size: 13px; line-height: 1.4;">
                                                    <i class="fas fa-check-circle mt-1" style="color:#f67011; margin-right: 10px; flex-shrink: 0; font-size: 14px;"></i>
                                                    <span style="color: #444;"><?php print htmlspecialchars($fi); ?></span>
                                                </li>
                                            <?php } ?>
                                        </ul>
                                    <?php } ?>
                                </div>
                                <div class="mt-4">
                                    <a href="<?php print htmlspecialchars($btn_link); ?>" class="btn btn-bordered<?php print $featured ? ' active' : ''; ?>" style="min-width: 180px;">
                                        <?php print htmlspecialchars($btn_text); ?>
                                    </a>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>

                <div class="row justify-content-center">
                    <div class="col-12 text-center">
                        <a href="pricing" class="btn btn-bordered mt-4">View Pricing</a>
                    </div>
                </div>
            </div>
            <div class="shape shape-bottom" style="z-index: 0;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>

         ***** Price Plan Area End ***** -->

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
                        <!-- Section Heading -->


                        <div class="section-heading text-left">
                            <h2 style="color: #3b1b6a;"><?php print $test_title; ?></h2>
                            <p class="d-none d-sm-block mt-4" style="color: #555;"><?php print $test_text;?></p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <!-- Client Reviews -->
                    <div class="client-reviews owl-carousel">
                        <!-- Single Review -->



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
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>
        <!-- ***** Review Area End ***** -->

        <!--====== Contact Area Start ======-->
        <section id="contact" class="contact-area ptb_100">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-12 col-lg-5">
                        <!-- Section Heading -->
                        <div class="section-heading text-center mb-3">
                            <h2><?php print $contact_title ?></h2>
                            <p class="d-none d-sm-block mt-4"><?php print $contact_text ?></p>
                        </div>
                        <!-- Contact Us -->
                        <div class="contact-us">
                            <ul>
                                <!-- Contact Info -->
                                <li class="contact-info color-1 bg-hover active hover-bottom text-center p-5 m-3">
                                    <span><i class="fas fa-mobile-alt fa-3x"></i></span>
                                    <a class="d-block my-2" href="tel:<?php print $phone1 ?>">
                                        <h4><?php print $phone1 ?></h4>
                                    </a>

                                </li>
                                <!-- Contact Info -->
                                <li class="contact-info color-3 bg-hover active hover-bottom text-center p-5 m-3">
                                    <span><i class="fas fa-envelope-open-text fa-3x"></i></span>
                                    <a class="d-none d-sm-block my-2" href="mailto:<?php print $email1 ?>">
                                        <h4><?php print $email1 ?></h4>
                                    </a>
                                    <a class="d-block d-sm-none my-2" href="mailto:<?php print $email1 ?>">
                                        <h4><?php print $email1 ?></h4>
                                    </a>

                                </li>
                            </ul>
                        </div>
                    </div>
                                   <div class="col-12 col-lg-6 pt-4 pt-lg-0">
                        <!-- Contact Box -->
                        <div class="contact-box text-center">
                            <!-- Contact Form -->
                            <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$name = mysqli_real_escape_string($con,$_POST['name']);
$email = mysqli_real_escape_string($con,$_POST['email']);
$phone = mysqli_real_escape_string($con,$_POST['phone']);
$message = mysqli_real_escape_string($con,$_POST['message']);

 if ( strlen($name) < 5 ){
$msg=$msg."Name Must Be More Than 5 Char Length.<BR>";
$status= "NOTOK";}
 if ( strlen($email) < 9 ){
$msg=$msg."Email Must Be More Than 10 Char Length.<BR>";
$status= "NOTOK";}
if ( strlen($message) < 10 ){
    $msg=$msg."Message Must Be More Than 10 Char Length.<BR>";
    $status= "NOTOK";}

if ( strlen($phone) < 8 ){
  $msg=$msg."Phone Must Be More Than 8 Char Length.<BR>";
  $status= "NOTOK";}

  if($status=="OK")
  {

$recipient="timestenkenya@gmail.com";

$formcontent="NAME:$name \n EMAIL: $email  \n PHONE: $phone  \n MESSAGE: $message";

$subject = "New Enquiry from Timesten Kenya Business Portfolio";
$mailheader = "From: noreply@timesten.com \r\n";
$result= mail($recipient, $subject, $formcontent);

          if($result){
                  $errormsg= "
  <div class='alert alert-success alert-dismissible alert-outline fade show'>
                   Enquiry Sent Successfully. We shall get back to you ASAP.
                    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                    </div>
   "; //printing error if found in validation

          }
      }

          elseif ($status!=="OK") {
              $errormsg= "
  <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                       ".$msg." <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> </div>"; //printing error if found in validation


      }
      else{
              $errormsg= "
        <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                   Some Technical Glitch Is There. Please Try Again Later Or Ask Admin For Help.
                   <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                   </div>"; //printing error if found in validation


          }
             }
             ?>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST')
						{
						print $errormsg;
						}
   ?>

<form id="contactForm" method="post">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <input type="text" class="form-control" name="name" id="name" placeholder="Name" required="required">
                                        </div>

                                        <div class="form-group">
                                            <input type="email" class="form-control" name="email" id="email" placeholder="Email" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" name="phone" id="phone" placeholder="Phone" required="required">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control" name="ref_code" id="ref_code" placeholder="Referral Code (Optional)" value="<?php echo isset($_SESSION['referral_token']) ? htmlspecialchars($_SESSION['referral_token']) : ''; ?>">
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-group">
                                            <textarea class="form-control" name="message" id="message" placeholder="Message" required="required"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-bordered active btn-block mt-3" id="submitBtn">
                                            <span class="text-white pr-3"><i class="fas fa-paper-plane"></i></span>Send Message
                                            <span class="spinner-border spinner-border-sm text-white ml-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <p class="form-message"></p>
                            
                            <!-- Success Modal -->
                            <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 320px;">
                                    <div class="modal-content" style="border: none; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">
                                        <div class="modal-header py-2" style="background: linear-gradient(135deg, #3b1b6a 0%, #5a2d8c 100%); color: white; border: none;">
                                            <h6 class="modal-title w-100 text-center font-weight-bold" id="successModalLabel" style="font-size: 0.95rem;">Message Sent!</h6>
                                            <button type="button" class="close position-absolute" style="right: 12px; top: 8px; color: white; opacity: 0.9; font-size: 1.2rem;" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body text-center py-4 px-4">
                                            <div style="width: 70px; height: 70px; background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 4px 15px rgba(255, 108, 53, 0.4);">
                                                <i class="fas fa-check" style="color: white; font-size: 32px;"></i>
                                            </div>
                                            <h5 class="mb-2" style="color: #3b1b6a; font-weight: 700; font-size: 1.3rem;">Thank You!</h5>
                                            <p class="mb-0" style="font-size: 0.85rem; line-height: 1.5; color: #666;">Your message has been sent successfully. We'll get back to you soon!</p>
                                        </div>
                                        <div class="modal-footer justify-content-center py-3" style="border-top: none; background: #f8f9fa;">
                                            <button type="button" class="btn px-4" style="background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%); color: white; border: none; border-radius: 25px; font-weight: 600; font-size: 0.9rem; box-shadow: 0 4px 15px rgba(255, 108, 53, 0.3);" data-dismiss="modal">OK, Great!</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Error Modal -->
                            <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header bg-danger text-white">
                                            <h5 class="modal-title" id="errorModalLabel">Error</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body text-center py-4">
                                            <i class="fas fa-exclamation-triangle fa-4x mb-3 text-danger"></i>
                                            <h4>Oops!</h4>
                                            <p id="errorMessage">Something went wrong. Please try again.</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--====== Contact Area End ======-->

        <!--====== Call To Action Area Start ======-->
        <section class="section cta-area bg-overlay orangish-gradient ptb_100">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-10">
                        <!-- Section Heading -->
                        <div class="section-heading text-center m-0">
                            <h2 class="text-white"><?php print $enquiry_title; ?></h2>
                            <p class="text-white d-none d-sm-block mt-4"><?php print $enquiry_text; ?></p>
                            <a href="contact" class="btn btn-bordered-white mt-4">Contact Us</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--====== Call To Action Area End ======-->
        <script src="//code.tidio.co/2efw0z0gu6xh9q8ptxcjmylpn00rcwwz.js" async></script>
            <script>
                (function () {
                    function initHeroSliderIfReady() {
                        if (typeof window.jQuery === 'undefined') {
                            return false;
                        }
                        var $ = window.jQuery;
                        if (typeof $.fn.owlCarousel !== 'function') {
                            return false;
                        }
                        if ($('.welcome-slider').length === 0) {
                            return true;
                        }

                        var $slider = $('.welcome-slider');
                        if ($slider.data('owl-initialized')) {
                            return true;
                        }
                        $slider.data('owl-initialized', true);

                        function updateHeroFromActiveSlide() {
                            var $active = $slider.find('.owl-item.active .welcome-slide').first();
                            var t = ($active.attr('data-slide-title') || '').trim();
                            var x = ($active.attr('data-slide-text') || '').trim();
                            var a = ($active.attr('data-text-align') || 'left').trim();
                            var c = ($active.attr('data-show-cartoon') || '1').trim();

                            if ($('#heroSlideTitle').length) {
                                $('#heroSlideTitle').text(t.length ? t : <?php echo json_encode($stitle); ?>);
                            }
                            if ($('#heroSlideText').length) {
                                $('#heroSlideText').text(x.length ? x : <?php echo json_encode($stext); ?>);
                            }

                            if ($('#heroRow').length) {
                                if (a === 'right') {
                                    $('#heroRow').addClass('hero-align-right');
                                } else {
                                    $('#heroRow').removeClass('hero-align-right');
                                }

                                if (c === '0') {
                                    $('#heroRow').addClass('hero-hide-cartoon');
                                } else {
                                    $('#heroRow').removeClass('hero-hide-cartoon');
                                }
                            }
                        }

                        $slider.owlCarousel({
                            items: 1,
                            loop: true,
                            autoplay: true,
                            autoplayTimeout: 5000,
                            autoplayHoverPause: false,
                            nav: false,
                            dots: true,
                            animateOut: 'fadeOut'
                        });

                        updateHeroFromActiveSlide();
                        $slider.on('changed.owl.carousel', function () {
                            setTimeout(updateHeroFromActiveSlide, 0);
                        });

                        return true;
                    }

                    function retryInit() {
                        var ok = initHeroSliderIfReady();
                        if (!ok) {
                            setTimeout(retryInit, 250);
                        }
                    }

                    if (document.readyState === 'complete') {
                        retryInit();
                    } else {
                        window.addEventListener('load', retryInit);
                    }
                })();
            </script>
            
<script>
$(document).ready(function() {
    $('#contactForm').on('submit', function(e) {
        e.preventDefault();
        
        // Show loading spinner
        $('#submitBtn').prop('disabled', true);
        $('#loadingSpinner').removeClass('d-none');
        
        $.ajax({
            type: 'POST',
            url: 'send_email.php',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(response) {
                // Hide loading spinner
                $('#submitBtn').prop('disabled', false);
                $('#loadingSpinner').addClass('d-none');
                
                if (response.status === 'success') {
                    // Show success modal
                    $('#successModal').modal('show');
                    // Clear form
                    $('#contactForm')[0].reset();
                } else {
                    // Show error modal with message
                    $('#errorMessage').html(response.message);
                    $('#errorModal').modal('show');
                }
            },
            error: function() {
                // Hide loading spinner
                $('#submitBtn').prop('disabled', false);
                $('#loadingSpinner').addClass('d-none');
                
                // Show error modal
                $('#errorMessage').html('A server error occurred. Please try again later.');
                $('#errorModal').modal('show');
            }
        });
    });
});
</script>
      
      <?php include "footer.php"; ?>
