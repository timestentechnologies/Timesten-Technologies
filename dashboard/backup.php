<?php
include"header.php";
$username=$_SESSION['username'];

// Create backup directory if it doesn't exist
$backup_dir = __DIR__ . '/backups';
if (!file_exists($backup_dir)) {
    mkdir($backup_dir, 0755, true);
}

// Handle backup creation
if (isset($_POST['create_backup'])) {
    $backup_name = 'backup_' . date('Y-m-d_H-i-s') . '.sql';
    $backup_file = $backup_dir . '/' . $backup_name;
    
    // Get database configuration
    $db_host = 'localhost';
    $db_user = 'opulentl_timesten';
    $db_pass = 'Moonlight#911';
    $db_name = 'opulentl_timestentech';
    
    // Create backup using mysqldump
    $command = "mysqldump --host={$db_host} --user={$db_user} --password={$db_pass} {$db_name} > {$backup_file}";
    exec($command, $output, $return_var);
    
    if ($return_var === 0) {
        // Log backup to database
        $backup_size = filesize($backup_file);
        $log_sql = "INSERT INTO backup_logs (backup_name, backup_file, backup_size, created_at, created_by) 
                    VALUES ('$backup_name', '$backup_file', $backup_size, NOW(), '$username')";
        mysqli_query($con, $log_sql);
        
        $success_message = "Backup created successfully: $backup_name";
    } else {
        $error_message = "Failed to create backup. Please check server configuration.";
    }
}

// Handle backup deletion
if (isset($_POST['delete_backup'])) {
    $backup_id = (int)$_POST['backup_id'];
    
    // Get backup info
    $result = mysqli_query($con, "SELECT backup_file FROM backup_logs WHERE id = $backup_id");
    if ($row = mysqli_fetch_assoc($result)) {
        $backup_file = $row['backup_file'];
        
        // Delete file if exists
        if (file_exists($backup_file)) {
            unlink($backup_file);
        }
        
        // Delete from database
        mysqli_query($con, "DELETE FROM backup_logs WHERE id = $backup_id");
        $success_message = "Backup deleted successfully";
    }
}

// Handle backup download
if (isset($_GET['download'])) {
    $backup_id = (int)$_GET['download'];
    
    $result = mysqli_query($con, "SELECT backup_name, backup_file FROM backup_logs WHERE id = $backup_id");
    if ($row = mysqli_fetch_assoc($result)) {
        $backup_file = $row['backup_file'];
        $backup_name = $row['backup_name'];
        
        if (file_exists($backup_file)) {
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . $backup_name . '"');
            header('Content-Length: ' . filesize($backup_file));
            readfile($backup_file);
            exit;
        }
    }
}

// Get backup history
$backups = [];
$result = mysqli_query($con, "SELECT * FROM backup_logs ORDER BY created_at DESC");
while ($row = mysqli_fetch_assoc($result)) {
    $backups[] = $row;
}

// Check if automatic backup is needed (every 2 days)
$last_backup = null;
if (!empty($backups)) {
    $last_backup = $backups[0]['created_at'];
    $days_since_last = (strtotime(date('Y-m-d')) - strtotime(date('Y-m-d', strtotime($last_backup)))) / (60 * 60 * 24);
    
    if ($days_since_last >= 2) {
        // Auto backup logic would go here - for now we'll just show a notification
        $auto_backup_needed = true;
    }
}
?>

<?php include"sidebar.php";?>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">
            <!-- start page title -->
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Database Backup</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript: void(0);">Dashboard</a></li>
                                <li class="breadcrumb-item active">Backup</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end page title -->

            <?php if (isset($success_message)): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <?php echo $success_message; ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <?php endif; ?>

            <?php if (isset($error_message)): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <?php echo $error_message; ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <?php endif; ?>

            <?php if (isset($auto_backup_needed)): ?>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <strong>Automatic Backup Recommended:</strong> It's been more than 2 days since the last backup. Consider creating a new backup.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <?php endif; ?>

            <div class="row">
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Create New Backup</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted mb-3">Create a complete backup of your database. Backups are recommended every 2 days.</p>
                            <form method="post">
                                <button type="submit" name="create_backup" class="btn btn-primary">
                                    <i class="ri-download-2-line me-2"></i>Create Backup Now
                                </button>
                            </form>
                        </div>
                    </div>

                    <div class="card mt-3">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Backup Schedule</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <i class="ri-time-line text-primary me-3 fs-4"></i>
                                <div>
                                    <h6 class="mb-1">Automatic Schedule</h6>
                                    <p class="text-muted mb-0">Every 2 days</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="ri-database-2-line text-success me-3 fs-4"></i>
                                <div>
                                    <h6 class="mb-1">Last Backup</h6>
                                    <p class="text-muted mb-0">
                                        <?php 
                                        if (!empty($backups)) {
                                            echo date('M j, Y H:i', strtotime($backups[0]['created_at']));
                                        } else {
                                            echo 'No backups yet';
                                        }
                                        ?>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Backup History</h5>
                        </div>
                        <div class="card-body">
                            <?php if (empty($backups)): ?>
                                <div class="text-center py-5">
                                    <i class="ri-database-2-line fs-1 text-muted"></i>
                                    <h5 class="mt-3">No Backups Yet</h5>
                                    <p class="text-muted">Create your first backup to get started.</p>
                                </div>
                            <?php else: ?>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Backup Name</th>
                                                <th>Size</th>
                                                <th>Created</th>
                                                <th>Created By</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($backups as $backup): ?>
                                                <tr>
                                                    <td>
                                                        <i class="ri-file-text-line text-primary me-2"></i>
                                                        <?php echo htmlspecialchars($backup['backup_name']); ?>
                                                    </td>
                                                    <td><?php echo number_format($backup['backup_size'] / 1024 / 1024, 2); ?> MB</td>
                                                    <td><?php echo date('M j, Y H:i', strtotime($backup['created_at'])); ?></td>
                                                    <td><?php echo htmlspecialchars($backup['created_by']); ?></td>
                                                    <td>
                                                        <a href="?download=<?php echo $backup['id']; ?>" class="btn btn-sm btn-outline-primary me-1" title="Download">
                                                            <i class="ri-download-line"></i>
                                                        </a>
                                                        <form method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this backup?');">
                                                            <input type="hidden" name="backup_id" value="<?php echo $backup['id']; ?>">
                                                            <button type="submit" name="delete_backup" class="btn btn-sm btn-outline-danger" title="Delete">
                                                                <i class="ri-delete-bin-line"></i>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Backup Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>What gets backed up?</h6>
                                    <ul class="list-unstyled">
                                        <li><i class="ri-checkbox-circle-line text-success me-2"></i>All database tables</li>
                                        <li><i class="ri-checkbox-circle-line text-success me-2"></i>Blog posts and content</li>
                                        <li><i class="ri-checkbox-circle-line text-success me-2"></i>Services and portfolio items</li>
                                        <li><i class="ri-checkbox-circle-line text-success me-2"></i>Job listings and applications</li>
                                        <li><i class="ri-checkbox-circle-line text-success me-2"></i>User accounts and settings</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h6>Best Practices</h6>
                                    <ul class="list-unstyled">
                                        <li><i class="ri-information-line text-info me-2"></i>Create backups regularly (every 2 days)</li>
                                        <li><i class="ri-information-line text-info me-2"></i>Download important backups to local storage</li>
                                        <li><i class="ri-information-line text-info me-2"></i>Keep multiple backup versions</li>
                                        <li><i class="ri-information-line text-info me-2"></i>Test backup restoration periodically</li>
                                        <li><i class="ri-information-line text-info me-2"></i>Monitor backup file sizes</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include"footer.php";?>
