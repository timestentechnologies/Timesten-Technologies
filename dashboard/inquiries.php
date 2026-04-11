<?php
ob_start();
include "header.php";
include "sidebar.php";

// Create table if it doesn't exist
mysqli_query($con, "CREATE TABLE IF NOT EXISTS contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    message TEXT,
    ref_code VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

$successmsg = '';
$errormsg = '';

// Handle delete
if (isset($_GET['delete']) && is_numeric($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    $query = "DELETE FROM contact_messages WHERE id = $id";
    if (mysqli_query($con, $query)) {
        $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Inquiry deleted successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        $errormsg = "<div class='alert alert-danger'>Error deleting inquiry: " . mysqli_error($con) . "</div>";
    }
}

// Fetch all inquiries
$inquiries = [];
$rs = mysqli_query($con, "SELECT * FROM contact_messages ORDER BY id DESC");
if ($rs) {
    while ($r = mysqli_fetch_assoc($rs)) {
        $inquiries[] = $r;
    }
}
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Contact Inquiries</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Messages</a></li>
                                <li class="breadcrumb-item active">Inquiries</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <?php if (strlen($successmsg)) { print $successmsg; } ?>
            <?php if (strlen($errormsg)) { print $errormsg; } ?>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">All Contact Inquiries</h5>
                        </div>
                        <div class="card-body">
                            <table id="inquiries-table" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Referral Code</th>
                                        <th>Message</th>
                                        <th>Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($inquiries as $inquiry): ?>
                                    <tr>
                                        <td><?php echo $inquiry['id']; ?></td>
                                        <td><?php echo htmlspecialchars($inquiry['name']); ?></td>
                                        <td><?php echo htmlspecialchars($inquiry['email']); ?></td>
                                        <td><?php echo htmlspecialchars($inquiry['phone']); ?></td>
                                        <td>
                                            <?php if (!empty($inquiry['ref_code'])): ?>
                                                <span class="badge bg-success"><?php echo htmlspecialchars($inquiry['ref_code']); ?></span>
                                            <?php else: ?>
                                                <span class="badge bg-secondary">None</span>
                                            <?php endif; ?>
                                        </td>
                                        <td><?php echo nl2br(htmlspecialchars(substr($inquiry['message'], 0, 100))) . (strlen($inquiry['message']) > 100 ? '...' : ''); ?></td>
                                        <td><?php echo date('Y-m-d H:i', strtotime($inquiry['created_at'])); ?></td>
                                        <td>
                                            <div class="dropdown d-inline-block">
                                                <button class="btn btn-soft-secondary btn-sm dropdown" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="ri-more-fill align-middle"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <li><a href="mailto:<?php echo $inquiry['email']; ?>" class="dropdown-item"><i class="ri-mail-line align-bottom me-2 text-muted"></i> Reply</a></li>
                                                    <li><a href="tel:<?php echo $inquiry['phone']; ?>" class="dropdown-item"><i class="ri-phone-line align-bottom me-2 text-muted"></i> Call</a></li>
                                                    <li><a href="?delete=<?php echo $inquiry['id']; ?>" class="dropdown-item text-danger" onclick="return confirm('Are you sure you want to delete this inquiry?');"><i class="ri-delete-bin-line align-bottom me-2 text-danger"></i> Delete</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    <?php if (empty($inquiries)): ?>
                                    <tr>
                                        <td colspan="8" class="text-center">No inquiries found.</td>
                                    </tr>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<?php include "footer.php"; ?>
