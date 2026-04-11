<?php 
session_start();
include "z_db.php";

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

$message = "";
$status = "success";
$referrer = null;

// Handle registration
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['register'])) {
    $name = mysqli_real_escape_string($con, $_POST['name']);
    $email = mysqli_real_escape_string($con, $_POST['email']);
    $phone = mysqli_real_escape_string($con, $_POST['phone']);
    $token = bin2hex(random_bytes(8));

    $check = mysqli_query($con, "SELECT id FROM referrers WHERE email = '$email' OR (phone = '$phone' AND phone != '')");
    if (mysqli_num_rows($check) > 0) {
        $message = "You are already registered! Use your existing link.";
        $status = "info";
        $row = mysqli_fetch_assoc($check);
        $token_rs = mysqli_query($con, "SELECT token FROM referrers WHERE id = " . $row['id']);
        $token_row = mysqli_fetch_assoc($token_rs);
        $token = $token_row['token'];
    } else {
        $query = "INSERT INTO referrers (name, email, phone, token) VALUES ('$name', '$email', '$phone', '$token')";
        if (mysqli_query($con, $query)) {
            $message = "Registration successful! Start referring and earning.";
        } else {
            $message = "Error: " . mysqli_error($con);
            $status = "error";
        }
    }
    header("Location: refer?token=$token&msg=" . urlencode($message) . "&status=$status");
    exit;
}

// Handle tracking/dashboard
$token = isset($_GET['token']) ? mysqli_real_escape_string($con, $_GET['token']) : null;
if ($token) {
    $res = mysqli_query($con, "SELECT * FROM referrers WHERE token = '$token'");
    $referrer = mysqli_fetch_assoc($res);
}

// Handle redemption request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['redeem']) && $referrer) {
    if ($referrer['points'] >= 1000) {
        // Log redemption request (could be a new table, but for now we'll just note it)
        // In a real system, you'd probably deduct points or mark as 'Redemption Pending'
        $message = "Redemption request sent! Our team will contact you shortly.";
        $status = "success";
    } else {
        $message = "You need at least 1000 points to redeem.";
        $status = "error";
    }
}

$page_title = "Refer & Earn";
include "header.php";
?>

<section class="section breadcrumb-area overlay-dark d-flex align-items-center">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumb-content d-flex flex-column align-items-center text-center">
                    <h2 class="text-white text-uppercase mb-3">Refer & Earn</h2>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="text-uppercase text-white" href="home">Home</a></li>
                        <li class="breadcrumb-item text-white active">Refer & Earn</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="refer-area ptb_100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-8">
                <?php if (isset($_GET['msg'])): ?>
                    <div class="alert alert-<?php echo $_GET['status'] == 'error' ? 'danger' : ($_GET['status'] == 'info' ? 'info' : 'success'); ?> alert-dismissible fade show" role="alert">
                        <?php echo htmlspecialchars($_GET['msg']); ?>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                <?php endif; ?>

                <?php if ($referrer): ?>
                    <!-- Referrer Dashboard -->
                    <div class="card shadow-lg border-0 rounded-lg">
                        <div class="card-body p-5">
                            <div class="text-center mb-5">
                                <h2 class="fw-7">Welcome, <?php echo htmlspecialchars($referrer['name']); ?>!</h2>
                                <p class="text-muted">Track your referrals and rewards below.</p>
                            </div>

                            <div class="row text-center mb-5">
                                <div class="col-md-6 mb-4 mb-md-0">
                                    <div class="p-4 bg-light rounded-lg">
                                        <h3 class="display-4 fw-7 text-primary"><?php echo $referrer['points']; ?></h3>
                                        <p class="text-uppercase fw-5 mb-0">Total Points</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-4 bg-light rounded-lg">
                                        <?php 
                                        $ref_count_res = mysqli_query($con, "SELECT COUNT(*) as total FROM referred_clients WHERE referrer_id = " . $referrer['id']);
                                        $ref_count = mysqli_fetch_assoc($ref_count_res)['total'];
                                        ?>
                                        <h3 class="display-4 fw-7 text-success"><?php echo $ref_count; ?></h3>
                                        <p class="text-uppercase fw-5 mb-0">Successful Referrals</p>
                                    </div>
                                </div>
                            </div>

                            <div class="referral-link-box p-4 bg-primary text-white rounded-lg mb-5">
                                <h5 class="text-white mb-3">Your Unique Referral Link:</h5>
                                <div class="input-group">
                                    <input type="text" class="form-control bg-white" id="referralLink" value="<?php echo "https://" . $_SERVER['HTTP_HOST'] . "/?ref=" . $referrer['token']; ?>" readonly>
                                    <div class="input-group-append">
                                        <button class="btn btn-dark" onclick="copyLink()">Copy Link</button>
                                    </div>
                                </div>
                                <p class="small mt-2 mb-0 opacity-75">Share this link with your network. You earn 100 points for every person who contacts us through your link!</p>
                            </div>

                            <div class="mb-5">
                                <h4 class="fw-6 mb-4">Referral Status</h4>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Client Name</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php 
                                            $clients_res = mysqli_query($con, "SELECT * FROM referred_clients WHERE referrer_id = " . $referrer['id'] . " ORDER BY created_at DESC");
                                            if (mysqli_num_rows($clients_res) > 0):
                                                while($client = mysqli_fetch_assoc($clients_res)):
                                            ?>
                                                <tr>
                                                    <td><?php echo htmlspecialchars($client['name']); ?></td>
                                                    <td><?php echo date('M d, Y', strtotime($client['created_at'])); ?></td>
                                                    <td><span class="badge badge-<?php echo $client['status'] == 'Paid' ? 'success' : ($client['status'] == 'Converted' ? 'primary' : 'warning'); ?>"><?php echo $client['status']; ?></span></td>
                                                </tr>
                                            <?php endwhile; else: ?>
                                                <tr>
                                                    <td colspan="3" class="text-center text-muted">No referrals yet. Start sharing!</td>
                                                </tr>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="text-center">
                                <form method="POST">
                                    <button type="submit" name="redeem" class="btn btn-bordered-primary btn-lg" <?php echo $referrer['points'] < 1000 ? 'disabled' : ''; ?>>
                                        Redeem Rewards (1000 Points Required)
                                    </button>
                                </form>
                                <?php if ($referrer['points'] < 1000): ?>
                                    <p class="small text-muted mt-2">You need <?php echo (1000 - $referrer['points']); ?> more points to redeem.</p>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                <?php else: ?>
                    <!-- Registration Form -->
                    <div class="card shadow-lg border-0 rounded-lg overflow-hidden">
                        <div class="row no-gutters">
                            <div class="col-lg-5 bg-primary p-5 d-flex align-items-center">
                                <div class="text-white">
                                    <h2 class="text-white fw-7 mb-4">Why Refer?</h2>
                                    <ul class="list-unstyled">
                                        <li class="mb-3 d-flex align-items-center"><i class="fas fa-check-circle mr-3"></i> Earn 100 points per lead</li>
                                        <li class="mb-3 d-flex align-items-center"><i class="fas fa-check-circle mr-3"></i> High conversion rewards</li>
                                        <li class="mb-3 d-flex align-items-center"><i class="fas fa-check-circle mr-3"></i> Easy tracking with no account</li>
                                        <li class="mb-3 d-flex align-items-center"><i class="fas fa-check-circle mr-3"></i> Exclusive partner perks</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-lg-7 p-5">
                                <h2 class="fw-7 mb-4">Become a Partner</h2>
                                <p class="text-muted mb-4">Fill out the form below to get your unique referral link and start earning today.</p>
                                <form action="" method="POST">
                                    <div class="form-group mb-3">
                                        <input type="text" name="name" class="form-control py-4" placeholder="Full Name" required>
                                    </div>
                                    <div class="form-group mb-3">
                                        <input type="email" name="email" class="form-control py-4" placeholder="Email Address" required>
                                    </div>
                                    <div class="form-group mb-4">
                                        <input type="tel" name="phone" class="form-control py-4" placeholder="Phone Number" required>
                                    </div>
                                    <button type="submit" name="register" class="btn btn-primary btn-block btn-lg py-3">Get My Referral Link</button>
                                </form>
                                <p class="text-center mt-4 mb-0 small text-muted">Already registered? Just check the link we sent to you or re-enter your details to get your link.</p>
                            </div>
                        </div>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>

<script>
function copyLink() {
    var copyText = document.getElementById("referralLink");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
    alert("Referral link copied to clipboard!");
}
</script>

<style>
.bg-primary { background-color: #f67011 !important; }
.text-primary { color: #f67011 !important; }
.btn-primary { background-color: #f67011; border-color: #f67011; }
.btn-primary:hover { background-color: #e5650f; border-color: #e5650f; }
.btn-bordered-primary { border: 2px solid #f67011; color: #f67011; background: transparent; }
.btn-bordered-primary:hover { background-color: #f67011; color: #white; }
.rounded-lg { border-radius: 15px !important; }
.fw-7 { font-weight: 700; }
.fw-6 { font-weight: 600; }
.fw-5 { font-weight: 500; }
.referral-link-box { border-left: 5px solid #000; }
</style>

<?php include "footer.php"; ?>
