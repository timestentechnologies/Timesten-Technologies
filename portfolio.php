<?php include "header.php";?>
        <section class="section breadcrumb-area overlay-dark d-flex align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <!-- Breamcrumb Content -->
                        <div class="breadcrumb-content text-center">
                            <h2 class="text-white text-uppercase mb-3">Our Past Works</h2>
                            <ol class="breadcrumb d-flex justify-content-center">
                                <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>

                                <li class="breadcrumb-item text-white active">Our Portfolio</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Breadcrumb Area End ***** -->

     <!-- ***** Portfolio Area Start ***** -->
     <section id="portfolio" class="portfolio-area overflow-hidden ptb_100">
            <div class="container">
                <!-- Portfolio Items -->
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="row g-4">

                        <?php
                           $q="SELECT * FROM portfolio ORDER BY display_order ASC, id DESC";

                        $r123 = mysqli_query($con,$q);

                        while($ro = mysqli_fetch_array($r123))
                        {

                            $id="$ro[id]";
                            $port_title="$ro[port_title]";
                            $port_desc="$ro[port_desc]";
                            $ufile="$ro[ufile]";
                            $tags="$ro[tags]";
                            $tag_colors="$ro[tag_colors]";

                            // Process tags with colors
                            $tag_html = '';
                            if (!empty($tags)) {
                                $tag_array = array_map('trim', explode(',', $tags));
                                $color_array = array_map('trim', explode(',', $tag_colors));
                                $default_classes = ['tag-orange', 'tag-purple', 'tag-blue', 'tag-green', 'tag-teal', 'tag-red'];
                                $tag_html .= "<div class='tag-container justify-content-center'>";
                                foreach ($tag_array as $i => $tag) {
                                    if (!empty($tag) && $i < 4) { // Show max 4 tags on cards
                                        // Use saved color or default
                                        $saved_color = isset($color_array[$i]) && !empty($color_array[$i]) ? $color_array[$i] : '';
                                        $class = !empty($saved_color) ? 'tag-' . $saved_color : $default_classes[$i % count($default_classes)];
                                        $tag_html .= "<span class='tag-btn $class'>" . htmlspecialchars($tag) . "</span>";
                                    }
                                }
                                $tag_html .= "</div>";
                            }

                        print "
                        <div class='col-12 col-sm-6 col-lg-4 mb-4'>
                            <!-- Single Case Studies -->
                            <div class='single-case-studies h-100'>
                                <!-- Case Studies Thumb -->
                                <a href='portdetail.php?id=$id' class='d-block position-relative overflow-hidden rounded-3'>
                                    <img src='dashboard/uploads/portfolio/$ufile' alt='$port_title' class='w-100 h-100 object-fit-cover' style='aspect-ratio: 16/9;'>
                                </a>
                                <!-- Portfolio Title Below Card -->
                                <div class='text-center mt-2 px-2 pb-3'>
                                    $tag_html
                                    <h5 class='fw-bold mb-1'>$port_title</h5>
                                    <p class='mb-0 small'>$port_desc</p>
                                </div>
                            </div>
                        </div>
                        ";
                        }
                        ?>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Portfolio Area End ***** -->

        <!-- ***** Review Area Start ***** -->
         <section id="review" class="section review-area bg-grey ptb_100 position-relative" style="padding: 65px 0; background-color: #f4f4f4 !important;">
             <div class="shape shape-top" style="z-index: 0;">
                 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#f4f4f4">
                     <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
                 c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
                 c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                 </svg>
             </div>
             <div class="container" style="position: relative; z-index: 1;">
                 <div class="row">
                     <div class="col-12">
                         <div class="section-heading text-center">
                             <h2><?php print $test_title; ?></h2>
                         </div>
                         <p class="mt-1 mb-5 text-start" style="max-width: 100%; color: #555; font-size: 16px; line-height: 1.8;"><?php print $test_text;?></p>
                     </div>
                 </div>
                 <div class="row">
                     <div class="client-reviews owl-carousel">
                         <?php
 				   $q="SELECT * FROM  testimony ORDER BY id DESC LIMIT 6";
 
 
  $r123 = mysqli_query($con,$q);
 
 while($ro = mysqli_fetch_array($r123))
 {
 
 	$name="$ro[name]";
 	$position="$ro[position]";
     $message="$ro[message]";
     $ufile="$ro[ufile]";
 
 print "
 
 <div class='single-review p-5' style='background: #fff; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); transition: all 0.3s ease; margin: 15px;'>
 <!-- Review Content -->
 <div class='review-content'>
     <!-- Quotation Icon -->
     <div style='color: #f67011; font-size: 40px; margin-bottom: 15px; line-height: 1;'>\"</div>
     <!-- Review Text -->
     <div class='review-text'>
         <p style='color: #555; line-height: 1.7; font-style: italic;'>$message</p>
     </div>
 </div>
 <!-- Reviewer -->
 <div class='reviewer media mt-4 align-items-center'>
     <!-- Reviewer Thumb -->
     <div class='reviewer-thumb flex-shrink-0'>
         <img class='avatar-lg rounded-circle' style='width: 60px; height: 60px; object-fit: cover; border: 3px solid #f67011;' src='dashboard/uploads/testimony/$ufile' alt='img'>
     </div>
     <!-- Reviewer Media -->
     <div class='reviewer-meta media-body align-self-center ml-3'>
         <h5 style='color: #3b1b6a; font-weight: 700; font-size: 16px; margin-bottom: 2px;'>$name</h5>
         <h6 style='color: #f67011; font-weight: 600; font-size: 13px; margin-bottom: 0;'>$position</h6>
     </div>
 </div>
 </div>
 
 
 ";
 }
 ?>
                     </div>
                 </div>
             </div>
             <div class="shape shape-bottom" style="z-index: 0;">
                 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                     <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7
         c75.8,32.2,133.7,44.5,192.6,49.7
         c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
         c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                 </svg>
             </div>
         </section>
         <!-- ***** Review Area End ***** -->

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
                            <p class="text-white mt-4"><?php print $enquiry_text; ?></p>
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
