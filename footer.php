<?php include "z_db.php";
    // Fetch partners for display on all pages except index.php
    $partners = array();
    $has_partners_table = false;
    $tp = mysqli_query($con, "SHOW TABLES LIKE 'partners'");
    if ($tp && mysqli_num_rows($tp) > 0) {
        $has_partners_table = true;
    }
    if ($has_partners_table) {
        $rp = mysqli_query($con, "SELECT * FROM partners WHERE is_active = 1 ORDER BY sort_order ASC, id DESC");
        if ($rp) {
            while ($prow = mysqli_fetch_assoc($rp)) {
                $partners[] = $prow;
            }
        }
    }
    $current_page = isset($_SERVER['PHP_SELF']) ? basename($_SERVER['PHP_SELF']) : '';
?>

<?php if (!empty($partners) && $current_page !== 'index.php') { ?>
<!--====== Partners Area Start ======-->
<section class="section ptb_80" id="partners" style="background: #f8f9fa;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="section-heading text-center">
                    <h2>our partners</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="partners-carousel owl-carousel">
                    <?php foreach ($partners as $p) {
                        $pname = isset($p['name']) ? htmlspecialchars($p['name']) : '';
                        $plogo = isset($p['logo']) ? htmlspecialchars($p['logo']) : '';
                        $plink = isset($p['website_url']) ? htmlspecialchars($p['website_url']) : '';
                        if (!strlen($plogo)) continue;
                    ?>
                        <div class="partner-item text-center px-3 py-3">
                            <?php if (strlen($plink)) { ?>
                                <a href="<?php echo $plink; ?>" target="_blank" rel="noopener">
                                    <img src="dashboard/uploads/partners/<?php echo $plogo; ?>" alt="<?php echo $pname; ?>" style="max-height:60px; max-width: 160px; width: auto;">
                                </a>
                            <?php } else { ?>
                                <img src="dashboard/uploads/partners/<?php echo $plogo; ?>" alt="<?php echo $pname; ?>" style="max-height:60px; max-width: 160px; width: auto;">
                            <?php } ?>
                        </div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
</section>
<!--====== Partners Area End ======-->
<?php } ?>

  <!--====== Footer Area Start ======-->
  <footer class="section footer-area">
            <!-- Footer Top -->
            <div class="footer-top ptb_100">
                <div class="container-fluid" style="padding-left: 40px; padding-right: 40px;">
                    <div class="row" style="margin-left: -10px; margin-right: -10px;">
                        <div class="col-12 col-sm-6 col-lg-3" style="padding-left: 15px; padding-right: 15px;">
                            <!-- Footer Items -->
                            <div class="footer-items">
                                <!-- Footer Title -->
                            <h3 class="footer-title text-uppercase mb-2">About Us</h3>
                                <p class="mb-2"><?php print $site_about?></p>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-3" style="padding-left: 15px; padding-right: 15px;">
                            <!-- Footer Items -->
                            <div class="footer-items">
                                <!-- Footer Title -->
                                <h3 class="footer-title text-uppercase mb-2">Services</h3>
                                <ul>

 <?php
   $q="SELECT * FROM  service ORDER BY id DESC LIMIT 5";
 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$id="$ro[id]";
	$service_title="$ro[service_title]";

print "
<li class='py-2'><a class='text-black-50' href='servicedetail.php?id=$id'>$service_title</a></li>
";
}
?>

                                </ul>
                            </div>
                        </div>

                        <div class="col-12 col-sm-6 col-lg-3" style="padding-left: 15px; padding-right: 15px;">
                            <!-- Footer Items -->
                            <div class="footer-items">
                                <!-- Footer Title -->
                                <h3 class="footer-title text-uppercase mb-2">Follow Us</h3>
                                <p class="mb-2"><?php print $follow_text ?></p>
                                <!-- Social Icons -->
                                <ul class="social-icons list-inline pt-2">

                                <?php
   $q="SELECT * FROM  social ORDER BY id DESC LIMIT 5";
 $r123 = mysqli_query($con,$q);

while($ro = mysqli_fetch_array($r123))
{

	$id="$ro[id]";
    $fa="$ro[fa]";
    $social_link="$ro[social_link]";

print "
<li class='list-inline-item px-1'><a href='$social_link'><i class='fab $fa'></i></a></li>
";
}
?>

                                </ul>

                            </div>
                        </div>

                        <div class="col-12 col-sm-6 col-lg-3" style="padding-left: 15px; padding-right: 15px;">
                            <!-- Footer Items -->
                            <div class="footer-items">
                                <!-- Footer Title -->
                                <h3 class="footer-title text-uppercase mb-2">Quick Links</h3>
                                <ul>
                                    <li class='py-2'><a class='text-black-50' href='careers'>Careers</a></li>
                                    <li class='py-2'><a class='text-black-50' href='services'>Services</a></li>
                                    <li class='py-2'><a class='text-black-50' href='portfolio'>Portfolio</a></li>
                                    <li class='py-2'><a class='text-black-50' href='blog'>Blog</a></li>
                                    <li class='py-2'><a class='text-black-50' href='privacy'>Privacy Policy</a></li>
                                    <li class='py-2'><a class='text-black-50' href='cookie'>Cookie Policy</a></li>
                                    <li class='py-2'><a class='text-black-50' href='terms'>Terms</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer Bottom -->
            <div class="footer-bottom bg-grey">
                <div class="container-fluid" style="padding-left: 40px; padding-right: 40px;">
                    <div class="row">
                        <div class="col-12">
                            <!-- Copyright Area -->
                            <div class="copyright-area d-flex flex-wrap justify-content-center text-center py-4">
                                <!-- Copyright Left -->

                                <div class="copyright-left" style="font-weight:bold; font-size: 12px;">&copy; <script>document.write(new Date().getFullYear())</script> <?php print $site_footer ?></div>
                                <!-- Copyright Right -->
                                <!--<div class="copyright-right" style="font-weight:bold;">Made with <a href="./dashboard/index.php" target="_blank"><i class="fas fa-heart"></i></a> By <a href="https://facebook.com/">Mwangi Alex Chomba</a></div>-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!--====== Footer Area End ======-->

        <!--====== Modal Search Area Start ======-->

        <!--====== Modal Search Area End ======-->

        <!--====== Modal Responsive Menu Area Start ======-->
        <div id="menu" class="modal fade p-0" role="dialog" aria-labelledby="menuModalLabel" aria-hidden="true">
            <div class="modal-dialog dialog-animated">
                <div class="modal-content h-100">
                    <div class="modal-header">
                        <?php
                            $menu_logo = '';
                            $has_sticky_col_m = false;
                            $col_rs_m = mysqli_query($con, "SHOW COLUMNS FROM logo LIKE 'sticky_ufile'");
                            if ($col_rs_m && mysqli_num_rows($col_rs_m) > 0) {
                                $has_sticky_col_m = true;
                            }

                            if ($has_sticky_col_m) {
                                $logo_rs_m = mysqli_query($con, "SELECT ufile, sticky_ufile FROM logo WHERE id=1 LIMIT 1");
                                $logo_row_m = $logo_rs_m ? mysqli_fetch_assoc($logo_rs_m) : null;
                                $ufile_m = $logo_row_m && !empty($logo_row_m['ufile']) ? $logo_row_m['ufile'] : '';
                                $sticky_ufile_m = $logo_row_m && !empty($logo_row_m['sticky_ufile']) ? $logo_row_m['sticky_ufile'] : '';
                                $menu_logo = strlen(trim($sticky_ufile_m)) > 0 ? $sticky_ufile_m : $ufile_m;
                            } else {
                                $logo_rs_m = mysqli_query($con, "SELECT ufile FROM logo WHERE id=1 LIMIT 1");
                                $logo_row_m = $logo_rs_m ? mysqli_fetch_assoc($logo_rs_m) : null;
                                $menu_logo = $logo_row_m && !empty($logo_row_m['ufile']) ? $logo_row_m['ufile'] : '';
                            }
                        ?>
                        <h5 class="modal-title" id="menuModalLabel">
                            <?php if (strlen(trim($menu_logo)) > 0) { ?>
                                <img src="dashboard/uploads/logo/<?php echo htmlspecialchars($menu_logo); ?>" alt="" style="height:34px;width:auto;display:block;">
                            <?php } ?>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="far fa-times-circle icon-close"></i>
                        </button>
                    </div>
                    <div class="menu modal-body">
                        <div class="row w-100">
                            <div class="items p-0 col-12 text-center">
                                <!-- Mobile Menu Items Will Be Populated Here by JavaScript -->
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link" href="home">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="about" class="nav-link">About Us</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="services" class="nav-link">Services</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="portfolio" class="nav-link">Portfolio</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="pricing" class="nav-link">Pricing</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="blog" class="nav-link">Blog</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="careers" class="nav-link">Careers</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="refer" class="nav-link" style="color: #f67011; font-weight: bold;">Refer & Earn</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="contact" class="nav-link">Contact Us</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--====== Modal Responsive Menu Area End ======-->

    </div>


    <!-- ***** All jQuery Plugins ***** -->

    <!-- jQuery(necessary for all JavaScript plugins) -->
    <script src="assets/js/jquery/jquery-3.5.1.min.js"></script>

    <!-- Bootstrap js -->
    <script src="assets/js/bootstrap/popper.min.js"></script>
    <script src="assets/js/bootstrap/bootstrap.min.js"></script>

    <!-- Plugins js -->
    <script src="assets/js/plugins/plugins.min.js"></script>

    <!-- Active js -->
    <script src="assets/js/active.js"></script>
    <script src="//code.tidio.co/w3nnziooaulg2mxalctxf1oief1sptkr.js" async></script>
    
    <!-- Contact Form Handling Script -->
    <script>
    $(document).ready(function() {
        // Only initialize if we're on the contact page
        if ($('#contactForm').length > 0) {
            $('#contactForm').on('submit', function(e) {
                e.preventDefault();
                
                // Show loading spinner
                $('#submitBtn').prop('disabled', true);
                $('#loadingSpinner').removeClass('d-none');
                
                // Get form data
                var formData = {
                    name: $('#name').val(),
                    email: $('#email').val(),
                    phone: $('#phone').val(),
                    message: $('#message').val()
                };
                
                // Send AJAX request
                $.ajax({
                    type: 'POST',
                    url: 'send_email.php',
                    data: formData,
                    dataType: 'json',
                    encode: true
                })
                .done(function(data) {
                    // Hide loading spinner
                    $('#submitBtn').prop('disabled', false);
                    $('#loadingSpinner').addClass('d-none');
                    
                    if (data.status === 'success') {
                        // Show success modal
                        $('#successModal').modal('show');
                    } else {
                        // Show error modal with message
                        $('#errorMessage').html(data.message || 'An error occurred while sending your message.');
                        $('#errorModal').modal('show');
                        console.error('Form submission error:', data.message);
                    }
                })
                .fail(function(jqXHR, textStatus, errorThrown) {
                    // Hide loading spinner
                    $('#submitBtn').prop('disabled', false);
                    $('#loadingSpinner').addClass('d-none');
                    
                    // Try to parse the response if it's JSON
                    let errorMsg = 'An error occurred while sending your message. Please try again later.';
                    try {
                        if (jqXHR.responseJSON && jqXHR.responseJSON.message) {
                            errorMsg = jqXHR.responseJSON.message;
                        } else if (jqXHR.responseText) {
                            const response = JSON.parse(jqXHR.responseText);
                            if (response.message) {
                                errorMsg = response.message;
                            }
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e);
                    }
                    
                    // Show error modal
                    $('#errorMessage').html(errorMsg);
                    $('#errorModal').modal('show');
                    console.error('AJAX error:', textStatus, errorThrown);
                });
            });
            
            // Close modals and reset form when modal is closed
            $('#successModal, #errorModal').on('hidden.bs.modal', function() {
                if ($(this).attr('id') === 'successModal') {
                    $('#contactForm')[0].reset();
                }
            });
        }
    });
    </script>
    
    <!-- Custom CSS for Mobile Menu -->
    <style>
        /* Modal styling */
        #menu.modal {
            background-color: rgba(0, 0, 0, 0.8);
        }
        
        #menu .modal-dialog {
            margin: 0;
            max-width: 100%;
            height: 100%;
        }
        
        #menu .modal-content {
            background-color: #fff;
            border-radius: 0;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        
        #menu .modal-header {
            border-bottom: 2px solid #f1f1f1;
            padding: 18px 20px;
            background-color: #ffffff;
            color: #3b1b6a;
        }
        
        #menu .modal-title {
            font-weight: 700;
            color: #3b1b6a;
            font-size: 22px;
        }
        
        #menu .close {
            color: #3b1b6a;
            opacity: 1;
            text-shadow: none;
        }
        
        #menu .icon-close {
            font-size: 20px;
        }
        
        /* Navigation styling */
        #menu .modal-body {
            padding: 30px 20px;
        }
        
        #menu .modal-body .navbar-nav {
            display: block !important;
            margin: 0 auto;
            text-align: center;
            width: 100%;
        }
        
        #menu .modal-body .nav-item {
            margin: 0;
            border-bottom: 1px solid #f1f1f1;
            transition: all 0.3s ease;
        }
        
        #menu .modal-body .nav-item:last-child {
            border-bottom: none;
        }
        
        #menu .modal-body .nav-link {
            font-size: 18px;
            color: #333;
            font-weight: 600;
            display: block;
            padding: 15px 20px;
            transition: all 0.3s ease;
            position: relative;
        }
        
        #menu .modal-body .nav-link:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 3px;
            background: #3b1b6a;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        
        #menu .modal-body .nav-link:hover {
            color: #3b1b6a;
            background-color: rgba(59, 27, 106, 0.05);
        }
        
        #menu .modal-body .nav-link:hover:after {
            width: 40px;
        }
        
        /* Active link styling */
        #menu .modal-body .nav-item.active .nav-link {
            color: #3b1b6a;
            background-color: rgba(59, 27, 106, 0.1);
        }
        
        #menu .modal-body .nav-item.active .nav-link:after {
            width: 40px;
        }
    </style>
    
    <!-- Script to highlight active menu item -->
    <script>
    $(document).ready(function() {
        // Get current page URL
        var url = window.location.href;
        
        // Loop through menu items
        $('#menu .navbar-nav .nav-item .nav-link').each(function() {
            // If the menu item URL matches the current page URL
            if (url.indexOf($(this).attr('href')) > -1) {
                $(this).parent().addClass('active');
            }
        });

        // WhatsApp button click handler
        $('#whatsappBtn').on('click', function() {
            $('#chatModal').toggle();
            if ($('#chatBody').children().length === 0) {
                addMessage("👋 Hello! I'm your AI assistant at TimesTen Technologies. How can I help you today?", 'received');
            }
        });

        // Close chat handler
        $('#closeChat').on('click', function() {
            $('#chatModal').hide();
        });

        // Send message handler
        $('#sendMessage').on('click', function() {
            const message = $('#messageInput').val().trim();
            if (message) {
                addMessage(message, 'sent');
                $('#messageInput').val('');
                generateResponse(message);
            }
        });

        // Enter key handler
        $('#messageInput').on('keypress', function(e) {
            if (e.key === 'Enter') {
                $('#sendMessage').click();
            }
        });

        // Add message function
        function addMessage(text, type) {
            const message = $('<div>').addClass(`chat-message ${type}`).text(text);
            $('#chatBody').append(message);
            $('#chatBody').scrollTop($('#chatBody')[0].scrollHeight);
        }
    });
    </script>

    <?php include 'smart-chat.php'; ?>

    <?php
        $current_page = isset($_SERVER['PHP_SELF']) ? basename($_SERVER['PHP_SELF']) : '';
        if ($current_page !== 'index.php') {
    ?>

        <!-- Book Meeting Modal -->
        <div class="modal fade" id="bookMeetingModal" tabindex="-1" role="dialog" aria-labelledby="bookMeetingModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 520px;">
                <div class="modal-content" style="border: none; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">
                    <div class="modal-header py-3" style="background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%); color: white; border: none;">
                        <h5 class="modal-title w-100 text-center font-weight-bold" id="bookMeetingModalLabel" style="font-size: 1.05rem; color: #fff; font-weight: 800;">Book a Meeting</h5>
                        <button type="button" class="close position-absolute" style="right: 14px; top: 10px; color: white; opacity: 0.9; font-size: 1.4rem;" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="background: #fff; padding: 22px 22px 10px 22px;">
                        <form id="meetingForm" method="post">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="name" placeholder="Full Name" required>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="company" placeholder="Company (Optional)">
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-group">
                                        <input type="email" class="form-control" name="email" placeholder="Email" required>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="phone" placeholder="Phone" required>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <select class="form-control" name="meeting_type" required>
                                            <option value="" selected disabled>Meeting Type</option>
                                            <option value="Online">Online</option>
                                            <option value="Physical">Physical</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-group">
                                        <input type="date" class="form-control" name="meeting_date" id="meeting_date" required placeholder="Select Date">
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="form-group">
                                        <input type="time" class="form-control" name="meeting_time" id="meeting_time" required min="08:00" max="17:00" placeholder="Select Time">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <textarea class="form-control" name="message" placeholder="Briefly tell us what you'd like to discuss" required rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-bordered active btn-block mt-2" id="meetingSubmitBtn">
                                        <span class="text-white pr-3"><i class="fas fa-calendar-check"></i></span>Submit Request
                                        <span class="spinner-border spinner-border-sm text-white ml-2 d-none" id="meetingLoadingSpinner" role="status" aria-hidden="true"></span>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer justify-content-center py-3" style="border-top: none; background: #f8f9fa;">
                        <small class="text-muted">We will confirm your meeting by email/phone.</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Meeting Success Modal -->
        <div class="modal fade" id="meetingSuccessModal" tabindex="-1" role="dialog" aria-labelledby="meetingSuccessModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 320px;">
                <div class="modal-content" style="border: none; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">
                    <div class="modal-header py-2" style="background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%); color: white; border: none;">
                        <h6 class="modal-title w-100 text-center font-weight-bold" id="meetingSuccessModalLabel" style="font-size: 0.95rem;">Request Sent!</h6>
                        <button type="button" class="close position-absolute" style="right: 12px; top: 8px; color: white; opacity: 0.9; font-size: 1.2rem;" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center py-4 px-4">
                        <div style="width: 70px; height: 70px; background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 4px 15px rgba(255, 108, 53, 0.4);">
                            <i class="fas fa-check" style="color: white; font-size: 32px;"></i>
                        </div>
                        <h5 class="mb-2" style="color: #3b1b6a; font-weight: 700; font-size: 1.3rem;">Thank You!</h5>
                        <p class="mb-0" style="font-size: 0.85rem; line-height: 1.5; color: #666;">Your meeting request has been sent. We will confirm shortly.</p>
                    </div>
                    <div class="modal-footer justify-content-center py-3" style="border-top: none; background: #f8f9fa;">
                        <button type="button" class="btn px-4" style="background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%); color: white; border: none; border-radius: 25px; font-weight: 600; font-size: 0.9rem; box-shadow: 0 4px 15px rgba(255, 108, 53, 0.3);" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Meeting Error Modal -->
        <div class="modal fade" id="meetingErrorModal" tabindex="-1" role="dialog" aria-labelledby="meetingErrorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="meetingErrorModalLabel">Error</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center py-4">
                        <i class="fas fa-exclamation-triangle fa-4x mb-3 text-danger"></i>
                        <h4>Oops!</h4>
                        <p id="meetingErrorMessage">Something went wrong. Please try again.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
        (function initMeetingScriptsWhenJQueryReady() {
            if (typeof window.jQuery === 'undefined') {
                return setTimeout(initMeetingScriptsWhenJQueryReady, 50);
            }
            var $ = window.jQuery;

            $(document).ready(function() {
                function pad2(n) {
                    return (n < 10 ? '0' : '') + n;
                }

                function formatDateValue(d) {
                    return d.getFullYear() + '-' + pad2(d.getMonth() + 1) + '-' + pad2(d.getDate());
                }

                function formatDateLabel(d) {
                    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
                    return d.getDate() + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
                }

                // Set min date to tomorrow for date picker
                var $date = $('#meeting_date');
                if ($date.length) {
                    var tomorrow = new Date();
                    tomorrow.setDate(tomorrow.getDate() + 1);
                    $date.attr('min', formatDateValue(tomorrow));
                }

                $('#meetingForm').on('submit', function(e) {
                    e.preventDefault();

                    $('#meetingSubmitBtn').prop('disabled', true);
                    $('#meetingLoadingSpinner').removeClass('d-none');

                    $.ajax({
                        type: 'POST',
                        url: 'book_meeting.php',
                        data: $(this).serialize(),
                        dataType: 'json',
                        success: function(response) {
                            $('#meetingSubmitBtn').prop('disabled', false);
                            $('#meetingLoadingSpinner').addClass('d-none');

                            if (response.status === 'success') {
                                $('#meetingForm')[0].reset();
                                setTimeout(function() {
                                    $('#bookMeetingModal').modal('hide');
                                    $('#meetingSuccessModal').modal('show');
                                }, 200);
                            } else {
                                $('#meetingErrorMessage').html(response.message);
                                $('#meetingErrorModal').modal('show');
                            }
                        },
                        error: function(xhr, status, error) {
                            $('#meetingSubmitBtn').prop('disabled', false);
                            $('#meetingLoadingSpinner').addClass('d-none');
                            var errorMsg = 'A server error occurred. Please try again later.';
                            if (xhr.responseText) {
                                errorMsg += '<br><small>Debug: ' + xhr.responseText.substring(0, 200) + '</small>';
                            }
                            $('#meetingErrorMessage').html(errorMsg);
                            $('#meetingErrorModal').modal('show');
                        }
                    });
                });
            });
        })();
        </script>

    <?php } ?>

    <!-- Partners Carousel Initialization for non-home pages -->
    <?php if ($current_page !== 'index.php' && !empty($partners)) {
        $partners_count = count($partners);
    ?>
    <script>
    (function initPartnersCarouselWhenJQueryReady() {
        if (typeof window.jQuery === 'undefined') {
            return setTimeout(initPartnersCarouselWhenJQueryReady, 50);
        }
        var $ = window.jQuery;

        $(document).ready(function() {
            if ($('.partners-carousel').length && typeof $.fn.owlCarousel === 'function') {
                var partnerCount = <?php echo (int)$partners_count; ?>;
                // Only enable loop if we have more than 5 partners to avoid duplication
                var enableLoop = partnerCount > 5;

                $('.partners-carousel').owlCarousel({
                    loop: enableLoop,
                    margin: 20,
                    nav: false,
                    dots: partnerCount > 3,
                    autoplay: true,
                    autoplayTimeout: 2000,
                    autoplaySpeed: 800,
                    autoplayHoverPause: true,
                    slideTransition: 'linear',
                    responsive: {
                        0: { items: Math.min(2, partnerCount) },
                        576: { items: Math.min(3, partnerCount) },
                        768: { items: Math.min(4, partnerCount) },
                        992: { items: Math.min(5, partnerCount) }
                    }
                });
            }
        });
    })();
    </script>
    <?php } ?>

</body>


<!-- Mirrored from theme-land.com/digimx/demo/index.php by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 11 Jul 2022 15:13:02 GMT -->
</html>
