<?php include "header.php";?>
        <section class="section breadcrumb-area overlay-dark d-flex align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <!-- Breadcrumb Content -->
                        <div class="breadcrumb-content text-center">
                            <h2 class="text-white text-uppercase mb-3">Our Ideas</h2>
                            <ol class="breadcrumb d-flex justify-content-center">
                                <li class="breadcrumb-item"><a class="text-uppercase text-white" href="index.php">Home</a></li>
                                <li class="breadcrumb-item text-white active">Our Blog</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ***** Breadcrumb Area End ***** -->

        <!-- ***** Blog Area Start ***** -->
        <section id="blog" class="blog-area overflow-hidden ptb_100">
            <div class="container">
                <!-- Header with view toggle -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h3 class='text-black mb-3'>Insights and Updates</h3>
                    </div>
                    <div class="col-md-6 text-right">
                        <div class="view-toggle">
                            <button class="btn btn-outline-primary btn-sm view-btn active" data-view="grid">
                                <i class="fas fa-th"></i> Grid
                            </button>
                            <button class="btn btn-outline-primary btn-sm view-btn" data-view="list">
                                <i class="fas fa-list"></i> List
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Blog Items -->
                <div class="row blog-container" id="blogContainer">
                    <?php
                    $q="SELECT * FROM blog ORDER BY id DESC";
                    $r123 = mysqli_query($con,$q);

                    while($ro = mysqli_fetch_array($r123))
                    {
                        $id="$ro[id]";
                        $blog_title="$ro[blog_title]";
                        $blog_desc="$ro[blog_desc]";
                        $blog_detail="$ro[blog_detail]";
                        $ufile="$ro[ufile]";
                        
                        // Truncate description for preview
                        $short_desc = strlen($blog_desc) > 150 ? substr($blog_desc, 0, 150) . '...' : $blog_desc;

                        print "
                        <div class='col-12 col-sm-6 col-lg-4 blog-item mb-4' data-view='grid'>
                            <!-- Grid View -->
                            <div class='blog-card grid-view'>
                                <div class='blog-image'>
                                    <a href='blogdetail.php?id=$id'>
                                        <img src='dashboard/uploads/blog/$ufile' alt='$blog_title' class='img-fluid'>
                                    </a>
                                </div>
                                <div class='blog-content p-4'>
                                    <h5 class='blog-title mb-3'>
                                        <a href='blogdetail.php?id=$id' class='text-dark'>$blog_title</a>
                                    </h5>
                                    <p class='blog-description text-muted mb-3'>$short_desc</p>
                                    <a href='blogdetail.php?id=$id' class='btn btn-primary btn-sm'>Read More</a>
                                </div>
                            </div>
                            
                            <!-- List View -->
                            <div class='blog-card list-view d-none'>
                                <div class='row no-gutters'>
                                    <div class='col-md-4'>
                                        <div class='blog-image'>
                                            <a href='blogdetail.php?id=$id'>
                                                <img src='dashboard/uploads/blog/$ufile' alt='$blog_title' class='img-fluid h-100'>
                                            </a>
                                        </div>
                                    </div>
                                    <div class='col-md-8'>
                                        <div class='blog-content p-4'>
                                            <h5 class='blog-title mb-3'>
                                                <a href='blogdetail.php?id=$id' class='text-dark'>$blog_title</a>
                                            </h5>
                                            <p class='blog-description text-muted mb-3'>$blog_desc</p>
                                            <div class='text-left'>
                                                <a href='blogdetail.php?id=$id' class='btn btn-primary btn-sm'>Read More</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        ";
                    }
                    ?>
                </div>
            </div>
        </section>
        <!-- ***** Blog Area End ***** -->

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
                        $q="SELECT * FROM testimony ORDER BY id DESC LIMIT 6";
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
                                        ".$msg." <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> 
                                    </div>"; //printing error if found in validation
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

        <style>
        /* Blog Card Styles */
        .blog-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            overflow: hidden;
            height: 100%;
        }

        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .blog-image {
            overflow: hidden;
            position: relative;
        }

        .blog-image img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .blog-card:hover .blog-image img {
            transform: scale(1.05);
        }

        .blog-title a {
            text-decoration: none;
            font-weight: 600;
            line-height: 1.4;
        }

        .blog-title a:hover {
            color: #3b1b6a !important;
        }

        .blog-description {
            font-size: 14px;
            line-height: 1.6;
        }

        /* View Toggle Styles */
        .view-toggle {
            margin-bottom: 20px;
        }

        .view-btn {
            border: none;
            color: #fbb904;
            margin-left: 5px;
            background-color: rgba(255, 255, 255, 0.9);
            font-weight: bold;
        }

        .view-btn.active {
            background-color: #3b1b6a;
            color: white;
        }

        .view-btn:hover {
            background-color: #3b1b6a;
            color: white;
        }

        /* List View Styles */
        .list-view {
            margin-bottom: 30px;
        }

        .list-view .blog-image img {
            height: 150px;
            object-fit: cover;
        }

        .list-view .blog-content {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .list-view .row {
                flex-direction: column;
            }
            
            .list-view .blog-image img {
                height: 200px;
            }
            
            .view-toggle {
                text-align: center;
                margin-top: 20px;
            }
        }

        /* Animation for view switching */
        .blog-item {
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        </style>

        <script>
        $(document).ready(function() {
            // View toggle functionality
            $('.view-btn').on('click', function() {
                var view = $(this).data('view');
                
                // Update active button
                $('.view-btn').removeClass('active');
                $(this).addClass('active');
                
                // Switch views
                if (view === 'grid') {
                    $('.blog-item').removeClass('col-12').addClass('col-sm-6 col-lg-4');
                    $('.grid-view').removeClass('d-none');
                    $('.list-view').addClass('d-none');
                } else {
                    $('.blog-item').removeClass('col-sm-6 col-lg-4').addClass('col-12');
                    $('.grid-view').addClass('d-none');
                    $('.list-view').removeClass('d-none');
                }
            });

            // Contact form functionality
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