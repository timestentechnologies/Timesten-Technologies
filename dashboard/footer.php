
    <footer class="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6">
                    <script>document.write(new Date().getFullYear())</script> © Timesten Technologies.
                </div>
                <div class="col-sm-6">
                    <div class="text-sm-end d-none d-sm-block">
                        Designed & Developed by Timesten Technologies.
                    </div>
                </div>
            </div>
        </div>
    </footer>
</div>
<!-- end main content-->

</div>
<!-- END layout-wrapper -->



<!--start back-to-top-->
<button onclick="topFunction()" class="btn btn-danger btn-icon" id="back-to-top">
    <i class="ri-arrow-up-line"></i>
</button>
<!--end back-to-top-->

<!-- Theme Settings -->

<!-- JAVASCRIPT -->
<script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/libs/simplebar/simplebar.min.js"></script>
<script src="assets/libs/node-waves/waves.min.js"></script>
<script src="assets/libs/feather-icons/feather.min.js"></script>
<script src="assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
<script src="assets/js/plugins.js?v=<?php echo filemtime('assets/js/plugins.js'); ?>"></script>





<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>

<script src="assets/js/pages/datatables.init.js"></script>




<!-- apexcharts -->
<script src="assets/libs/apexcharts/apexcharts.min.js"></script>

<!-- Vector map-->
<script src="assets/libs/jsvectormap/js/jsvectormap.min.js"></script>
<script src="assets/libs/jsvectormap/maps/world-merc.js"></script>

<!--Swiper slider js-->
<script src="assets/libs/swiper/swiper-bundle.min.js"></script>

<!-- Dashboard init -->
<script src="assets/js/pages/dashboard-ecommerce.init.js"></script>

<!-- App js -->
<script src="assets/js/app.js"></script>

<script>
    (function () {
        try {
            if (window && window.matchMedia && window.matchMedia('(min-width: 768px)').matches) {
                if (window.sessionStorage) {
                    sessionStorage.removeItem('data-sidebar-size');
                }
                if (window.localStorage) {
                    localStorage.removeItem('data-sidebar-size');
                }
                if (document && document.documentElement) {
                    document.documentElement.setAttribute('data-sidebar-size', 'lg');
                }
            }
        } catch (e) {}
    })();
</script>

<script>
    (function () {
        var btn = document.getElementById('topnav-hamburger-icon');
        if (!btn) { return; }

        btn.addEventListener('click', function (e) {
            if (window && window.matchMedia && !window.matchMedia('(max-width: 767.98px)').matches) {
                return;
            }
            if (e && typeof e.preventDefault === 'function') { e.preventDefault(); }
            if (e && typeof e.stopPropagation === 'function') { e.stopPropagation(); }
            if (e && typeof e.stopImmediatePropagation === 'function') { e.stopImmediatePropagation(); }
            try {
                var body = document.body;
                if (!body) { return; }
                if (body.classList.contains('vertical-sidebar-enable') || body.classList.contains('sidebar-enable')) {
                    body.classList.remove('vertical-sidebar-enable');
                    body.classList.remove('sidebar-enable');
                } else {
                    body.classList.add('vertical-sidebar-enable');
                    body.classList.add('sidebar-enable');
                }
            } catch (err) {}
        }, true);
    })();
</script>
</body>


<!-- Mirrored from themesbrand.com/velzon/html/default/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 24 Jun 2022 20:37:39 GMT -->

</html>
<!-- id20806033_timesten	id20806033_root	localhost -->