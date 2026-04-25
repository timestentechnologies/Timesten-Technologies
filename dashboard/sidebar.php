<?php
include"../z_db.php";
$username=$_SESSION['username'];
?>
<div class="app-menu navbar-menu">
  <!-- LOGO -->
  <div class="navbar-brand-box">
    <!-- Dark Logo-->
<?php
    $rr=mysqli_query($con,"SELECT ufile FROM logo");
$r = mysqli_fetch_row($rr);
$ufile = $r[0];
?>

    <a href="index.php" class="logo logo-dark">
      <span class="logo-sm">
        <img src="uploads/logo/<?php print $ufile?>" alt="" height="22">
      </span>
      <span class="logo-lg">
        <img src="uploads/logo/<?php print $ufile?>" alt="" height="30">
      </span>
    </a>
    <!-- Light Logo-->
    <a href="index.php" class="logo logo-light">
      <span class="logo-sm">
        <img src="uploads/logo/<?php print $ufile?>" alt="" height="22">
      </span>
      <span class="logo-lg">
        <img src="uploads/logo/<?php print $ufile?>" alt="" height="30">
      </span>
    </a>
    <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover" onclick="toggleSidebar()">
      <i class="ri-record-circle-line"></i>
    </button>
    <script>
    function toggleSidebar() {
        var body = document.body;
        var html = document.documentElement;
        body.classList.toggle('vertical-collpsed');
        body.classList.toggle('sidebar-enable');
        if (html.getAttribute('data-sidebar-size') === 'lg') {
            html.setAttribute('data-sidebar-size', 'sm');
        } else {
            html.setAttribute('data-sidebar-size', 'lg');
        }
    }
    </script>
  </div>

  <div id="scrollbar">
    <div class="container-fluid">

      <div id="two-column-menu">
      </div>
      <ul class="navbar-nav" id="navbar-nav">
        <li class="menu-title"><span data-key="t-menu">Menu</span></li>


        <li class="nav-item">
                <a href="dashboard" class="nav-link" data-key="t-analytics">  <i class="ri-dashboard-2-line"></i> <span data-key="t-dashboards"> Dashboard </span></a>
              </li>

              <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarB" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-file-list-3-line"></i> <span data-key="t-landing">Manage Blog</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarB" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="createblog" class="nav-link" data-key="t-one-page"> Add New </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="blog" class="nav-link" data-key="t-nft-landing">Blog lists </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

              <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarLanding" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-checkbox-multiple-line"></i> <span data-key="t-landing">Manage Services</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarLanding" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="createservice" class="nav-link" data-key="t-one-page"> Add Service </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="services" class="nav-link" data-key="t-nft-landing"> Services List </a>
                                    </li>
                                </ul>
                            </div>
                        </li>


                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarPot" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-rhythm-fill"></i> <span data-key="t-landing">Manage Portfolio</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarPot" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="createportfolio" class="nav-link" data-key="t-one-page"> Add New </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="portfolio" class="nav-link" data-key="t-nft-landing"> Portfolio List </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarCareers" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarCareers">
                                <i class="ri-briefcase-4-line"></i> <span data-key="t-landing">Manage Careers</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarCareers" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="createjob" class="nav-link" data-key="t-one-page"> Add Job </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="jobs" class="nav-link" data-key="t-nft-landing"> Jobs List </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="backup.php" data-key="t-analytics">  <i class="ri-database-2-line"></i> <span> Database Backup </span></a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="documents.php" data-key="t-analytics">  <i class="ri-folder-3-line"></i> <span> Documents </span></a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="employees.php" data-key="t-analytics">  <i class="ri-team-line"></i> <span> Employees </span></a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarFinance" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarFinance">
                                <i class="ri-money-dollar-circle-line"></i> <span data-key="t-landing">Finance</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarFinance" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="customers" class="nav-link"> Customers </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="invoices" class="nav-link"> Invoices </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="products" class="nav-link"> Products </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="payments" class="nav-link"> Payments </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="expenses" class="nav-link"> Expenses </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="statement" class="nav-link"> Statement </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarSl" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-image-fill"></i> <span data-key="t-landing">Manage Slider</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarSl" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="createslide" class="nav-link" data-key="t-one-page"> Add New </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="slider" class="nav-link" data-key="t-nft-landing"> Sliders List </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="static" class="nav-link" data-key="t-nft-landing"> Static Sliders</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarX" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-chrome-fill"></i> <span data-key="t-landing">Manage Social</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarX" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="createsocial" class="nav-link" data-key="t-one-page"> Add New </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="social" class="nav-link" data-key="t-nft-landing">Social List </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarT" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-message-line"></i> <span data-key="t-landing">Manage Testimony</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarT" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="newtestimony" class="nav-link" data-key="t-one-page">New Testimony</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="testimony" class="nav-link" data-key="t-nft-landing"> All Testimonies </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarW" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-rocket-line"></i> <span data-key="t-landing"> Why Choose Us</span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarW" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="addwhy" class="nav-link" data-key="t-one-page"> Add New </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="why" class="nav-link" data-key="t-nft-landing"> All lists </a>
                                    </li>
                                </ul>
                            </div>
                        </li>


                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarReferrals" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarReferrals">
                                <i class="ri-user-shared-line"></i> <span data-key="t-landing"> Referral Program </span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarReferrals" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="referrers" class="nav-link"> Referrers </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="referred_clients" class="nav-link"> Referred Clients </a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a href="inquiries" class="nav-link">
                                <i class="ri-mail-open-line"></i> <span data-key="t-landing"> Inquiries </span>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarK" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="sidebarLanding">
                                <i class="ri-tools-fill"></i> <span data-key="t-landing"> Site Configuration </span>
                            </a>
                            <div class="menu-dropdown collapse" id="sidebarK" style="">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="settings" class="nav-link" data-key="t-one-page"> Site Settings </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="sections" class="nav-link" data-key="t-nft-landing"> Section Titles </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="logo" class="nav-link" data-key="t-nft-landing"> Update Logo </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="contact" class="nav-link" data-key="t-nft-landing"> Update Contact </a>
                                    </li>
                                </ul>
                            </div>
                        </li>









      </ul>
    </div>
    <!-- Sidebar -->
  </div>

  <div class="sidebar-background"></div>
</div>
<!-- Left Sidebar End -->
<!-- Vertical Overlay-->
<div class="vertical-overlay"></div>
