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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_referrer'])) {
    $id = (int)($_POST['id'] ?? 0);
    if ($id > 0) {
        mysqli_query($con, "DELETE FROM referrers WHERE id=$id LIMIT 1");
        $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Referrer deleted successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
}

$referrers = [];
$rs = mysqli_query($con, "SELECT r.*, (SELECT COUNT(*) FROM referred_clients WHERE referrer_id = r.id) as ref_count FROM referrers r ORDER BY r.id DESC");
if ($rs) {
    while ($r = mysqli_fetch_assoc($rs)) {
        $referrers[] = $r;
    }
}
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Referrers</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Referral Program</a></li>
                                <li class="breadcrumb-item active">Referrers</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <?php if (strlen($successmsg)) { print $successmsg; } ?>

            <div class="card">
                <div class="card-header d-flex align-items-center">
                    <h5 class="card-title mb-0">Registered Referrers</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped align-middle mb-0" id="referrersTable">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email / Phone</th>
                                    <th>Token</th>
                                    <th>Points</th>
                                    <th>Referrals</th>
                                    <th>Joined Date</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                if (count($referrers) < 1) {
                                    print "<tr><td colspan='7' class='text-center text-muted'>No referrers registered yet.</td></tr>";
                                }
                                foreach ($referrers as $r) {
                                    $id = (int)$r['id'];
                                    $nm = htmlspecialchars((string)$r['name']);
                                    $em = htmlspecialchars((string)$r['email']);
                                    $ph = htmlspecialchars((string)$r['phone']);
                                    $tk = htmlspecialchars((string)$r['token']);
                                    $pt = (int)$r['points'];
                                    $rc = (int)$r['ref_count'];
                                    $dt = date('M d, Y', strtotime($r['created_at']));

                                    print "<tr>";
                                    print "<td>$nm</td>";
                                    print "<td>$em<br><small class='text-muted'>$ph</small></td>";
                                    print "<td><code>$tk</code></td>";
                                    print "<td><span class='badge badge-soft-primary'>$pt Points</span></td>";
                                    print "<td><span class='badge badge-soft-success'>$rc Leads</span></td>";
                                    print "<td>$dt</td>";
                                    print "<td class='text-end'>";
                                    print "<button type='button' class='btn btn-sm btn-soft-danger js-ref-del' data-id='$id' data-name='$nm'>Delete</button>";
                                    print "</td>";
                                    print "</tr>";
                                }
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteReferrerModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirm Delete</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete referrer <strong id="d_ref_name"></strong>? This will also delete all their referral records.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                            <form method="post" class="mb-0">
                                <input type="hidden" name="delete_referrer" value="1">
                                <input type="hidden" name="id" id="d_ref_id" value="">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var delModal = new bootstrap.Modal(document.getElementById('deleteReferrerModal'));
    
    document.addEventListener('click', function(e) {
        var btn = e.target.closest('.js-ref-del');
        if (btn) {
            document.getElementById('d_ref_id').value = btn.getAttribute('data-id');
            document.getElementById('d_ref_name').textContent = btn.getAttribute('data-name');
            delModal.show();
        }
    });
});
</script>

<?php include "footer.php"; ?>
