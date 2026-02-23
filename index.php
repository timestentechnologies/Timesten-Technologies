<?php include "header.php"; ?>
        <!-- ***** Welcome Area Start ***** -->
        <section id="home" class="section welcome-area bg-overlay overflow-hidden d-flex align-items-center">
            <?php
                $slider_rs = mysqli_query($con, "SELECT * FROM slider ORDER BY id DESC");
                $slider_items = [];
                if ($slider_rs) {
                    while ($srow = mysqli_fetch_assoc($slider_rs)) {
                        $slider_items[] = $srow;
                    }
                }
            ?>

            <?php if (count($slider_items) > 0) { ?>
                <div class="welcome-slider owl-carousel" style="position:absolute;inset:0;z-index:0;">
                    <?php
                        foreach ($slider_items as $srow) {
                            $ufile = isset($srow['ufile']) ? $srow['ufile'] : '';
                            $bg = htmlspecialchars($ufile);
                            print "<div class='welcome-slide' style=\"width:100%;height:100%;min-height:520px;background-image:url('dashboard/uploads/slider/$bg');background-size:cover;background-position:center;\"></div>";
                        }
                    ?>
                </div>
                <div style="position:absolute;inset:0;z-index:1;background:rgba(0,0,0,.55);"></div>
            <?php } ?>

            <div class="container">
            <!DOCTYPE html>
<html>
<head>
    <style>
        .star {
            position: absolute;
            background-color: white;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            font-weight:bold;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
        }
       
    </style>
</head>
<body>
    <div id="stars-container"></div>
    
    <script>
        <?php
        // Number of stars
        $numStars = 50;

        // Maximum star size
        $maxSize = 5;

        echo "var stars = [";
        for ($i = 0; $i < $numStars; $i++) {
            $x = mt_rand(0, 100);
            $y = mt_rand(0, 100);
            $size = mt_rand(1, $maxSize);
            echo "{ x: $x, y: $y, size: $size }";
            if ($i < $numStars - 1) {
                echo ",";
            }
        }
        echo "];";
        ?>

        const container = document.getElementById('stars-container');
        stars.forEach(star => {
            const el = document.createElement('div');
            el.classList.add('star');
            el.style.width = `${star.size}px`;
            el.style.height = `${star.size}px`;
            el.style.left = `${star.x}%`;
            el.style.top = `${star.y}%`;
            container.appendChild(el);
        });

        animateStars();

        function animateStars() {
            const starElements = document.querySelectorAll('.star');
            starElements.forEach(star => {
                const x = Math.random() * 100;
                const y = Math.random() * 100;
                const duration = Math.random() * 5 + 1;
                const delay = Math.random() * 3;
                star.style.transition = `transform ${duration}s ease-in-out ${delay}s, opacity 0.9s`;
                star.style.transform = `translate(${x}%, ${y}%)`;
                star.style.opacity = '1';

                setTimeout(() => {
                    star.style.transition = `opacity 0.3s`;
                    star.style.opacity = '0';
                }, 1000);
            });
            setTimeout(animateStars, 2000);
        }
    </script>
</body>
</html>
         
                <div class="row align-items-center">
                    <!-- Welcome Intro Start -->
                    <div class="col-12 col-md-7">
                    <?php
    $rr=mysqli_query($con,"SELECT * FROM static");
$r = mysqli_fetch_row($rr);
$stitle = $r[1];
$stext=$r[2];
?>
                        

                        <div class="welcome-intro">
                            <h1 class="text-white"><?php print $stitle?></h1>
                            <p class="text-white my-4"><?php print $stext?></p>
                            <!-- Buttons -->
                            <div class="button-group">
                                <a href="portfolio.php" class="btn btn-bordered-white">Browse Projects</a>
                                <a href="contact.php" class="btn btn-bordered-white d-none d-sm-inline-block">Contact Us</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-5">
                        <!-- Welcome Thumb -->
                        <div class="welcome-thumb-wrapper mt-5 mt-md-0">
                            <span class="welcome-thumb-1">
                                <img class="welcome-animation d-block ml-auto" src="assets/img/welcome/thumb_1.png" alt="">
                            </span>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Shape Bottom -->
            <div class="shape shape-bottom">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>
        <!-- ***** Welcome Area End ***** -->

        <!-- ***** Promo Area Start ***** -->
        <section class="section promo-area ptb_100">
            <div class="container">
                <div class="row">


                <?php
				   $q="SELECT * FROM  why_us ORDER BY id DESC LIMIT 3";


 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$title="$ro[title]";
	$detail="$ro[detail]";

print "
<div class='col-12 col-md-6 col-lg-4 res-margin'>
<!-- Single Promo -->
<div class='single-promo color-1 bg-hover hover-bottom text-center p-5'>
    <h3 class='mb-3'>$title</h3>
    <p>$detail</p>
</div>
</div>
";
}
?>




                </div>
            </div>
        </section>
        <!-- ***** Promo Area End ***** -->

        <!-- ***** Content Area Start ***** -->

        <!-- ***** Content Area End ***** -->

        <!-- ***** Content Area Start ***** -->

        <!-- ***** Content Area End ***** -->

        <!-- ***** Service Area End ***** -->
        <section id="service" class="section service-area bg-grey ptb_150">
            <!-- Shape Top -->
            <div class="shape shape-top">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
                c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
                c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-7">
                        <!-- Section Heading -->
                        <div class="section-heading text-center">
                            <h2><?php print $service_title?></h2>
                            <p class="d-none d-sm-block mt-4"><?php print $service_text?></p>
                        </div>
                    </div>
                </div>
                <div class="row">

                <?php
				   $qs="SELECT * FROM  service ORDER BY id DESC LIMIT 6";


 $r1 = mysqli_query($con,$qs);

while($rod = mysqli_fetch_array($r1))
{
	$id="$rod[id]";
	$serviceg="$rod[service_title]";
	$service_desc="$rod[service_desc]";

print "
<div class='col-12 col-md-6 col-lg-4'>
<!-- Single Service -->
<div class='single-service p-4'  style='border: solid 1px #788282;'>
    <h3 class='my-3'>$serviceg</h3>
    <p>$service_desc</p>
    <a class='service-btn mt-3' href='servicedetail.php?id=$id'>Learn More</a>
</div>
</div>

";
}
?>
                   </div>
            </div>
            <!-- Shape Bottom -->
            <div class="shape shape-bottom">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none" fill="#FFFFFF">
                    <path class="shape-fill" d="M421.9,6.5c22.6-2.5,51.5,0.4,75.5,5.3c23.6,4.9,70.9,23.5,100.5,35.7c75.8,32.2,133.7,44.5,192.6,49.7
        c23.6,2.1,48.7,3.5,103.4-2.5c54.7-6,106.2-25.6,106.2-25.6V0H0v30.3c0,0,72,32.6,158.4,30.5c39.2-0.7,92.8-6.7,134-22.4
        c21.2-8.1,52.2-18.2,79.7-24.2C399.3,7.9,411.6,7.5,421.9,6.5z"></path>
                </svg>
            </div>
        </section>
        <!-- ***** Service Area End ***** -->

        <!-- ***** Portfolio Area Start ***** -->
        <section id="portfolio" class="portfolio-area overflow-hidden ptb_100">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-7">
                        <!-- Section Heading -->
                        <div class="section-heading text-center">
                            <h2><?php print $port_title?></h2>
                            <p class="mt-4 mb-5"><?php print $port_text?></p>
                        </div>
                    </div>
                </div>
                <!-- Portfolio Items -->
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="row g-5">

                        <?php
                           $q="SELECT * FROM  portfolio ORDER BY id DESC LIMIT 6";

                        $r123 = mysqli_query($con,$q);

                        while($ro = mysqli_fetch_array($r123))
                        {

                            $id="$ro[id]";
                            $port_title="$ro[port_title]";
                            $port_desc="$ro[port_desc]";
                            $ufile="$ro[ufile]";

                        print "
                        <div class='col-12 col-sm-6 col-lg-4 mb-4'>
                            <div class='single-case-studies h-100'>
                                <a href='portdetail.php?id=$id' class='d-block position-relative overflow-hidden rounded-3'>
                                    <img src='dashboard/uploads/portfolio/$ufile' alt='$port_title' class='w-100 h-100 object-fit-cover' style='aspect-ratio: 16/9;'>
                                </a>
                                <div class='text-center mt-2 px-2 pb-3'>
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
                <div class="row justify-content-center">
                    <div class="col-12 text-center">
                        <a href="portfolio" class="btn btn-bordered mt-5">View More</a>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Portfolio Area End ***** -->

        <!-- ***** Price Plan Area Start ***** -->

        <!-- ***** Price Plan Area End ***** -->

        <!-- ***** Review Area Start ***** -->
        <section id="review" class="section review-area bg-overlay ptb_100">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-7">
                        <!-- Section Heading -->


                        <div class="section-heading text-center">
                            <h2 class="text-white"><?php print $test_title; ?></h2>
                            <p class="text-white d-none d-sm-block mt-4"><?php print $test_text;?></p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <!-- Client Reviews -->
                    <div class="client-reviews owl-carousel">
                        <!-- Single Review -->



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

<div class='single-review p-5'>
<!-- Review Content -->
<div class='review-content'>
    <!-- Review Text -->
    <div class='review-text'>
        <p>$message</p>
    </div>
    <!-- Quotation Icon -->

</div>
<!-- Reviewer -->
<div class='reviewer media mt-3'>
    <!-- Reviewer Thumb -->
    <div class='reviewer-thumb'>
        <img class='avatar-lg radius-100' src='dashboard/uploads/testimony/$ufile' alt='img'>
    </div>
    <!-- Reviewer Media -->
    <div class='reviewer-meta media-body align-self-center ml-4'>
        <h5 class='reviewer-name color-primary mb-2'>$name</h5>
        <h6 class='text-secondary fw-6'>$position</h6>
    </div>
</div>
</div>


";
}
?>
                    </div>
                </div>
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
                                        <div class="modal-header" style="background-color: #6730e3; color: white;">
                                            <h5 class="modal-title" id="successModalLabel">Message Sent!</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body text-center py-4">
                                            <i class="fas fa-check-circle fa-4x mb-3" style="color: #6730e3;"></i>
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
            <script src="//code.tidio.co/w3nnziooaulg2mxalctxf1oief1sptkr.js" async></script>

            <script>
                $(document).ready(function () {
                    if ($('.welcome-slider').length > 0 && typeof $.fn.owlCarousel === 'function') {
                        $('.welcome-slider').owlCarousel({
                            items: 1,
                            loop: true,
                            autoplay: true,
                            autoplayTimeout: 5000,
                            autoplayHoverPause: false,
                            nav: false,
                            dots: true,
                            animateOut: 'fadeOut'
                        });
                    }
                });
            </script>
            
      <?php include "footer.php"; ?>
