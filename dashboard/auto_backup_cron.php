<?php
include"../z_db.php";

// This script should be run by a cron job every day to check if backup is needed

// Get the active backup schedule
$result = mysqli_query($con, "SELECT * FROM backup_schedule WHERE is_active = 1 LIMIT 1");
if ($schedule = mysqli_fetch_assoc($result)) {
    $frequency_days = $schedule['frequency_days'];
    $last_run = $schedule['last_run'];
    $next_run = $schedule['next_run'];
    
    // Check if backup is needed
    $current_time = date('Y-m-d H:i:s');
    
    if (!$last_run || $current_time >= $next_run) {
        // Create backup directory if it doesn't exist
        $backup_dir = __DIR__ . '/backups';
        if (!file_exists($backup_dir)) {
            mkdir($backup_dir, 0755, true);
        }
        
        // Generate backup name
        $backup_name = 'auto_backup_' . date('Y-m-d_H-i-s') . '.sql';
        $backup_file = $backup_dir . '/' . $backup_name;
        
        // Database configuration
        $db_host = 'localhost';
        $db_user = 'opulentl_timesten';
        $db_pass = 'Moonlight#911';
        $db_name = 'opulentl_timestentech';
        
        // Create backup using mysqldump
        $command = "mysqldump --host={$db_host} --user={$db_user} --password={$db_pass} {$db_name} > {$backup_file}";
        exec($command, $output, $return_var);
        
        if ($return_var === 0) {
            // Backup successful
            $backup_size = filesize($backup_file);
            
            // Log backup to database
            $log_sql = "INSERT INTO backup_logs (backup_name, backup_file, backup_size, created_at, created_by, backup_type, status) 
                        VALUES ('$backup_name', '$backup_file', $backup_size, NOW(), 'System', 'auto', 'success')";
            mysqli_query($con, $log_sql);
            
            // Update schedule
            $new_next_run = date('Y-m-d H:i:s', strtotime("+$frequency_days days"));
            $update_sql = "UPDATE backup_schedule SET last_run = NOW(), next_run = '$new_next_run' WHERE id = " . $schedule['id'];
            mysqli_query($con, $update_sql);
            
            // Log success
            $log_message = "Auto backup created successfully: $backup_name";
            error_log($log_message);
            
        } else {
            // Backup failed
            $log_sql = "INSERT INTO backup_logs (backup_name, backup_file, backup_size, created_at, created_by, backup_type, status) 
                        VALUES ('failed_backup', '', 0, NOW(), 'System', 'auto', 'failed')";
            mysqli_query($con, $log_sql);
            
            $log_message = "Auto backup failed";
            error_log($log_message);
        }
    }
}

// Clean up old backups (keep last 10 backups)
$cleanup_result = mysqli_query($con, "SELECT id, backup_file FROM backup_logs WHERE backup_type = 'auto' ORDER BY created_at DESC LIMIT 10 OFFSET 10");
while ($row = mysqli_fetch_assoc($cleanup_result)) {
    if (file_exists($row['backup_file'])) {
        unlink($row['backup_file']);
    }
    mysqli_query($con, "DELETE FROM backup_logs WHERE id = " . $row['id']);
}

echo "Auto backup check completed at: " . date('Y-m-d H:i:s');
?>
