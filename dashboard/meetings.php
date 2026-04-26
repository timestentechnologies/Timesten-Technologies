<?php
ob_start();
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS meeting_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    company VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    meeting_type VARCHAR(50),
    meeting_date DATE,
    meeting_time TIME,
    message TEXT,
    status ENUM('New','Contacted','Completed','Cancelled') DEFAULT 'New',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

$col_company = mysqli_query($con, "SHOW COLUMNS FROM meeting_bookings LIKE 'company'");
if (!$col_company || mysqli_num_rows($col_company) === 0) {
    @mysqli_query($con, "ALTER TABLE meeting_bookings ADD COLUMN company VARCHAR(255)");
}
$col_meeting_type = mysqli_query($con, "SHOW COLUMNS FROM meeting_bookings LIKE 'meeting_type'");
if (!$col_meeting_type || mysqli_num_rows($col_meeting_type) === 0) {
    @mysqli_query($con, "ALTER TABLE meeting_bookings ADD COLUMN meeting_type VARCHAR(50)");
}

$successmsg = '';
$errormsg = '';

if (isset($_POST['delete_id']) && is_numeric($_POST['delete_id'])) {
    $id = (int)$_POST['delete_id'];
    $query = "DELETE FROM meeting_bookings WHERE id = $id";
    if (mysqli_query($con, $query)) {
        header("Location: meetings?deleted=1");
        exit;
    } else {
        $errormsg = "<div class='alert alert-danger'>Error deleting meeting: " . mysqli_error($con) . "</div>";
    }
}

if (isset($_POST['update_status']) && isset($_POST['meeting_id']) && is_numeric($_POST['meeting_id'])) {
    $id = (int)$_POST['meeting_id'];
    $status = isset($_POST['status']) ? $_POST['status'] : 'New';
    $allowed = array('New','Contacted','Completed','Cancelled');
    if (!in_array($status, $allowed, true)) {
        $status = 'New';
    }
    $status_esc = mysqli_real_escape_string($con, $status);
    if (mysqli_query($con, "UPDATE meeting_bookings SET status = '$status_esc' WHERE id = $id")) {
        header("Location: meetings?updated=1");
        exit;
    } else {
        $errormsg = "<div class='alert alert-danger'>Error updating status: " . mysqli_error($con) . "</div>";
    }
}

if (isset($_GET['deleted']) && $_GET['deleted'] == '1') {
    $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Meeting deleted successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
}
if (isset($_GET['updated']) && $_GET['updated'] == '1') {
    $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Meeting status updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
}

$meetings = [];
$rs = mysqli_query($con, "SELECT * FROM meeting_bookings ORDER BY id DESC");
if ($rs) {
    while ($r = mysqli_fetch_assoc($rs)) {
        $meetings[] = $r;
    }
}
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Meeting Bookings</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Messages</a></li>
                                <li class="breadcrumb-item active">Meetings</li>
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
                            <h5 class="card-title mb-0">All Meeting Requests</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="meetings-table" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Company</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Type</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Message</th>
                                            <th>Status</th>
                                            <th>Created</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($meetings as $m): ?>
                                            <tr>
                                                <td><?php echo $m['id']; ?></td>
                                                <td><?php echo htmlspecialchars($m['name']); ?></td>
                                                <td><?php echo htmlspecialchars(isset($m['company']) ? $m['company'] : ''); ?></td>
                                                <td><?php echo htmlspecialchars($m['email']); ?></td>
                                                <td><?php echo htmlspecialchars($m['phone']); ?></td>
                                                <td><?php echo htmlspecialchars(isset($m['meeting_type']) ? $m['meeting_type'] : ''); ?></td>
                                                <td><?php echo htmlspecialchars($m['meeting_date']); ?></td>
                                                <td><?php echo htmlspecialchars(substr($m['meeting_time'], 0, 5)); ?></td>
                                                <td><?php echo nl2br(htmlspecialchars(substr($m['message'], 0, 80))) . (strlen($m['message']) > 80 ? '...' : ''); ?></td>
                                                <td>
                                                    <form method="POST" action="" class="d-flex gap-2 align-items-center">
                                                        <input type="hidden" name="meeting_id" value="<?php echo $m['id']; ?>">
                                                        <select name="status" class="form-select form-select-sm" style="min-width: 120px;">
                                                            <?php
                                                                $st = $m['status'];
                                                                $opts = array('New','Contacted','Completed','Cancelled');
                                                                foreach ($opts as $o) {
                                                                    $sel = ($o === $st) ? 'selected' : '';
                                                                    echo "<option value='" . htmlspecialchars($o, ENT_QUOTES) . "' $sel>" . htmlspecialchars($o) . "</option>";
                                                                }
                                                            ?>
                                                        </select>
                                                        <button type="submit" name="update_status" class="btn btn-sm btn-soft-primary">Update</button>
                                                    </form>
                                                </td>
                                                <td><?php echo date('Y-m-d H:i', strtotime($m['created_at'])); ?></td>
                                                <td>
                                                    <div class="dropdown d-inline-block">
                                                        <button class="btn btn-soft-secondary btn-sm dropdown" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                            <i class="ri-more-fill align-middle"></i>
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-end">
                                                            <li>
                                                                <a href="tel:<?php echo htmlspecialchars($m['phone']); ?>" class="dropdown-item">
                                                                    <i class="ri-phone-line align-bottom me-2 text-muted"></i> Call
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#" class="dropdown-item text-danger" data-bs-toggle="modal" data-bs-target="#deleteMeetingModal" data-delete-id="<?php echo $m['id']; ?>" data-name="<?php echo htmlspecialchars($m['name']); ?>">
                                                                    <i class="ri-delete-bin-line align-bottom me-2 text-danger"></i> Delete
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                        <?php if (empty($meetings)): ?>
                                            <tr>
                                                <td colspan="12" class="text-center">No meeting bookings found.</td>
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
</div>

<?php include "footer.php"; ?>

<div class="modal fade" id="deleteMeetingModal" tabindex="-1" aria-labelledby="deleteMeetingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteMeetingModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the meeting request from <strong id="deleteMeetingName"></strong>?</p>
                <p class="text-muted">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form method="POST" action="" class="d-inline">
                    <input type="hidden" name="delete_id" id="deleteMeetingIdInput">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
const deleteMeetingModal = document.getElementById('deleteMeetingModal');
if (deleteMeetingModal) {
    deleteMeetingModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const meetingId = button.getAttribute('data-delete-id');
        const meetingName = button.getAttribute('data-name');
        document.getElementById('deleteMeetingIdInput').value = meetingId;
        document.getElementById('deleteMeetingName').textContent = meetingName;
    });
}
</script>
