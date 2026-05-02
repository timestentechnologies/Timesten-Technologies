// Index of jQuery Active Code

// :: 1.0 PRELOADER ACTIVE CODE
// :: 2.0 NAVIGATION MENU ACTIVE CODE
// :: 3.0 STICKY HEADER ACTIVE CODE
// :: 4.0 SCROLL TO TOP ACTIVE CODE
// :: 5.0 SCROLL LINK ACTIVE CODE
// :: 6.0 SMOOTH SCROLLING ACTIVE CODE
// :: 7.0 AOS ACTIVE CODE
// :: 8.0 WOW ACTIVE CODE
// :: 9.0 PREVENT DEFAULT ACTIVE CODE
// :: 10.0 COUNTERUP ACTIVE CODE
// :: 11.0 FANCYBOX VIDEO POPUP ACTIVE CODE
// :: 12.0 CIRCLE ANIMATION ACTIVE CODE
// :: 13.0 REVIEWS ACTIVE CODE
// :: 14.0 PORTFOLIO ACTIVE CODE
// :: 15.0 CONTACT FORM ACTIVE CODE

(function ($) {
    'use strict';

    var $window = $(window);
    var zero = 0;

    // :: 1.0 PRELOADER ACTIVE CODE
    $(window).on("load", function () {
        $("#digimax-preloader").addClass("loaded");

        if ($("#digimax-preloader").hasClass("loaded")) {
            $("#preloader").delay(900).queue(function () {
                $(this).remove();
            });
        }
    });

    // :: 2.0 NAVIGATION MENU ACTIVE CODE
    jQuery(function ($) {
        'use strict';

        // RESPONSIVE NAVIGATION
        function navResponsive() {
            // Check if the menu already has content
            let menu = $('#menu .items');
            
            // Only populate if the menu is empty or doesn't have our navbar-nav
            if (menu.find('.navbar-nav').length === 0) {
                // Don't clear the menu if it already has content
                let navbar = $('.navbar .items');
                navbar.clone().appendTo(menu);
                
                $('.menu .fa-angle-right').removeClass('fa-angle-right').addClass('fa-angle-down');
            }
        }

        navResponsive();

        $(window).on('resize', function () {
            navResponsive();
        })

        // PREVENT DROPDOWN
        $('.menu .dropdown-menu').each(function () {
            var children = $(this).children('.dropdown').length;
            $(this).addClass('children-' + children);
        })

        $('.menu .nav-item.dropdown').each(function () {
            var children = $(this).children('.nav-link');
            children.addClass('prevent');
        })

        $(document).on('click', '#menu .nav-item .nav-link', function (e) {

            if ($(this).hasClass('prevent')) {
                e.preventDefault();
            }

            var nav_link = $(this);

            nav_link.next().toggleClass('show');

            if (nav_link.hasClass('smooth-anchor')) {
                $('#menu').modal('hide');
            }
        })
    });

    // :: 3.0 STICKY HEADER ACTIVE CODE
    $window.on('scroll', function () {
        if ($(window).scrollTop() > 100) {
            $('.navbar').addClass('navbar-sticky');
            $('.navbar .navbar-nav.action .btn').addClass('btn-bordered');
            $('.navbar .navbar-nav.action .btn').removeClass('btn-bordered-white');
        } else {
            $('.navbar').removeClass('navbar-sticky');
            $('.navbar .navbar-nav.action .btn').removeClass('btn-bordered');
            $('.navbar .navbar-nav.action .btn').addClass('btn-bordered-white');
        }
    });

    $window.on('scroll', function () {
        $('.navbar-sticky').toggleClass('hide', $(window).scrollTop() > zero);
        zero = $(window).scrollTop();
    });

    // :: 4.0 SCROLL TO TOP ACTIVE CODE
    var offset = 300;
    var duration = 500;

    $window.on('scroll', function () {
        if ($(this).scrollTop() > offset) {
            $("#scrollUp").fadeIn(duration);
        } else {
            $("#scrollUp").fadeOut(duration);
        }
    });

    $("#scrollUp").on('click', function () {
        $('html, body').animate({
            scrollTop: 0
        }, duration);
    });

    // :: 5.0 SCROLL LINK ACTIVE CODE
    var scrollLink = $('.scroll');

    // :: 6.0 SMOOTH SCROLLING ACTIVE CODE
    scrollLink.on('click', function (e) {
        e.preventDefault();
        $('body,html').animate({
            scrollTop: $(this.hash).offset().top
        }, 1000);
    });

    // :: 7.0 AOS ACTIVE CODE
    if (window.AOS && typeof window.AOS.init === 'function') {
        AOS.init();
    }

    // :: 8.0 WOW ACTIVE CODE
    if (window.WOW && typeof window.WOW === 'function') {
        new WOW().init();
    }

    // :: 9.0 PREVENT DEFAULT ACTIVE CODE
    $("a[href='#']").on('click', function ($) {
        $.preventDefault();
    });

    // :: 10.0 COUNTERUP ACTIVE CODE
    if ($.fn && typeof $.fn.counterUp === 'function') {
        $('.counter').counterUp({
            delay: 10,
            time: 1000
        });
    }

    // :: 11.0 FANCYBOX VIDEO POPUP ACTIVE CODE
    if ($.fn && typeof $.fn.fancybox === 'function') {
        $(".play-btn").fancybox({
            animationEffect: "zoom-in-out",
            transitionEffect: "circular",
            maxWidth: 800,
            maxHeight: 600,
            youtube: {
                controls: 0
            }
        });
    }

    // :: 12.0 CIRCLE ANIMATION ACTIVE CODE
    $(window).on("load", function () {
        $('.profile-circle-wrapper').addClass('circle-animation');
        $('.profile-icon').fadeIn();
    });
    
    // :: 13.0 REVIEWS ACTIVE CODE
    $('.client-reviews.owl-carousel').owlCarousel({
        loop: true,
        center: true,
        margin: 40,
        nav: false,
        dots: false,
        smartSpeed: 1000,
        autoplay: true,
        autoplayTimeout: 4000,
        animateOut: 'slideOutDown',
        animateIn: 'flipInX',
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 2
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            }
        }
    });

    // :: 14.0 PORTFOLIO ACTIVE CODE
    $('.portfolio-area').each(function(index) {

        var count = index + 1;

        $(this).find('.portfolio-items').removeClass('portfolio-items').addClass('portfolio-items-'+count);
        $(this).find('.portfolio-item').removeClass('portfolio-item').addClass('portfolio-item-'+count);
        $(this).find('.portfolio-btn').removeClass('portfolio-btn').addClass('portfolio-btn-'+count);
        
        var Shuffle = window.Shuffle;
        var shuffleEl = document.querySelector('.portfolio-items-'+count);
        if (!Shuffle || !shuffleEl) {
            return;
        }

        var Filter  = new Shuffle(shuffleEl, {
            itemSelector: '.portfolio-item-'+count,
            buffer: 1,
        })
    
        $('.portfolio-btn-'+count).on('change', function (e) {
    
            var input = e.currentTarget;
            
            if (input.checked) {
                Filter.filter(input.value);
            }
        })
    });

    // :: 15.0 MEDIA CAROUSEL ACTIVE CODE (for Portfolio & Service Detail Pages)
    function initMediaCarousel() {
        var $carousel = $('.media-carousel');
        if (!$carousel.length) {
            return;
        }
        if (!$.fn || typeof $.fn.owlCarousel !== 'function') {
            return;
        }
        $carousel.each(function () {
            var $c = $(this);
            if ($c.hasClass('owl-loaded')) {
                return;
            }
            $c.owlCarousel({
                loop: true,
                margin: 20,
                nav: true,
                dots: true,
                smartSpeed: 800,
                autoplay: true,
                autoplayTimeout: 3000,
                autoplayHoverPause: true,
                slideBy: 1,
                responsive: {
                    0: {
                        items: 1,
                        nav: false
                    },
                    576: {
                        items: 2,
                        nav: true
                    },
                    768: {
                        items: 3,
                        nav: true
                    },
                    992: {
                        items: 4,
                        nav: true
                    },
                    1200: {
                        items: 4,
                        nav: true
                    }
                }
            });
        });
    }

    function initMediaCarouselFallbackScroll() {
        var $carousels = $('.media-carousel').not('.owl-loaded');
        if (!$carousels.length) {
            return;
        }

        $carousels.each(function () {
            var el = this;
            if (el.__mediaScrollTimer) {
                return;
            }

            var step = 1;
            el.__mediaScrollTimer = setInterval(function () {
                if ($(el).hasClass('owl-loaded')) {
                    clearInterval(el.__mediaScrollTimer);
                    el.__mediaScrollTimer = null;
                    return;
                }

                el.scrollLeft += step;
                if (el.scrollLeft + el.clientWidth >= el.scrollWidth - 2) {
                    el.scrollLeft = 0;
                }
            }, 30);
        });
    }

    // Run after DOM is ready + a short delay (covers slower plugin loads)
    $(function () {
        initMediaCarousel();
        setTimeout(initMediaCarousel, 250);
        setTimeout(initMediaCarousel, 1000);
        setTimeout(initMediaCarouselFallbackScroll, 1500);
    });

    $window.on('load', function () {
        initMediaCarousel();
        setTimeout(initMediaCarouselFallbackScroll, 500);
    });

    // :: 16.0 CONTACT FORM ACTIVE CODE
    // Get the form.
    var form = $('#contact-form');
    // Get the messages div.
    var formMessages = $('.form-message');
    // Set up an event listener for the contact form.
    $(form).submit(function (e) {
        // Stop the browser from submitting the form.
        e.preventDefault();
        // Serialize the form data.
        var formData = $(form).serialize();
        // Submit the form using AJAX.
        $.ajax({
                type: 'POST',
                url: $(form).attr('action'),
                data: formData
            })
            .done(function (response) {
                // Make sure that the formMessages div has the 'success' class.
                $(formMessages).removeClass('error');
                $(formMessages).addClass('success');

                // Set the message text.
                $(formMessages).text(response);

                // Clear the form.
                $('#contact-form input,#contact-form textarea').val('');
            })
            .fail(function (data) {
                // Make sure that the formMessages div has the 'error' class.
                $(formMessages).removeClass('success');
                $(formMessages).addClass('error');

                // Set the message text.
                if (data.responseText !== '') {
                    $(formMessages).text(data.responseText);
                } else {
                    $(formMessages).text('Oops! An error occured and your message could not be sent.');
                }
            });
    });

}(jQuery));