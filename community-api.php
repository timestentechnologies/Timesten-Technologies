<?php
include "z_db.php";

header('Content-Type: application/json; charset=utf-8');

function out($arr) {
    echo json_encode($arr);
    exit;
}

$action = isset($_GET['action']) ? $_GET['action'] : (isset($_POST['action']) ? $_POST['action'] : '');

// Ensure tables exist
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

if ($action === 'list') {
    $topic_id = isset($_GET['topic_id']) ? intval($_GET['topic_id']) : 0;
    $since_id = isset($_GET['since_id']) ? intval($_GET['since_id']) : 0;

    if ($topic_id <= 0) {
        out(['ok' => false, 'error' => 'Invalid topic']);
    }

    $limit = 200;
    if ($since_id <= 0) {
        $rs = mysqli_query($con, "SELECT id, guest_name, message, created_at FROM community_messages WHERE topic_id=$topic_id ORDER BY id ASC LIMIT $limit");
    } else {
        $rs = mysqli_query($con, "SELECT id, guest_name, message, created_at FROM community_messages WHERE topic_id=$topic_id AND id>$since_id ORDER BY id ASC LIMIT $limit");
    }

    $msgs = [];
    while ($rs && ($row = mysqli_fetch_assoc($rs))) {
        $msgs[] = [
            'id' => intval($row['id']),
            'guest_name' => $row['guest_name'],
            'message' => $row['message'],
            'created_at' => date('M d, Y H:i', strtotime($row['created_at']))
        ];
    }

    out(['ok' => true, 'messages' => $msgs]);
}

if ($action === 'send') {
    $topic_id = isset($_POST['topic_id']) ? intval($_POST['topic_id']) : 0;
    $guest_name = isset($_POST['guest_name']) ? trim($_POST['guest_name']) : '';
    $message = isset($_POST['message']) ? trim($_POST['message']) : '';

    if ($topic_id <= 0) {
        out(['ok' => false, 'error' => 'Invalid topic']);
    }
    if ($guest_name === '' || $message === '') {
        out(['ok' => false, 'error' => 'Name and message are required']);
    }

    $guest_name_s = mysqli_real_escape_string($con, mb_substr($guest_name, 0, 80));
    $message_s = mysqli_real_escape_string($con, $message);

    $existsRs = mysqli_query($con, "SELECT id FROM community_topics WHERE id=$topic_id LIMIT 1");
    if (!$existsRs || mysqli_num_rows($existsRs) === 0) {
        out(['ok' => false, 'error' => 'Topic not found']);
    }

    mysqli_query($con, "INSERT INTO community_messages (topic_id, parent_id, guest_name, message, created_at) VALUES ($topic_id, NULL, '$guest_name_s', '$message_s', NOW())");
    $mid = mysqli_insert_id($con);

    mysqli_query($con, "UPDATE community_topics SET last_activity_at = NOW() WHERE id=$topic_id");

    out(['ok' => true, 'id' => intval($mid)]);
}

out(['ok' => false, 'error' => 'Unknown action']);
