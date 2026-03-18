<?php
include"../z_db.php";

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
    echo "Table 'backup_logs' created successfully or already exists.<br>";
} else {
    echo "Error creating table: " . mysqli_error($con) . "<br>";
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
    echo "Table 'backup_schedule' created successfully or already exists.<br>";
} else {
    echo "Error creating schedule table: " . mysqli_error($con) . "<br>";
}

// Insert default schedule if not exists
$insert_schedule = "INSERT IGNORE INTO backup_schedule (schedule_name, frequency_days, next_run) 
                    VALUES ('Every 2 Days', 2, DATE_ADD(NOW(), INTERVAL 2 DAY))";

if (mysqli_query($con, $insert_schedule)) {
    echo "Default backup schedule inserted.<br>";
} else {
    echo "Error inserting schedule: " . mysqli_error($con) . "<br>";
}

echo "<br><a href='backup.php'>Go to Backup Page</a>";
?>
