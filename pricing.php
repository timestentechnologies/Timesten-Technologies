<?php
$page_title = 'Pricing';
include "header.php";
include "pricing_data.php";

$settings = pricing_get_settings($con);
$plans = pricing_get_plans($con, true);

$heading = $settings && isset($settings['heading']) ? $settings['heading'] : 'Pricing Plans';
$subheading = $settings && isset($settings['subheading']) ? $settings['subheading'] : '';
$intro_text = $settings && isset($settings['intro_text']) ? $settings['intro_text'] : '';
$cta_text = $settings && isset($settings['cta_text']) ? $settings['cta_text'] : 'Contact Us';
$cta_link = $settings && isset($settings['cta_link']) ? $settings['cta_link'] : 'contact';
?>

<section class="section breadcrumb-area overlay-dark d-flex align-items-center">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumb-content d-flex flex-column align-items-center text-center">
                    <h2 class="text-white text-uppercase mb-3">Pricing</h2>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                        <li class="breadcrumb-item text-white active">Pricing</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section ptb_100 bg-grey">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-7">
                <div class="section-heading text-center">
                    <h2><?php print htmlspecialchars($heading); ?></h2>
                    <?php if (strlen(trim($subheading)) > 0) { ?>
                        <p class="d-none d-sm-block mt-4"><?php print htmlspecialchars($subheading); ?></p>
                    <?php } ?>
                    <?php if (strlen(trim($intro_text)) > 0) { ?>
                        <p class="mt-3"><?php print nl2br(htmlspecialchars($intro_text)); ?></p>
                    <?php } ?>
                </div>
            </div>
        </div>

        <div class="row justify-content-center align-items-stretch">
            <?php foreach ($plans as $plan) {
                $name = isset($plan['name']) ? $plan['name'] : '';
                $price = isset($plan['price']) ? $plan['price'] : '';
                $period = isset($plan['billing_period']) ? $plan['billing_period'] : '';
                $desc = isset($plan['short_desc']) ? $plan['short_desc'] : '';
                $features = isset($plan['features']) ? $plan['features'] : '';
                $btn_text = isset($plan['button_text']) && strlen(trim($plan['button_text'])) > 0 ? $plan['button_text'] : 'Contact Us';
                $btn_link = isset($plan['button_link']) && strlen(trim($plan['button_link'])) > 0 ? $plan['button_link'] : 'contact';
                $featured = isset($plan['is_featured']) && (int)$plan['is_featured'] === 1;

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

        <div class="row justify-content-center mt-4">
            <div class="col-12 text-center">
                <a href="<?php print htmlspecialchars($cta_link); ?>" class="btn btn-bordered-white" style="background: #3b1b6a; border-color: #3b1b6a;">
                    <?php print htmlspecialchars($cta_text); ?>
                </a>
            </div>
        </div>
    </div>
</section>

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
