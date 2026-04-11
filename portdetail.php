<?php
include "header.php";
$todo= mysqli_real_escape_string($con,$_GET["id"]);

$prev_port_id = 0;
$next_port_id = 0;
$prev_rs = mysqli_query($con, "SELECT id FROM portfolio WHERE id < '$todo' ORDER BY id DESC LIMIT 1");
if ($prev_rs) {
    $prev_row = mysqli_fetch_assoc($prev_rs);
    $prev_port_id = $prev_row ? (int)$prev_row['id'] : 0;
}
$next_rs = mysqli_query($con, "SELECT id FROM portfolio WHERE id > '$todo' ORDER BY id ASC LIMIT 1");
if ($next_rs) {
    $next_row = mysqli_fetch_assoc($next_rs);
    $next_port_id = $next_row ? (int)$next_row['id'] : 0;
}

$has_portfolio_media_table = false;
$tm_rs = mysqli_query($con, "SHOW TABLES LIKE 'portfolio_media'");
if ($tm_rs && mysqli_num_rows($tm_rs) > 0) {
    $has_portfolio_media_table = true;
}

$portfolio_media_items = [];
if ($has_portfolio_media_table) {
    $m_rs = mysqli_query($con, "SELECT id, file_path, media_type FROM portfolio_media WHERE portfolio_id='$todo' ORDER BY id ASC");
    if ($m_rs) {
        while ($mrow = mysqli_fetch_assoc($m_rs)) {
            $portfolio_media_items[] = $mrow;
        }
    }
}
?>
        <!-- ***** Breadcrumb Area Start ***** -->
        <section class="section breadcrumb-area overlay-dark d-flex align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <!-- Breamcrumb Content -->
                        <div class="breadcrumb-content d-flex flex-column align-items-center text-center">
                            <h2 class="text-white text-uppercase mb-3">Portfolio Details</h2>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>

                                <li class="breadcrumb-item text-white active">Portfolio</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Breadcrumb Area End ***** -->


        <?php
    $rt=mysqli_query($con,"SELECT * FROM portfolio where id='$todo'");
    	$tr = mysqli_fetch_array($rt);
	$port_title = "$tr[port_title]";
	$port_detail = "$tr[port_detail]";
	$port_url = "$tr[port_url]";
	$ufile = "$tr[ufile]";

	$port_detail_display = $port_detail;
	$port_detail_display = stripcslashes($port_detail_display);
	$port_detail_display = stripcslashes($port_detail_display);
	$port_detail_display = str_replace("\\", "", $port_detail_display);
	$port_detail_display = str_replace(["\r\n", "\r"], "\n", $port_detail_display);
	$port_detail_display = nl2br($port_detail_display);
?>


        <!-- ***** About Area Start ***** -->
        <section class="section about-area ptb_100">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-12 col-lg-6">
                        <!-- About Thumb -->
                        <div class="about-thumb text-center">
                            <img src="dashboard/uploads/portfolio/<?php print $ufile;?>" alt="img">
                        </div>
                    </div>
                    <div class="col-12 col-lg-6">
                        <!-- About Content -->
                        <div class="about-content section-heading text-center text-lg-left pl-md-4 mt-5 mt-lg-0 mb-0">
                            <h2 class="mb-3"><?php print $port_title?></h2>
                            <p><?php print $port_detail_display;?></p>
                            <?php if(!empty($port_url)) { ?>
                                <a class="btn btn-bordered mt-4" href="<?php print $port_url; ?>" target="_blank" rel="noopener noreferrer">Visit Website</a>
                            <?php } ?>
                            <?php if ($prev_port_id > 0 || $next_port_id > 0) { ?>
                                <div class="d-flex justify-content-between align-items-center gap-2 mt-4">
                                    <div>
                                        <?php if ($prev_port_id > 0) { ?>
                                            <a class="btn btn-bordered" href="portdetail.php?id=<?php print (int)$prev_port_id; ?>">Previous</a>
                                        <?php } ?>
                                    </div>
                                    <div>
                                        <?php if ($next_port_id > 0) { ?>
                                            <a class="btn btn-bordered active" href="portdetail.php?id=<?php print (int)$next_port_id; ?>">Next</a>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <!-- Counter Area -->

                        </div>
                    </div>
                </div>

                <?php if (!empty($portfolio_media_items)) { ?>
                    <div class="row mt-5">
                        <div class="col-12">
                            <div class="single-service p-4" style="border: solid 1px #788282;">
                                <h3 class="mb-3">More Media</h3>
                                <div class="row">
                                    <?php foreach ($portfolio_media_items as $mitem) {
                                        $mtype = isset($mitem['media_type']) ? $mitem['media_type'] : '';
                                        $mpath = isset($mitem['file_path']) ? $mitem['file_path'] : '';
                                        $mpath_safe = htmlspecialchars($mpath);
                                        $full_url = "dashboard/uploads/portfolio/" . $mpath_safe;

                                        if ($mtype === 'image') {
                                            print "<div class='col-12 col-md-6 col-lg-4 mb-3'><a href='$full_url' target='_blank'><img src='$full_url' alt='media' style='width:100%;height:200px;object-fit:cover;border-radius:12px;display:block;'></a></div>";
                                        } elseif ($mtype === 'video') {
                                            print "<div class='col-12 col-lg-6 mb-3'><video controls style='width:100%;border-radius:12px;'><source src='$full_url'></video></div>";
                                        } else {
                                            print "<div class='col-12 col-md-6 col-lg-4 mb-3'><a class='btn btn-bordered w-100' href='$full_url' target='_blank' rel='noopener noreferrer'>Open Document</a></div>";
                                        }
                                    } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </section>
        <!-- ***** About Area End ***** -->


        <!-- ***** Our Goal Area End ***** -->

        <!-- ***** Team Area Start ***** -->

        <!-- ***** Team Area End ***** -->

        <!--====== Contact Area Start ======-->
        <section id="contact" class="contact-area ptb_100">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-12 col-lg-5">
                        <!-- Section Heading -->
                        <div class="section-heading text-center mb-3">
                            <h2><?php print $contact_title ?></h2>
                            <p class="d-none d-sm-block mt-4"><?php print $contact_text ?></p>
                        </div>
                        <!-- Contact Us -->
                        <div class="contact-us">
                            <ul>
                                <!-- Contact Info -->
                                <li class="contact-info color-1 bg-hover active hover-bottom text-center p-5 m-3">
                                    <span><i class="fas fa-mobile-alt fa-3x"></i></span>
                                    <a class="d-block my-2" href="tel:<?php print $phone1 ?>">
                                        <h4><?php print $phone1 ?></h4>
                                    </a>

                                </li>
                                <!-- Contact Info -->
                                <li class="contact-info color-3 bg-hover active hover-bottom text-center p-5 m-3">
                                    <span><i class="fas fa-envelope-open-text fa-3x"></i></span>
                                    <a class="d-none d-sm-block my-2" href="mailto:<?php print $email1 ?>">
                                        <h4><?php print $email1 ?></h4>
                                    </a>
                                    <a class="d-block d-sm-none my-2" href="mailto:<?php print $email1 ?>">
                                        <h4><?php print $email1 ?></h4>
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
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$name = mysqli_real_escape_string($con,$_POST['name']);
$email = mysqli_real_escape_string($con,$_POST['email']);
$phone = mysqli_real_escape_string($con,$_POST['phone']);
$message = mysqli_real_escape_string($con,$_POST['message']);

 if ( strlen($name) < 5 ){
$msg=$msg."Name Must Be More Than 5 Char Length.<BR>";
$status= "NOTOK";}
 if ( strlen($email) < 9 ){
$msg=$msg."Email Must Be More Than 10 Char Length.<BR>";
$status= "NOTOK";}
if ( strlen($message) < 10 ){
    $msg=$msg."Message Must Be More Than 10 Char Length.<BR>";
    $status= "NOTOK";}

if ( strlen($phone) < 8 ){
  $msg=$msg."Phone Must Be More Than 8 Char Length.<BR>";
  $status= "NOTOK";}

  if($status=="OK")
  {

$recipient="timestenkenya@gmail.com";

$formcontent="NAME:$name \n EMAIL: $email  \n PHONE: $phone  \n MESSAGE: $message";

$subject = "New Enquiry from Timesten Kenya Business Portfolio";
$mailheader = "From: noreply@timesten.com \r\n";
$result= mail($recipient, $subject, $formcontent);

          if($result){
                  $errormsg= "
  <div class='alert alert-success alert-dismissible alert-outline fade show'>
                   Enquiry Sent Successfully. We shall get back to you ASAP.
                    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                    </div>
   "; //printing error if found in validation

          }
      }

          elseif ($status!=="OK") {
              $errormsg= "
  <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                       ".$msg." <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> </div>"; //printing error if found in validation


      }
      else{
              $errormsg= "
        <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                   Some Technical Glitch Is There. Please Try Again Later Or Ask Admin For Help.
                   <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                   </div>"; //printing error if found in validation


          }
             }
             ?>
<?php
if($_SERVER['REQUEST_METHOD'] == 'POST')
						{
						print $errormsg;
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
                                        <button type="submit" class="btn btn-bordered active btn-block mt-3" id="submitBtn">
                                            <span class="text-white pr-3"><i class="fas fa-paper-plane"></i></span>Send Message
                                            <span class="spinner-border spinner-border-sm text-white ml-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <p class="form-message"></p>
                            
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
                            <h2 class="text-white"><?php print $enquiry_title; ?></h2>
                            <p class="text-white d-none d-sm-block mt-4"><?php print $enquiry_text; ?></p>
                            <a href="contact" class="btn btn-bordered-white mt-4">Contact Us</a>
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
            error: function(xhr, status, error) {
                // Hide loading spinner
                $('#submitBtn').prop('disabled', false);
                $('#loadingSpinner').addClass('d-none');
                
                // Show error modal
                $('#errorMessage').html('A server error occurred. Please try again later.');
                $('#errorModal').modal('show');
                console.error('AJAX error:', status, error);
            }
        });
    });
});
</script>
