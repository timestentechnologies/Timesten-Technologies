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

        $basic_features = "Business Email Setup\nResponsive Design\nBasic SEO Setup\nContact Form\n1 Month Support";
        $standard_features = "Everything in Basic\nUp to 10 Pages\nAdvanced SEO\nGoogle Analytics\nWhatsApp Chat\n3 Months Support";
        $premium_features = "Everything in Standard\nCustom UI/UX\nAPI Integrations\nPerformance Optimization\nPriority Support\n6 Months Support";

        $basic_features_s = mysqli_real_escape_string($con, $basic_features);
        $standard_features_s = mysqli_real_escape_string($con, $standard_features);
        $premium_features_s = mysqli_real_escape_string($con, $premium_features);

        mysqli_query(
            $con,
            "INSERT INTO pricing_plans (name, price, billing_period, short_desc, features, button_text, button_link, is_featured, sort_order, is_active, created_at, updated_at)
             VALUES
             ('Basic', 'KSh 25,000', 'one-time', 'For startups and simple business websites.', '$basic_features_s', 'Get Started', 'contact', 0, 1, 1, '$now', '$now'),
             ('Standard', 'KSh 55,000', 'one-time', 'For growing businesses that need more pages and SEO.', '$standard_features_s', 'Request Demo', 'contact', 1, 2, 1, '$now', '$now'),
             ('Premium', 'KSh 120,000', 'one-time', 'For businesses needing integrations and custom UI.', '$premium_features_s', 'Talk to Us', 'contact', 0, 3, 1, '$now', '$now')"
        );
    }
}

function pricing_get_settings($con)
{
    pricing_ensure_schema($con);

    $rs = mysqli_query($con, "SELECT * FROM pricing_page_settings WHERE id=1 LIMIT 1");
    $row = $rs ? mysqli_fetch_assoc($rs) : null;

    return $row;
}

function pricing_get_plans($con, $only_active = true)
{
    pricing_ensure_schema($con);

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
