-- Backup System Database Setup SQL
-- Run these queries in phpMyAdmin to set up the backup system

-- 1. Create backup_logs table to store backup history
CREATE TABLE IF NOT EXISTS `backup_logs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `backup_name` VARCHAR(255) NOT NULL,
    `backup_file` VARCHAR(500) NOT NULL,
    `backup_size` BIGINT(20) NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `created_by` VARCHAR(100) NOT NULL,
    `backup_type` ENUM('manual', 'auto') NOT NULL DEFAULT 'manual',
    `status` ENUM('success', 'failed', 'in_progress') NOT NULL DEFAULT 'success',
    PRIMARY KEY (`id`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_backup_type` (`backup_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Create backup_schedule table for automated backups
CREATE TABLE IF NOT EXISTS `backup_schedule` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `schedule_name` VARCHAR(100) NOT NULL DEFAULT 'Every 2 Days',
    `frequency_days` INT(11) NOT NULL DEFAULT 2,
    `last_run` TIMESTAMP NULL DEFAULT NULL,
    `next_run` TIMESTAMP NULL DEFAULT NULL,
    `is_active` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_next_run` (`next_run`),
    INDEX `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Insert default backup schedule (every 2 days)
INSERT IGNORE INTO `backup_schedule` (`schedule_name`, `frequency_days`, `next_run`) 
VALUES ('Every 2 Days', 2, DATE_ADD(NOW(), INTERVAL 2 DAY));

-- 4. Create a sample manual backup entry (optional - for testing)
-- INSERT INTO `backup_logs` (`backup_name`, `backup_file`, `backup_size`, `created_by`, `backup_type`, `status`) 
-- VALUES ('sample_backup.sql', '/path/to/backups/sample_backup.sql', 1024, 'admin', 'manual', 'success');

-- Success message
SELECT 'Backup system tables created successfully!' AS status;
