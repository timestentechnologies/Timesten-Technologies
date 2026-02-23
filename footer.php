<?php include "z_db.php";?>

  <!--====== Footer Area Start ======-->
  <footer class="section footer-area">
            <!-- Footer Top -->
            <div class="footer-top ptb_100">
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-sm-6 col-lg-3">
                            <!-- Footer Items -->
                            <div class="footer-items">
                                <!-- Footer Title -->
                            <h3 class="footer-title text-uppercase mb-2">About Us</h3>
                                <p class="mb-2"><?php print $site_about?></p>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-3">
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

                        <div class="col-12 col-sm-6 col-lg-3">
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

                        <div class="col-12 col-sm-6 col-lg-3">
                            <!-- Footer Items -->
                            <div class="footer-items">
                                <!-- Footer Title -->
                                <h3 class="footer-title text-uppercase mb-2">Quick Links</h3>
                                <ul>
                                    <li class='py-2'><a class='text-black-50' href='home'>Home</a></li>
                                    <li class='py-2'><a class='text-black-50' href='about'>About Us</a></li>
                                    <li class='py-2'><a class='text-black-50' href='services'>Services</a></li>
                                    <li class='py-2'><a class='text-black-50' href='portfolio'>Portfolio</a></li>
                                    <li class='py-2'><a class='text-black-50' href='blog'>Blog</a></li>
                                    <li class='py-2'><a class='text-black-50' href='careers'>Careers</a></li>
                                    <li class='py-2'><a class='text-black-50' href='contact'>Contact</a></li>
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
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <!-- Copyright Area -->
                            <div class="copyright-area d-flex flex-wrap justify-content-center justify-content-sm-between text-center py-4">
                                <!-- Copyright Left -->

                                <div class="copyright-left" style="font-weight:bold;">&copy; <script>document.write(new Date().getFullYear())</script> <?php print $site_footer ?></div>
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
                                        <a href="blog" class="nav-link">Blog</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="careers" class="nav-link">Careers</a>
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
            background: #6730e3;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        
        #menu .modal-body .nav-link:hover {
            color: #6730e3;
            background-color: rgba(103, 48, 227, 0.05);
        }
        
        #menu .modal-body .nav-link:hover:after {
            width: 40px;
        }
        
        /* Active link styling */
        #menu .modal-body .nav-item.active .nav-link {
            color: #6730e3;
            background-color: rgba(103, 48, 227, 0.1);
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
</body>


<!-- Mirrored from theme-land.com/digimx/demo/index.php by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 11 Jul 2022 15:13:02 GMT -->
</html>
