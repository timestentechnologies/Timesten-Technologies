<?php

function pricing_ensure_schema($con)
{
    if (!isset($con)) {
        return;
    }

    mysqli_query(
        $con,
        "CREATE TABLE IF NOT EXISTS pricing_page_settings (
            id INT PRIMARY KEY,
            heading VARCHAR(255) NOT NULL,
            subheading VARCHAR(255) NULL,
            intro_text TEXT NULL,
            cta_text VARCHAR(255) NULL,
            cta_link VARCHAR(255) NULL,
            updated_at DATETIME NULL
        )"
    );

    mysqli_query(
        $con,
        "CREATE TABLE IF NOT EXISTS pricing_plans (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(120) NOT NULL,
            price VARCHAR(60) NOT NULL,
            billing_period VARCHAR(60) NULL,
            short_desc TEXT NULL,
            features TEXT NULL,
            button_text VARCHAR(120) NULL,
            button_link VARCHAR(255) NULL,
            is_featured TINYINT(1) NOT NULL DEFAULT 0,
            sort_order INT NOT NULL DEFAULT 0,
            is_active TINYINT(1) NOT NULL DEFAULT 1,
            created_at DATETIME NULL,
            updated_at DATETIME NULL
        )"
    );

    mysqli_query(
        $con,
        "INSERT INTO pricing_page_settings (id, heading, subheading, intro_text, cta_text, cta_link, updated_at)
         SELECT 1,
                'Pricing Plans',
                'Choose the plan that fits your business',
                'Transparent pricing for websites, systems, and ongoing support. Contact us for custom quotes and enterprise projects.',
                'Get a Custom Quote',
                'contact',
                NOW()
         WHERE NOT EXISTS (SELECT 1 FROM pricing_page_settings WHERE id=1)"
    );

    $plans_rs = mysqli_query($con, "SELECT COUNT(*) AS c FROM pricing_plans");
    $plans_row = $plans_rs ? mysqli_fetch_assoc($plans_rs) : null;
    $count = $plans_row && isset($plans_row['c']) ? (int)$plans_row['c'] : 0;

    if ($count < 1) {
        $now = date('Y-m-d H:i:s');

        $starter_features = "Professional single-page or 3-5 page website\nMobile-responsive design with fast loading\nBusiness email setup (1-3 accounts)\nBasic on-page SEO (meta titles, descriptions)\nContact form with email notifications\nGoogle Maps integration\nSocial media links integration\n1 month technical support\nHosting guidance included";

        $corporate_features = "Professional multi-page website (up to 15 pages)\nCustom UI design with brand identity\nAdvanced SEO optimization (sitemap, schema markup)\nGoogle Analytics & Search Console setup\nLive WhatsApp chat integration\nBlog/News section with CMS\nGallery/portfolio showcase\nTestimonials & team sections\nSpeed optimization ( caching, image compression)\n3 months priority support";

        $ecommerce_features = "Full-featured e-commerce platform\nUnlimited product listings\nSecure payment integration (M-Pesa, cards, PayPal)\nShopping cart & checkout flow\nOrder management dashboard\nCustomer account system\nInventory tracking & low-stock alerts\nSMS/email order notifications\nDiscount codes & promotional tools\nShipping & delivery management\nMobile app-like experience\nAdvanced security (SSL, firewall setup)\n6 months dedicated support";

        $starter_features_s = mysqli_real_escape_string($con, $starter_features);
        $corporate_features_s = mysqli_real_escape_string($con, $corporate_features);
        $ecommerce_features_s = mysqli_real_escape_string($con, $ecommerce_features);

        mysqli_query(
            $con,
            "INSERT INTO pricing_plans (name, price, billing_period, short_desc, features, button_text, button_link, is_featured, sort_order, is_active, created_at, updated_at)
             VALUES
             ('Starter Business Website', 'KSh 25,000', 'one-time', 'Perfect for new businesses needing a professional online presence quickly.', '$starter_features_s', 'Get Started', 'contact', 0, 1, 1, '$now', '$now'),
             ('Corporate Professional Site', 'KSh 65,000', 'one-time', 'Comprehensive website for established businesses requiring advanced features.', '$corporate_features_s', 'Request Demo', 'contact', 1, 2, 1, '$now', '$now'),
             ('E-Commerce Platform', 'KSh 150,000', 'one-time', 'Complete online store solution with payments, inventory, and order management.', '$ecommerce_features_s', 'Talk to Sales', 'contact', 0, 3, 1, '$now', '$now')"
        );
    }
}

function pricing_migrate_old_plans($con)
{
    $now = date('Y-m-d H:i:s');

    $starter_features = "Professional single-page or 3-5 page website\nMobile-responsive design with fast loading\nBusiness email setup (1-3 accounts)\nBasic on-page SEO (meta titles, descriptions)\nContact form with email notifications\nGoogle Maps integration\nSocial media links integration\n1 month technical support\nHosting guidance included";

    $corporate_features = "Professional multi-page website (up to 15 pages)\nCustom UI design with brand identity\nAdvanced SEO optimization (sitemap, schema markup)\nGoogle Analytics & Search Console setup\nLive WhatsApp chat integration\nBlog/News section with CMS\nGallery/portfolio showcase\nTestimonials & team sections\nSpeed optimization ( caching, image compression)\n3 months priority support";

    $ecommerce_features = "Full-featured e-commerce platform\nUnlimited product listings\nSecure payment integration (M-Pesa, cards, PayPal)\nShopping cart & checkout flow\nOrder management dashboard\nCustomer account system\nInventory tracking & low-stock alerts\nSMS/email order notifications\nDiscount codes & promotional tools\nShipping & delivery management\nMobile app-like experience\nAdvanced security (SSL, firewall setup)\n6 months dedicated support";

    mysqli_query(
        $con,
        "UPDATE pricing_plans SET name='Starter Business Website', price='KSh 25,000', short_desc='Perfect for new businesses needing a professional online presence quickly.', features='" . mysqli_real_escape_string($con, $starter_features) . "', updated_at='$now' WHERE name='Basic' LIMIT 1"
    );

    mysqli_query(
        $con,
        "UPDATE pricing_plans SET name='Corporate Professional Site', price='KSh 65,000', short_desc='Comprehensive website for established businesses requiring advanced features.', features='" . mysqli_real_escape_string($con, $corporate_features) . "', updated_at='$now' WHERE name='Standard' LIMIT 1"
    );

    mysqli_query(
        $con,
        "UPDATE pricing_plans SET name='E-Commerce Platform', price='KSh 150,000', short_desc='Complete online store solution with payments, inventory, and order management.', features='" . mysqli_real_escape_string($con, $ecommerce_features) . "', updated_at='$now' WHERE name='Premium' LIMIT 1"
    );
}

function pricing_get_settings($con)
{
    pricing_ensure_schema($con);
    pricing_migrate_old_plans($con);

    $rs = mysqli_query($con, "SELECT * FROM pricing_page_settings WHERE id=1 LIMIT 1");
    $row = $rs ? mysqli_fetch_assoc($rs) : null;

    return $row;
}

function pricing_get_plans($con, $only_active = true)
{
    pricing_ensure_schema($con);
    pricing_migrate_old_plans($con);

    $where = $only_active ? 'WHERE is_active=1' : '';
    $rs = mysqli_query($con, "SELECT * FROM pricing_plans $where ORDER BY sort_order ASC, id ASC");

    $plans = [];
    if ($rs) {
        while ($r = mysqli_fetch_assoc($rs)) {
            $plans[] = $r;
        }
    }

    return $plans;
}
