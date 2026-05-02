<?php
include "header.php";
$todo = mysqli_real_escape_string($con, $_GET["id"]);
?>

<style>
/* Blog Detail Specific Styles */
.blog-main-title {
    font-size: 1.8rem;
    font-weight: 700;
    color: #2c3e50;
    word-wrap: break-word;
    word-break: break-word;
    hyphens: auto;
    line-height: 1.3;
    margin-bottom: 1.5rem;
    text-align: center;
}

.blog-subtitle {
    font-size: 1.1rem;
    font-weight: 500;
    color: #666;
    word-wrap: break-word;
    word-break: break-word;
    hyphens: auto;
    line-height: 1.5;
    margin-bottom: 1.5rem;
    font-style: italic;
    text-align: center;
}

.blog-content {
    font-size: 1.05rem;
    line-height: 1.7;
    color: #333;
    margin-top: 2rem;
    max-width: 100%;
    overflow-wrap: break-word;
    word-wrap: break-word;
    word-break: break-word;
}

.blog-content p {
    margin-bottom: 1.2rem;
    text-align: justify;
}

.about-thumb {
    max-width: 100%;
    overflow: hidden;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    border: 1px solid #f0f0f0;
}

.about-thumb img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    border-radius: 12px;
    transition: transform 0.3s ease;
}

.about-thumb:hover img {
    transform: scale(1.02);
}

/* Responsive adjustments */
@media (max-width: 1199px) {
    .blog-main-title {
        font-size: 1.6rem;
    }
    
    .blog-subtitle {
        font-size: 1rem;
    }
}

@media (max-width: 991px) {
    .about-area .row {
        flex-direction: column;
    }
    
    .about-area .col-lg-6:first-child {
        margin-bottom: 2rem;
    }
    
    .about-content {
        text-align: center !important;
        padding-left: 0 !important;
        margin-top: 0 !important;
    }
    
    .blog-main-title {
        font-size: 1.4rem;
    }
    
    .blog-subtitle {
        font-size: 0.95rem;
    }
}

@media (max-width: 768px) {
    .blog-main-title {
        font-size: 1.3rem;
        line-height: 1.3;
    }
    
    .blog-subtitle {
        font-size: 0.9rem;
    }
    
    .about-thumb {
        margin-bottom: 1.5rem;
    }
    
    .blog-metadata {
        flex-wrap: wrap;
        gap: 1rem;
    }
    
    .blog-metadata-item {
        font-size: 0.85rem;
    }
}

@media (max-width: 576px) {
    .blog-main-title {
        font-size: 1.2rem;
    }
    
    .blog-subtitle {
        font-size: 0.9rem;
    }
}

.about-content {
    max-width: 100%;
    overflow: hidden;
}

.blog-metadata {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    margin: 1rem 0;
    color: #666;
    font-size: 0.9rem;
}

.blog-metadata-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.blog-metadata-item i {
    color: #3b1b6a;
}

/* Blog Detail Layout Styles */
.blog-detail-area {
    background: #f8f9fa !important;
}

.blog-header {
    background: #fff;
    padding: 3rem 2rem;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    margin-bottom: 2rem;
}

.blog-featured-image {
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    border: 1px solid #e6e6e6;
}

.blog-featured-image img {
    width: 100%;
    height: 400px;
    object-fit: cover;
    border-radius: 12px;
    transition: transform 0.3s ease;
}

.blog-featured-image:hover img {
    transform: scale(1.02);
}

.blog-content-wrapper {
    background: #fff;
    padding: 3rem;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    line-height: 1.8;
}

.blog-content {
    font-size: 1.05rem;
    line-height: 1.8;
    color: #333;
    text-align: justify;
}

.blog-content p {
    margin-bottom: 1.5rem;
    text-indent: 0;
}

.blog-content p:first-child::first-letter {
    font-size: 3rem;
    font-weight: bold;
    color: #ff8c00;
    float: left;
    line-height: 1;
    margin-right: 8px;
    margin-top: -4px;
}

@media (max-width: 768px) {
    .blog-header {
        padding: 2rem 1.5rem;
        margin-bottom: 1.5rem;
    }
    
    .blog-featured-image img {
        height: 250px;
    }
    
    .blog-content-wrapper {
        padding: 2rem 1.5rem;
    }
    
    .blog-content p:first-child::first-letter {
        font-size: 2rem;
    }
}
</style>

<!-- ***** Breadcrumb Area Start ***** -->
<section class="section breadcrumb-area overlay-dark d-flex align-items-center">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <!-- Breadcrumb Content -->
                <div class="breadcrumb-content d-flex flex-column align-items-center text-center">
                    <h2 class="text-white text-uppercase mb-3">Blog Details</h2>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                        <li class="breadcrumb-item text-white active">Blog</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ***** Breadcrumb Area End ***** -->

<?php
$rt = mysqli_query($con, "SELECT * FROM blog WHERE id='$todo'");
$tr = mysqli_fetch_array($rt);
$blog_title = $tr['blog_title'];
$blog_desc = $tr['blog_desc'];
$blog_detail = $tr['blog_detail'];
$ufile = $tr['ufile'];
?>

<!-- ***** Blog Detail Area Start ***** -->
<section class="section blog-detail-area ptb_100" style="background: #f8f9fa;">
    <div class="container">
        <!-- Blog Header -->
        <div class="row mb-5">
            <div class="col-12">
                <div class="blog-header text-center">
                    <!-- Blog Title -->
                    <h1 class="blog-main-title">
                        <?php echo htmlspecialchars($blog_title); ?>
                    </h1>
                    
                    <!-- Blog Description (if different from title) -->
                    <?php if (!empty($blog_desc) && $blog_desc !== $blog_title): ?>
                        <h3 class="blog-subtitle">
                            <?php echo htmlspecialchars($blog_desc); ?>
                        </h3>
                    <?php endif; ?>

                    <!-- Blog Metadata -->
                    <div class="blog-metadata justify-content-center">
                        <div class="blog-metadata-item">
                            <i class="fas fa-eye"></i>
                            <span>10.5K Views</span>
                        </div>
                        <div class="blog-metadata-item">
                            <i class="far fa-calendar-alt"></i>
                            <span>Created: <?php 
                                $created_date = !empty($tr['created_at']) ? date('M d, Y', strtotime($tr['created_at'])) : 'N/A';
                                echo htmlspecialchars($created_date); 
                            ?></span>
                        </div>
                        <div class="blog-metadata-item">
                            <i class="fas fa-clock"></i>
                            <span>Updated: <?php 
                                $updated_date = !empty($tr['updated_at']) ? date('M d, Y', strtotime($tr['updated_at'])) : 'N/A';
                                echo htmlspecialchars($updated_date); 
                            ?></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Featured Image -->
        <div class="row mb-5">
            <div class="col-lg-10 mx-auto">
                <div class="blog-featured-image">
                    <img src="dashboard/uploads/blog/<?php echo htmlspecialchars($ufile); ?>" 
                         alt="<?php echo htmlspecialchars($blog_title); ?>" 
                         class="img-fluid">
                </div>
            </div>
        </div>
        
        <!-- Blog Content -->
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <div class="blog-content-wrapper">
                    <div class="blog-content">
                        <?php 
                        // Convert newlines to paragraphs for better formatting
                        $content = nl2br(htmlspecialchars($blog_detail));
                        // Replace double newlines with paragraph breaks
                        $content = preg_replace('/<br\s*?\/>\s*?<br\s*?\/>/', '</p><p class="mb-4">', $content);
                        // Wrap in paragraph tags
                        echo '<p class="mb-4">' . $content . '</p>';
                        ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ***** Blog Detail Area End ***** -->

<!--====== Contact Area Start ======-->
<section id="contact" class="contact-area ptb_100">
    <div class="container">
        <div class="row justify-content-between align-items-center">
            <div class="col-12 col-lg-5">
                <!-- Section Heading -->
                <div class="section-heading text-center mb-3">
                    <h2><?php echo htmlspecialchars($contact_title); ?></h2>
                    <p class="d-none d-sm-block mt-4"><?php echo htmlspecialchars($contact_text); ?></p>
                </div>
                <!-- Contact Us -->
                <div class="contact-us">
                    <ul>
                        <!-- Contact Info -->
                        <li class="contact-info color-1 bg-hover active hover-bottom text-center p-5 m-3">
                            <span><i class="fas fa-mobile-alt fa-3x"></i></span>
                            <a class="d-block my-2" href="tel:<?php echo htmlspecialchars($phone1); ?>">
                                <h4><?php echo htmlspecialchars($phone1); ?></h4>
                            </a>
                        </li>
                        <!-- Contact Info -->
                        <li class="contact-info color-3 bg-hover active hover-bottom text-center p-5 m-3">
                            <span><i class="fas fa-envelope-open-text fa-3x"></i></span>
                            <a class="d-none d-sm-block my-2" href="mailto:<?php echo htmlspecialchars($email1); ?>">
                                <h4><?php echo htmlspecialchars($email1); ?></h4>
                            </a>
                            <a class="d-block d-sm-none my-2" href="mailto:<?php echo htmlspecialchars($email1); ?>">
                                <h4><?php echo htmlspecialchars($email1); ?></h4>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-12 col-lg-6 pt-4 pt-lg-0">
                <!-- Contact Box -->
                <div class="contact-box text-center">
                    <!-- Contact Form -->
                    <?php
                    $status = "OK"; // initial status
                    $msg = "";
                    
                    if (isset($_POST['save'])) {
                        $name = mysqli_real_escape_string($con, $_POST['name']);
                        $email = mysqli_real_escape_string($con, $_POST['email']);
                        $phone = mysqli_real_escape_string($con, $_POST['phone']);
                        $message = mysqli_real_escape_string($con, $_POST['message']);

                        if (strlen($name) < 5) {
                            $msg .= "Name Must Be More Than 5 Char Length.<BR>";
                            $status = "NOTOK";
                        }
                        if (strlen($email) < 9) {
                            $msg .= "Email Must Be More Than 10 Char Length.<BR>";
                            $status = "NOTOK";
                        }
                        if (strlen($message) < 10) {
                            $msg .= "Message Must Be More Than 10 Char Length.<BR>";
                            $status = "NOTOK";
                        }
                        if (strlen($phone) < 8) {
                            $msg .= "Phone Must Be More Than 8 Char Length.<BR>";
                            $status = "NOTOK";
                        }

                        if ($status == "OK") {
                            $recipient = "timestenkenya@gmail.com";
                            $formcontent = "NAME: $name \n EMAIL: $email \n PHONE: $phone \n MESSAGE: $message";
                            $subject = "New Enquiry from Timesten Kenya Business Portfolio";
                            $mailheader = "From: noreply@timesten.com \r\n";
                            $result = mail($recipient, $subject, $formcontent, $mailheader);

                            if ($result) {
                                $errormsg = "
                                <div class='alert alert-success alert-dismissible alert-outline fade show'>
                                    Enquiry Sent Successfully. We shall get back to you ASAP.
                                    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                                </div>";
                            }
                        } elseif ($status !== "OK") {
                            $errormsg = "
                            <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                                " . $msg . " 
                                <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> 
                            </div>";
                        } else {
                            $errormsg = "
                            <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                                Some Technical Glitch Is There. Please Try Again Later Or Ask Admin For Help.
                                <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                            </div>";
                        }
                    }
                    ?>
                    
                    <?php
                    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                        echo $errormsg;
                    }
                    ?>

                    <form id="contactForm" method="post">
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="name" id="name" placeholder="Name" required="required">
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control" name="email" id="email" placeholder="Email" required="required">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="phone" id="phone" placeholder="Phone" required="required">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="ref_code" id="ref_code" placeholder="Referral Code (Optional)" value="<?php echo isset($_SESSION['referral_token']) ? htmlspecialchars($_SESSION['referral_token']) : ''; ?>">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <textarea class="form-control" name="message" id="message" placeholder="Message" required="required"></textarea>
                                </div>
                            </div>
                            <div class="col-12">
                                <button type="submit" name="save" class="btn btn-bordered active btn-block mt-3" id="submitBtn">
                                    <span class="text-white pr-3"><i class="fas fa-paper-plane"></i></span>Send Message
                                    <span class="spinner-border spinner-border-sm text-white ml-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                                </button>
                            </div>
                        </div>
                    </form>
                    
                    <!-- Success Modal -->
                    <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #3b1b6a; color: white;">
                                    <h5 class="modal-title" id="successModalLabel">Message Sent!</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body text-center py-4">
                                    <i class="fas fa-check-circle fa-4x mb-3" style="color: #3b1b6a;"></i>
                                    <h4>Thank You!</h4>
                                    <p>Your message has been sent successfully. We'll get back to you as soon as possible.</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Error Modal -->
                    <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title" id="errorModalLabel">Error</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body text-center py-4">
                                    <i class="fas fa-exclamation-triangle fa-4x mb-3 text-danger"></i>
                                    <h4>Oops!</h4>
                                    <p id="errorMessage">Something went wrong. Please try again.</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--====== Contact Area End ======-->

<!--====== Call To Action Area Start ======-->
<section class="section cta-area bg-overlay orangish-gradient ptb_100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <!-- Section Heading -->
                <div class="section-heading text-center m-0">
                    <h2 class="text-white"><?php echo htmlspecialchars($enquiry_title); ?></h2>
                    <p class="text-white mt-4"><?php echo htmlspecialchars($enquiry_text); ?></p>
                    <a href="#" class="btn btn-bordered-white mt-4" data-toggle="modal" data-target="#bookMeetingModal">Book a Meeting</a>
                    <!-- <a href="contact" class="btn btn-bordered-white mt-4">Contact Us</a> -->
                </div>
            </div>
        </div>
    </div>
</section>
<!--====== Call To Action Area End ======-->

<?php include "footer.php"; ?>

<script>
$(document).ready(function() {
    $('#contactForm').on('submit', function(e) {
        e.preventDefault();
        
        // Show loading spinner
        $('#submitBtn').prop('disabled', true);
        $('#loadingSpinner').removeClass('d-none');
        
        $.ajax({
            type: 'POST',
            url: 'send_email.php',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(response) {
                // Hide loading spinner
                $('#submitBtn').prop('disabled', false);
                $('#loadingSpinner').addClass('d-none');
                
                if (response.status === 'success') {
                    // Show success modal
                    $('#successModal').modal('show');
                    // Clear form
                    $('#contactForm')[0].reset();
                } else {
                    // Show error modal with message
                    $('#errorMessage').html(response.message);
                    $('#errorModal').modal('show');
                }
            },
            error: function() {
                // Hide loading spinner
                $('#submitBtn').prop('disabled', false);
                $('#loadingSpinner').addClass('d-none');
                
                // Show error modal
                $('#errorMessage').html('A server error occurred. Please try again later.');
                $('#errorModal').modal('show');
            }
        });
    });
});
</script>