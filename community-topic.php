<?php include "header.php"; ?>

<?php
$topic_id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($topic_id <= 0) {
    header('Location: community.php');
    exit;
}

// Ensure tables exist (in case someone lands here first)
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

$topicRs = mysqli_query($con, "SELECT * FROM community_topics WHERE id=$topic_id LIMIT 1");
$topic = $topicRs ? mysqli_fetch_assoc($topicRs) : null;
if (!$topic) {
    header('Location: community.php');
    exit;
}

$title = htmlspecialchars($topic['title']);
$body = isset($topic['body']) ? trim($topic['body']) : '';
$created_by = htmlspecialchars($topic['created_by']);
$created_at = !empty($topic['created_at']) ? date('M d, Y H:i', strtotime($topic['created_at'])) : '';
?>

<section class="section breadcrumb-area overlay-dark d-flex align-items-center">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumb-content text-center">
                    <h2 class="text-white text-uppercase mb-3">Community Topic</h2>
                    <ol class="breadcrumb d-flex justify-content-center">
                        <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                        <li class="breadcrumb-item"><a class="text-uppercase text-white" href="community.php">Community</a></li>
                        <li class="breadcrumb-item text-white active">Topic</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section ptb_100" style="background:#f8f9fa;">
    <div class="container" style="max-width: 1140px;">
        <div class="row">
            <div class="col-12">
                <div class="p-4 mb-4" style="background:#fff;border-radius:16px;box-shadow:0 8px 30px rgba(0,0,0,0.08);border-top:4px solid #ff8c00;">
                    <h2 class="mb-2" style="color:#3b1b6a;font-weight:900;"><?php echo $title; ?></h2>
                    <div class="text-muted" style="font-size:13px;">Started by <strong><?php echo $created_by; ?></strong> · <?php echo htmlspecialchars($created_at); ?></div>
                    <?php if ($body !== '') { ?>
                        <p class="mt-3 mb-0" style="color:#444;line-height:1.8;"><?php echo nl2br(htmlspecialchars($body)); ?></p>
                    <?php } ?>
                </div>
            </div>

            <div class="col-12 col-lg-8">
                <div class="p-4" style="background:#fff;border-radius:16px;box-shadow:0 8px 30px rgba(0,0,0,0.08);">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h4 class="mb-0" style="color:#3b1b6a;font-weight:900;">Live Discussion</h4>
                        <div class="text-muted" style="font-size:12px;">Auto-updates</div>
                    </div>

                    <div id="chatBox" style="height: 420px; overflow:auto; border:1px solid rgba(0,0,0,0.06); border-radius:12px; padding: 12px; background:#fff;">
                        <div class="text-muted" style="font-size:13px;">Loading messages...</div>
                    </div>

                    <form id="sendForm" class="mt-3">
                        <input type="hidden" id="topicId" value="<?php echo intval($topic_id); ?>">
                        <div class="d-flex flex-column flex-md-row align-items-stretch">
                            <div class="mb-2 mb-md-0" style="flex: 0 0 220px; margin-right: 12px;">
                                <input type="text" id="guestName" class="form-control" placeholder="Your name" maxlength="80" required>
                            </div>
                            <div class="mb-2 mb-md-0" style="flex: 1 1 auto; margin-right: 12px;">
                                <input type="text" id="message" class="form-control" placeholder="Write a message..." required>
                            </div>
                            <div style="flex: 0 0 auto; display: flex;">
                                <button type="submit" class="btn btn-primary btn-sm" style="background:linear-gradient(135deg,#ff8c00 0%,#ff7f50 100%);border:none;border-radius:12px;font-weight:900;padding:10px 16px;min-height: calc(1.5em + .75rem + 2px);display:flex;align-items:center;">Send</button>
                            </div>
                        </div>
                    </form>

                    <div id="sendError" class="mt-3" style="display:none;"></div>
                </div>
            </div>

            <div class="col-12 col-lg-4 mt-4 mt-lg-0">
                <div class="p-4" style="background:#fff;border-radius:16px;box-shadow:0 8px 30px rgba(0,0,0,0.08);border-top:4px solid #ff8c00;">
                    <h5 class="mb-2" style="color:#3b1b6a;font-weight:900;">Community Rules</h5>
                    <div class="text-muted" style="font-size:14px;line-height:1.7;">
                        Be respectful.
                        No spam.
                        Share value.
                    </div>
                    <a href="community.php" class="btn btn-outline-primary mt-3 w-100" style="border-radius:14px;font-weight:900;">Back to Topics</a>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
(function() {
    const chatBox = document.getElementById('chatBox');
    const topicId = document.getElementById('topicId').value;
    const form = document.getElementById('sendForm');
    const sendError = document.getElementById('sendError');

    let lastId = 0;
    let polling = true;

    function escapeHtml(str) {
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }

    function renderMessages(messages, append) {
        if (!append) {
            chatBox.innerHTML = '';
        }

        if (!messages || messages.length === 0) {
            if (!append) {
                chatBox.innerHTML = '<div class="text-muted" style="font-size:13px;">No messages yet. Say hi!</div>';
            }
            return;
        }

        messages.forEach(m => {
            const el = document.createElement('div');
            el.style.padding = '10px 10px';
            el.style.borderRadius = '12px';
            el.style.border = '1px solid rgba(0,0,0,0.06)';
            el.style.marginBottom = '10px';
            el.innerHTML =
                '<div style="display:flex;justify-content:space-between;gap:10px;">' +
                    '<div style="font-weight:900;color:#3b1b6a;">' + escapeHtml(m.guest_name) + '</div>' +
                    '<div style="font-size:12px;color:#999;white-space:nowrap;">' + escapeHtml(m.created_at) + '</div>' +
                '</div>' +
                '<div style="margin-top:6px;color:#444;line-height:1.6;white-space:pre-wrap;">' + escapeHtml(m.message) + '</div>';
            chatBox.appendChild(el);
            if (m.id > lastId) lastId = m.id;
        });

        chatBox.scrollTop = chatBox.scrollHeight;
    }

    async function fetchMessages(initial) {
        if (!polling) return;

        try {
            const url = 'community-api.php?action=list&topic_id=' + encodeURIComponent(topicId) + '&since_id=' + encodeURIComponent(initial ? 0 : lastId);
            const res = await fetch(url, { cache: 'no-store' });
            const data = await res.json();
            if (data && data.ok) {
                renderMessages(data.messages || [], !initial);
            }
        } catch (e) {
            // silent
        }
    }

    async function sendMessage() {
        const name = document.getElementById('guestName').value.trim();
        const msg = document.getElementById('message').value.trim();
        if (!name || !msg) return;

        sendError.style.display = 'none';
        sendError.className = '';
        sendError.innerHTML = '';

        const body = new URLSearchParams();
        body.set('topic_id', topicId);
        body.set('guest_name', name);
        body.set('message', msg);

        const res = await fetch('community-api.php?action=send', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: body.toString()
        });
        const data = await res.json();
        if (!data || !data.ok) {
            sendError.style.display = 'block';
            sendError.className = 'alert alert-danger';
            sendError.innerHTML = escapeHtml((data && data.error) ? data.error : 'Failed to send.');
            return;
        }

        document.getElementById('message').value = '';
        await fetchMessages(false);
    }

    form.addEventListener('submit', function(e) {
        e.preventDefault();
        sendMessage();
    });

    fetchMessages(true);
    setInterval(() => fetchMessages(false), 2000);
})();
</script>

<?php include "footer.php"; ?>
