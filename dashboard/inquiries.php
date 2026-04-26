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

// Handle delete via POST (from modal)
if (isset($_POST['delete_id']) && is_numeric($_POST['delete_id'])) {
    $id = (int)$_POST['delete_id'];
    $query = "DELETE FROM contact_messages WHERE id = $id";
    if (mysqli_query($con, $query)) {
        header("Location: inquiries?deleted=1");
        exit;
    } else {
        $errormsg = "<div class='alert alert-danger'>Error deleting inquiry: " . mysqli_error($con) . "</div>";
    }
}

// Show success message after redirect
if (isset($_GET['deleted']) && $_GET['deleted'] == '1') {
    $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Inquiry deleted successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
}

// Handle reply email sending
if (isset($_POST['send_reply']) && isset($_POST['inquiry_id'])) {
    $inquiry_id = (int)$_POST['inquiry_id'];
    $reply_message = mysqli_real_escape_string($con, $_POST['reply_message']);
    $reply_type = $_POST['reply_type']; // 'email' or 'whatsapp'
    
    // Get inquiry details
    $inq_res = mysqli_query($con, "SELECT * FROM contact_messages WHERE id = $inquiry_id");
    if ($inq_res && mysqli_num_rows($inq_res) > 0) {
        $inquiry = mysqli_fetch_assoc($inq_res);
        
        if ($reply_type == 'email' && !empty($inquiry['email'])) {
            // Send email reply
            $to = $inquiry['email'];
            $subject = "Re: Your inquiry to TimesTen Technologies";
            $headers = "From: timestenkenya@gmail.com\r\n";
            $headers .= "Reply-To: timestenkenya@gmail.com\r\n";
            $headers .= "Content-Type: text/html; charset=UTF-8\r\n";
            
            $email_body = "
            <html>
            <body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>
                <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                    <h2 style='color: #3b1b6a;'>Hello " . htmlspecialchars($inquiry['name']) . "!</h2>
                    <p>Thank you for contacting TimesTen Technologies. Here is our response to your inquiry:</p>
                    <div style='background: #f5f5f5; padding: 15px; border-left: 4px solid #3b1b6a; margin: 20px 0;'>
                        " . nl2br(htmlspecialchars($reply_message)) . "
                    </div>
                    <p style='margin-top: 30px;'>Best regards,<br><strong>TimesTen Technologies Team</strong></p>
                    <hr style='border: none; border-top: 1px solid #ddd; margin: 20px 0;'>
                    <p style='font-size: 12px; color: #999;'>This is in response to your message:<br>" . nl2br(htmlspecialchars(substr($inquiry['message'], 0, 200))) . "...</p>
                </div>
            </body>
            </html>
            ";
            
            if (mail($to, $subject, $email_body, $headers)) {
                $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Reply email sent successfully!<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } else {
                $errormsg = "<div class='alert alert-danger'>Failed to send email. Please try again.</div>";
            }
        } elseif ($reply_type == 'whatsapp' && !empty($inquiry['phone'])) {
            // Generate WhatsApp link
            $whatsapp_msg = urlencode("Hello " . $inquiry['name'] . "!\n\nThank you for contacting TimesTen Technologies.\n\n" . $reply_message . "\n\nBest regards,\nTimesTen Technologies Team");
            $whatsapp_link = "https://wa.me/" . preg_replace('/[^0-9]/', '', $inquiry['phone']) . "?text=" . $whatsapp_msg;
            
            $successmsg = "<div class='alert alert-success alert-dismissible fade show'>WhatsApp message prepared! <a href='$whatsapp_link' target='_blank' class='alert-link'>Click here to open WhatsApp</a><button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
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
                            <div class="table-responsive">
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
                                                    <li><a href="#" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#replyModal" data-inquiry-id="<?php echo $inquiry['id']; ?>" data-name="<?php echo htmlspecialchars($inquiry['name']); ?>" data-email="<?php echo htmlspecialchars($inquiry['email']); ?>" data-phone="<?php echo htmlspecialchars($inquiry['phone']); ?>"><i class="ri-mail-line align-bottom me-2 text-muted"></i> Reply</a></li>
                                                    <li><a href="tel:<?php echo $inquiry['phone']; ?>" class="dropdown-item"><i class="ri-phone-line align-bottom me-2 text-muted"></i> Call</a></li>
                                                    <li><a href="#" class="dropdown-item text-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" data-delete-id="<?php echo $inquiry['id']; ?>" data-name="<?php echo htmlspecialchars($inquiry['name']); ?>" ><i class="ri-delete-bin-line align-bottom me-2 text-danger"></i> Delete</a></li>
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
</div>

<?php include "footer.php"; ?>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the inquiry from <strong id="deleteInquiryName"></strong>?</p>
                <p class="text-muted">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form method="POST" action="" class="d-inline">
                    <input type="hidden" name="delete_id" id="deleteIdInput">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Reply Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="replyModalLabel">Reply to <span id="replyInquiryName"></span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="POST" action="">
                <div class="modal-body">
                    <input type="hidden" name="inquiry_id" id="replyInquiryId">
                    <div class="mb-3">
                        <label class="form-label">Reply Method</label>
                        <div class="d-flex gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="reply_type" id="replyEmail" value="email" checked>
                                <label class="form-check-label" for="replyEmail">
                                    <i class="ri-mail-line me-1"></i> Email
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="reply_type" id="replyWhatsapp" value="whatsapp">
                                <label class="form-check-label" for="replyWhatsapp">
                                    <i class="ri-whatsapp-line me-1"></i> WhatsApp
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="replyMessage" class="form-label">Your Message</label>
                        <textarea class="form-control" id="replyMessage" name="reply_message" rows="6" required placeholder="Type your reply message here..."></textarea>
                    </div>
                    <div class="alert alert-info" id="replyInfo">
                        <i class="ri-information-line me-2"></i>
                        <span id="replyInfoText">Email will be sent to: <strong id="replyEmailDisplay"></strong></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" name="send_reply" class="btn btn-primary">
                        <i class="ri-send-plane-line me-1"></i> Send Reply
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// Delete Modal
const deleteModal = document.getElementById('deleteModal');
deleteModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const inquiryId = button.getAttribute('data-delete-id');
    const inquiryName = button.getAttribute('data-name');
    
    document.getElementById('deleteIdInput').value = inquiryId;
    document.getElementById('deleteInquiryName').textContent = inquiryName;
});

// Reply Modal
const replyModal = document.getElementById('replyModal');
replyModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const inquiryId = button.getAttribute('data-inquiry-id');
    const name = button.getAttribute('data-name');
    const email = button.getAttribute('data-email');
    const phone = button.getAttribute('data-phone');
    
    document.getElementById('replyInquiryId').value = inquiryId;
    document.getElementById('replyInquiryName').textContent = name;
    document.getElementById('replyEmailDisplay').textContent = email || 'N/A';
    
    // Update info text based on available contact methods
    const emailRadio = document.getElementById('replyEmail');
    const whatsappRadio = document.getElementById('replyWhatsapp');
    
    if (!email || email === '') {
        emailRadio.disabled = true;
        whatsappRadio.checked = true;
    } else {
        emailRadio.disabled = false;
    }
    
    if (!phone || phone === '') {
        whatsappRadio.disabled = true;
    } else {
        whatsappRadio.disabled = false;
    }
    
    updateReplyInfo();
});

// Update reply info text when radio changes
document.querySelectorAll('input[name="reply_type"]').forEach(radio => {
    radio.addEventListener('change', updateReplyInfo);
});

function updateReplyInfo() {
    const email = document.getElementById('replyEmailDisplay').textContent;
    const phone = document.getElementById('replyEmailDisplay').getAttribute('data-phone');
    const isEmail = document.getElementById('replyEmail').checked;
    
    if (isEmail) {
        document.getElementById('replyInfoText').innerHTML = 'Email will be sent to: <strong>' + email + '</strong>';
    } else {
        document.getElementById('replyInfoText').innerHTML = 'WhatsApp message will be sent to: <strong>' + phone + '</strong>';
    }
}
</script>
