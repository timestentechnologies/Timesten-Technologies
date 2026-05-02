<?php include "header.php"; ?>

<?php
// Create community tables if they don't exist
mysqli_query($con, "CREATE TABLE IF NOT EXISTS community_topics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NULL,
    created_by VARCHAR(80) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    last_activity_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS community_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic_id INT NOT NULL,
    parent_id INT NULL,
    guest_name VARCHAR(80) NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_topic_created (topic_id, created_at),
    INDEX idx_parent (parent_id),
    CONSTRAINT fk_community_messages_topic FOREIGN KEY (topic_id) REFERENCES community_topics(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

// Seed initial data if empty
$topicCountRs = mysqli_query($con, "SELECT COUNT(*) AS c FROM community_topics");
$topicCountRow = $topicCountRs ? mysqli_fetch_assoc($topicCountRs) : ['c' => 0];
$topicCount = isset($topicCountRow['c']) ? intval($topicCountRow['c']) : 0;

if ($topicCount === 0) {
    mysqli_query($con, "INSERT INTO community_topics (title, body, created_by, created_at, last_activity_at) VALUES
        ('Website Design & Development Tips', 'Share your best tips for building fast, modern websites.', 'Admin', NOW(), NOW()),
        ('SEO & Marketing Questions', 'Ask anything about SEO, content, ads, and growth.', 'Admin', NOW(), NOW()),
        ('Business & Tech in Kenya', 'Discuss tools, trends, and opportunities in the local market.', 'Admin', NOW(), NOW())");

    $topicsRs = mysqli_query($con, "SELECT id, title FROM community_topics ORDER BY id ASC");
    $topicIds = [];
    while ($topicsRs && ($t = mysqli_fetch_assoc($topicsRs))) {
        $topicIds[$t['title']] = intval($t['id']);
    }

    $t1 = isset($topicIds['Website Design & Development Tips']) ? $topicIds['Website Design & Development Tips'] : 0;
    $t2 = isset($topicIds['SEO & Marketing Questions']) ? $topicIds['SEO & Marketing Questions'] : 0;
    $t3 = isset($topicIds['Business & Tech in Kenya']) ? $topicIds['Business & Tech in Kenya'] : 0;

    if ($t1) {
        mysqli_query($con, "INSERT INTO community_messages (topic_id, parent_id, guest_name, message, created_at) VALUES
            ($t1, NULL, 'Amina', 'What stack do you recommend for a small business site that needs speed?', NOW()),
            ($t1, NULL, 'Brian', 'Use good hosting + caching, optimize images, and avoid heavy plugins.', NOW()),
            ($t1, NULL, 'Kevin', 'I like Bootstrap + PHP for simple sites. For apps, consider React/Next.', NOW())");
        mysqli_query($con, "UPDATE community_topics SET last_activity_at = NOW() WHERE id=$t1");
    }

    if ($t2) {
        mysqli_query($con, "INSERT INTO community_messages (topic_id, parent_id, guest_name, message, created_at) VALUES
            ($t2, NULL, 'Faith', 'How long does SEO take before seeing results?', NOW()),
            ($t2, NULL, 'Sam', 'Usually 2-4 months for early movement, 6+ months for strong results.', NOW())");
        mysqli_query($con, "UPDATE community_topics SET last_activity_at = NOW() WHERE id=$t2");
    }

    if ($t3) {
        mysqli_query($con, "INSERT INTO community_messages (topic_id, parent_id, guest_name, message, created_at) VALUES
            ($t3, NULL, 'Njeri', 'What payment options are easiest to integrate for Kenya?', NOW()),
            ($t3, NULL, 'Peter', 'M-Pesa is the main one. Card payments via Flutterwave/Paystack can help too.', NOW())");
        mysqli_query($con, "UPDATE community_topics SET last_activity_at = NOW() WHERE id=$t3");
    }
}

// Handle create topic
$create_error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create_topic'])) {
    $name = isset($_POST['guest_name']) ? trim($_POST['guest_name']) : '';
    $title = isset($_POST['title']) ? trim($_POST['title']) : '';
    $body = isset($_POST['body']) ? trim($_POST['body']) : '';

    if ($name === '' || $title === '') {
        $create_error = 'Please enter your name and a topic title.';
    } else {
        $name_s = mysqli_real_escape_string($con, mb_substr($name, 0, 80));
        $title_s = mysqli_real_escape_string($con, mb_substr($title, 0, 255));
        $body_s = mysqli_real_escape_string($con, $body);

        mysqli_query($con, "INSERT INTO community_topics (title, body, created_by, created_at, last_activity_at) VALUES ('$title_s', '$body_s', '$name_s', NOW(), NOW())");
        $newId = mysqli_insert_id($con);
        if ($newId > 0) {
            header('Location: community-topic.php?id=' . $newId);
            exit;
        }

        $create_error = 'Failed to create topic. Please try again.';
    }
}

$topics = [];
$topicsRs = mysqli_query($con, "SELECT t.*, (SELECT COUNT(*) FROM community_messages m WHERE m.topic_id=t.id) AS msg_count FROM community_topics t ORDER BY t.last_activity_at DESC, t.id DESC");
while ($topicsRs && ($row = mysqli_fetch_assoc($topicsRs))) {
    $topics[] = $row;
}
?>

<section class="section breadcrumb-area overlay-dark d-flex align-items-center">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumb-content text-center">
                    <h2 class="text-white text-uppercase mb-3">Community</h2>
                    <ol class="breadcrumb d-flex justify-content-center">
                        <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                        <li class="breadcrumb-item text-white active">Community</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section ptb_100" style="background: #f8f9fa;">
    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-8">
                <div class="p-4" style="background:#fff;border-radius:16px;box-shadow:0 8px 30px rgba(0,0,0,0.08);border-top:4px solid #ff8c00;">
                    <h3 class="mb-3" style="color:#3b1b6a;font-weight:800;">Topics</h3>

                    <?php if (count($topics) === 0) { ?>
                        <p class="text-muted mb-0">No topics yet. Be the first to start a discussion.</p>
                    <?php } ?>

                    <div class="mt-3">
                        <?php foreach ($topics as $t) {
                            $tid = intval($t['id']);
                            $title = htmlspecialchars($t['title']);
                            $created_by = htmlspecialchars($t['created_by']);
                            $msg_count = intval($t['msg_count']);
                            $last_activity = !empty($t['last_activity_at']) ? date('M d, Y H:i', strtotime($t['last_activity_at'])) : '';
                        ?>
                            <div class="mb-3 p-3" style="border:1px solid rgba(0,0,0,0.06);border-radius:12px;">
                                <div class="d-flex align-items-start justify-content-between">
                                    <div>
                                        <h5 class="mb-1" style="font-weight:800;"><a href="community-topic.php?id=<?php echo $tid; ?>" style="color:#3b1b6a;text-decoration:none;"><?php echo $title; ?></a></h5>
                                        <div class="text-muted" style="font-size:13px;">Started by <strong><?php echo $created_by; ?></strong> · Last activity <?php echo htmlspecialchars($last_activity); ?></div>
                                    </div>
                                    <div class="text-end" style="min-width:90px;">
                                        <div style="font-size:12px;color:#666;">Messages</div>
                                        <div style="font-size:18px;font-weight:800;color:#ff8c00;line-height:1;"><?php echo $msg_count; ?></div>
                                    </div>
                                </div>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-4 mt-4 mt-lg-0">
                <div class="p-4" style="background:#fff;border-radius:16px;box-shadow:0 8px 30px rgba(0,0,0,0.08);border-top:4px solid #ff8c00;">
                    <h4 class="mb-3" style="color:#3b1b6a;font-weight:800;">Start a Topic</h4>

                    <?php if ($create_error !== '') { ?>
                        <div class="alert alert-danger"><?php echo htmlspecialchars($create_error); ?></div>
                    <?php } ?>

                    <form method="post">
                        <div class="form-group mb-3">
                            <label class="mb-1" style="font-weight:700;">Your Name</label>
                            <input type="text" name="guest_name" class="form-control" placeholder="e.g. Jane" maxlength="80" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="mb-1" style="font-weight:700;">Topic Title</label>
                            <input type="text" name="title" class="form-control" placeholder="What do you want to discuss?" maxlength="255" required>
                        </div>
                        <div class="form-group mb-3">
                            <label class="mb-1" style="font-weight:700;">Details (optional)</label>
                            <textarea name="body" class="form-control" rows="4" placeholder="Add more context..."></textarea>
                        </div>
                        <button type="submit" name="create_topic" class="btn btn-primary w-100" style="background:linear-gradient(135deg,#ff8c00 0%,#ff7f50 100%);border:none;border-radius:14px;font-weight:800;">Create Topic</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<?php include "footer.php"; ?>
