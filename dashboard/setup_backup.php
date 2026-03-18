<?php
include"../z_db.php";

echo "<h2>Setting up Backup System</h2>";

// Create backup_logs table
$sql = "CREATE TABLE IF NOT EXISTS backup_logs (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    backup_name VARCHAR(255) NOT NULL,
    backup_file VARCHAR(500) NOT NULL,
    backup_size BIGINT(20) NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NOT NULL,
    backup_type ENUM('manual', 'auto') DEFAULT 'manual',
    status ENUM('success', 'failed', 'in_progress') DEFAULT 'success'
)";

if (mysqli_query($con, $sql)) {
    echo "✓ Table 'backup_logs' created successfully or already exists.<br>";
} else {
    echo "✗ Error creating backup_logs table: " . mysqli_error($con) . "<br>";
}

// Create backup_schedule table for automated backups
$sql_schedule = "CREATE TABLE IF NOT EXISTS backup_schedule (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    schedule_name VARCHAR(100) NOT NULL DEFAULT 'Every 2 Days',
    frequency_days INT(11) NOT NULL DEFAULT 2,
    last_run TIMESTAMP NULL,
    next_run TIMESTAMP NULL,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";

if (mysqli_query($con, $sql_schedule)) {
    echo "✓ Table 'backup_schedule' created successfully or already exists.<br>";
} else {
    echo "✗ Error creating backup_schedule table: " . mysqli_error($con) . "<br>";
}

// Insert default schedule if not exists
$insert_schedule = "INSERT IGNORE INTO backup_schedule (schedule_name, frequency_days, next_run) 
                    VALUES ('Every 2 Days', 2, DATE_ADD(NOW(), INTERVAL 2 DAY))";

if (mysqli_query($con, $insert_schedule)) {
    echo "✓ Default backup schedule inserted.<br>";
} else {
    echo "✗ Error inserting schedule: " . mysqli_error($con) . "<br>";
}

// Create backup directory
$backup_dir = __DIR__ . '/backups';
if (!file_exists($backup_dir)) {
    if (mkdir($backup_dir, 0755, true)) {
        echo "✓ Backup directory created: " . $backup_dir . "<br>";
    } else {
        echo "✗ Failed to create backup directory.<br>";
    }
} else {
    echo "✓ Backup directory already exists: " . $backup_dir . "<br>";
}

echo "<br><h3>Setup Complete!</h3>";
echo "<p>Your backup system is now ready. You can:</p>";
echo "<ul>";
echo "<li><a href='backup.php'>Go to Backup Management Page</a></li>";
echo "<li><strong>Important:</strong> For automatic backups every 2 days, set up a cron job to run: <code>auto_backup_cron.php</code></li>";
echo "</ul>";

echo "<br><h3>Cron Job Setup Instructions</h3>";
echo "<p>To enable automatic backups every 2 days, add this cron job to your server:</p>";
echo "<code>0 2 * * * /usr/bin/php " . __DIR__ . "/auto_backup_cron.php</code>";
echo "<p>This will run the backup check daily at 2 AM, and create a backup if 2 days have passed since the last one.</p>";
?>
