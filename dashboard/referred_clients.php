<?php
ob_start();
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS referrers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    token VARCHAR(100) UNIQUE NOT NULL,
    points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS referred_clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    referrer_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    message TEXT,
    status ENUM('Pending', 'Converted', 'Paid') DEFAULT 'Pending',
    commission_amount DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (referrer_id) REFERENCES referrers(id) ON DELETE CASCADE
)");

$successmsg = '';
$errormsg = '';

// Handle Status/Commission Update
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_status'])) {
    $id = (int)($_POST['id'] ?? 0);
    $status = mysqli_real_escape_string($con, $_POST['status']);
    $commission = (float)($_POST['commission_amount'] ?? 0);

    if ($id > 0) {
        $query = "UPDATE referred_clients SET status='$status', commission_amount='$commission' WHERE id=$id";
        if (mysqli_query($con, $query)) {
            $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Referred client status updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $errormsg = "<div class='alert alert-danger'>Error updating status: " . mysqli_error($con) . "</div>";
        }
    }
}

$clients = [];
$rs = mysqli_query($con, "SELECT c.*, r.name as referrer_name, r.token as referrer_token 
                         FROM referred_clients c 
                         JOIN referrers r ON c.referrer_id = r.id 
                         ORDER BY c.id DESC");
if ($rs) {
    while ($r = mysqli_fetch_assoc($rs)) {
        $clients[] = $r;
    }
}
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Referred Clients</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Referral Program</a></li>
                                <li class="breadcrumb-item active">Referred Clients</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <?php if (strlen($successmsg)) { print $successmsg; } ?>
            <?php if (strlen($errormsg)) { print $errormsg; } ?>

            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Clients Referred by Partners</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Client Info</th>
                                    <th>Referred By</th>
                                    <th>Message</th>
                                    <th>Status</th>
                                    <th>Commission</th>
                                    <th>Date</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                if (count($clients) < 1) {
                                    print "<tr><td colspan='7' class='text-center text-muted'>No referred clients yet.</td></tr>";
                                }
                                foreach ($clients as $c) {
                                    $id = (int)$c['id'];
                                    $cl_nm = htmlspecialchars((string)$c['name']);
                                    $cl_em = htmlspecialchars((string)$c['email']);
                                    $cl_ph = htmlspecialchars((string)$c['phone']);
                                    $cl_msg = htmlspecialchars((string)$c['message']);
                                    $ref_nm = htmlspecialchars((string)$c['referrer_name']);
                                    $status = $c['status'];
                                    $commission = number_format($c['commission_amount'], 2);
                                    $dt = date('M d, Y', strtotime($c['created_at']));

                                    $status_badge = 'warning';
                                    if ($status == 'Converted') $status_badge = 'primary';
                                    if ($status == 'Paid') $status_badge = 'success';

                                    print "<tr>";
                                    print "<td><strong>$cl_nm</strong><br><small>$cl_em | $cl_ph</small></td>";
                                    print "<td><span class='text-primary'>$ref_nm</span></td>";
                                    print "<td><div style='max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;'>$cl_msg</div></td>";
                                    print "<td><span class='badge badge-soft-$status_badge'>$status</span></td>";
                                    print "<td>Ksh $commission</td>";
                                    print "<td>$dt</td>";
                                    print "<td class='text-end'>";
                                    print "<button type='button' class='btn btn-sm btn-soft-secondary js-cl-edit' 
                                            data-id='$id' data-name='$cl_nm' data-status='$status' data-commission='{$c['commission_amount']}'>Manage</button>";
                                    print "</td>";
                                    print "</tr>";
                                }
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Manage Modal -->
            <div class="modal fade" id="manageModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Manage Referral: <span id="m_cl_name"></span></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form method="POST">
                            <div class="modal-body">
                                <input type="hidden" name="update_status" value="1">
                                <input type="hidden" name="id" id="m_cl_id">
                                
                                <div class="mb-3">
                                    <label class="form-label">Update Status</label>
                                    <select name="status" id="m_cl_status" class="form-select">
                                        <option value="Pending">Pending</option>
                                        <option value="Converted">Converted</option>
                                        <option value="Paid">Paid</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Commission Amount (Ksh)</label>
                                    <input type="number" step="0.01" name="commission_amount" id="m_cl_commission" class="form-control">
                                    <small class="text-muted">Record the amount to be paid or already paid to the referrer.</small>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var manageModal = new bootstrap.Modal(document.getElementById('manageModal'));
    
    document.addEventListener('click', function(e) {
        var btn = e.target.closest('.js-cl-edit');
        if (btn) {
            document.getElementById('m_cl_id').value = btn.getAttribute('data-id');
            document.getElementById('m_cl_name').textContent = btn.getAttribute('data-name');
            document.getElementById('m_cl_status').value = btn.getAttribute('data-status');
            document.getElementById('m_cl_commission').value = btn.getAttribute('data-commission');
            manageModal.show();
        }
    });
});
</script>

<?php include "footer.php"; ?>
