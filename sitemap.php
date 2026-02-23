<?php
include 'z_db.php';

header('Content-Type: application/xml; charset=UTF-8');

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<?php
$baseUrl = 'https://timestentechnologies.co.ke';

function sitemap_url($loc, $lastmod = null, $priority = null)
{
    $locEsc = htmlspecialchars($loc, ENT_XML1);
    echo "  <url>\n";
    echo "    <loc>{$locEsc}</loc>\n";
    if (!empty($lastmod)) {
        $lastmodEsc = htmlspecialchars($lastmod, ENT_XML1);
        echo "    <lastmod>{$lastmodEsc}</lastmod>\n";
    }
    if ($priority !== null) {
        $priorityEsc = htmlspecialchars(number_format((float)$priority, 2, '.', ''), ENT_XML1);
        echo "    <priority>{$priorityEsc}</priority>\n";
    }
    echo "  </url>\n";
}

function to_w3c_date($value)
{
    if (empty($value)) {
        return gmdate('c');
    }
    $ts = strtotime($value);
    if ($ts === false) {
        return gmdate('c');
    }
    return gmdate('c', $ts);
}

sitemap_url($baseUrl . '/', gmdate('c'), 1.0);

$staticPages = [
    '/about' => 0.80,
    '/services' => 0.80,
    '/portfolio' => 0.80,
    '/blog' => 0.80,
    '/contact' => 0.80,
    '/careers' => 0.80,
    '/privacy' => 0.64,
    '/terms' => 0.64,
    '/cookie' => 0.64,
];

foreach ($staticPages as $path => $prio) {
    sitemap_url($baseUrl . $path, gmdate('c'), $prio);
}

$jobs = mysqli_query($con, "SELECT id, created_at, updated_at FROM jobs WHERE status='open' ORDER BY id DESC");
if ($jobs) {
    while ($row = mysqli_fetch_assoc($jobs)) {
        $id = (int)$row['id'];
        $last = !empty($row['updated_at']) ? $row['updated_at'] : $row['created_at'];
        sitemap_url($baseUrl . '/jobdetail/' . $id, to_w3c_date($last), 0.64);
    }
}

$services = mysqli_query($con, 'SELECT id, updated_at FROM service ORDER BY id DESC');
if ($services) {
    while ($row = mysqli_fetch_assoc($services)) {
        $id = (int)$row['id'];
        $last = $row['updated_at'] ?? null;
        sitemap_url($baseUrl . '/servicedetail.php?id=' . $id, to_w3c_date($last), 0.64);
    }
}

$ports = mysqli_query($con, 'SELECT id, updated_at FROM portfolio ORDER BY id DESC');
if ($ports) {
    while ($row = mysqli_fetch_assoc($ports)) {
        $id = (int)$row['id'];
        $last = $row['updated_at'] ?? null;
        sitemap_url($baseUrl . '/portdetail.php?id=' . $id, to_w3c_date($last), 0.64);
    }
}

$blogs = mysqli_query($con, 'SELECT id, updated_at, created_at FROM blog ORDER BY id DESC');
if ($blogs) {
    while ($row = mysqli_fetch_assoc($blogs)) {
        $id = (int)$row['id'];
        $last = !empty($row['updated_at']) ? $row['updated_at'] : ($row['created_at'] ?? null);
        sitemap_url($baseUrl . '/blogdetail.php?id=' . $id, to_w3c_date($last), 0.64);
    }
}
?>
</urlset>
