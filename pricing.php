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

<section class="section ptb_100 bg-grey">
    <!-- Shape Top -->
    <div class="shape shape-top">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
            <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
            c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
            c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
        </svg>
    </div>
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

        <div class="row justify-content-center">
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
                <div class="col-12 col-md-6 col-lg-4 mb-4">
                    <div class="single-price-plan text-center p-5 h-100" style="border: solid 1px #e6e6e6; border-radius: 14px; <?php print $featured ? 'box-shadow: 0 18px 45px rgba(0,0,0,0.10); border-color: rgba(246,112,17,0.35);' : ''; ?>">
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
                            <p class="mb-4"><?php print htmlspecialchars($desc); ?></p>
                        <?php } ?>

                        <?php if (count($feature_items) > 0) { ?>
                            <ul class="list-unstyled text-start mb-4" style="max-width: 320px; margin: 0 auto;">
                                <?php foreach ($feature_items as $fi) { ?>
                                    <li class="mb-2"><i class="fas fa-check" style="color:#f67011; margin-right: 8px;"></i><?php print htmlspecialchars($fi); ?></li>
                                <?php } ?>
                            </ul>
                        <?php } ?>

                        <a href="<?php print htmlspecialchars($btn_link); ?>" class="btn btn-bordered<?php print $featured ? ' active' : ''; ?>" style="min-width: 180px;">
                            <?php print htmlspecialchars($btn_text); ?>
                        </a>
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
    <!-- Shape Bottom -->
    <div class="shape shape-bottom">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
            <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
        </svg>
    </div>
</section>

<?php include "footer.php"; ?>
