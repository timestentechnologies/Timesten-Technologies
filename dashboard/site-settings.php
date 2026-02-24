<?php include"header.php";?>
<?php include"sidebar.php";?>

<?php
mysqli_query($con, "CREATE TABLE IF NOT EXISTS email_settings (
  id INT PRIMARY KEY,
  smtp_host VARCHAR(255) NULL,
  smtp_port INT NULL,
  smtp_user VARCHAR(255) NULL,
  smtp_pass VARCHAR(255) NULL,
  smtp_secure VARCHAR(20) NULL,
  from_email VARCHAR(255) NULL,
  from_name VARCHAR(255) NULL,
  logo_url TEXT NULL,
  updated_at DATETIME NULL
)");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS invoice_settings (
  id INT PRIMARY KEY,
  invoice_logo VARCHAR(255) NULL,
  updated_at DATETIME NULL
)");
mysqli_query(
    $con,
    "INSERT INTO invoice_settings (id, invoice_logo, updated_at)
     SELECT 1, '', NOW()
     WHERE NOT EXISTS (SELECT 1 FROM invoice_settings WHERE id=1)"
);
mysqli_query(
    $con,
    "INSERT INTO email_settings (id, smtp_host, smtp_port, smtp_user, smtp_pass, smtp_secure, from_email, from_name, logo_url, updated_at)
     SELECT 1, 'smtp.gmail.com', 587, 'timestenkenya@gmail.com', 'zfye pewm vvvx kbuz', 'tls', 'timestenkenya@gmail.com', 'TimesTen Website', '', NOW()
     WHERE NOT EXISTS (SELECT 1 FROM email_settings WHERE id=1)"
);

$email_errormsg = '';
if (isset($_POST['save_email'])) {
    $smtp_host = mysqli_real_escape_string($con, $_POST['smtp_host']);
    $smtp_port = (int)$_POST['smtp_port'];
    $smtp_user = mysqli_real_escape_string($con, $_POST['smtp_user']);
    $smtp_pass = mysqli_real_escape_string($con, $_POST['smtp_pass']);
    $smtp_secure = mysqli_real_escape_string($con, $_POST['smtp_secure']);
    $from_email = mysqli_real_escape_string($con, $_POST['from_email']);
    $from_name = mysqli_real_escape_string($con, $_POST['from_name']);
    $logo_url = mysqli_real_escape_string($con, $_POST['logo_url']);

    if ($smtp_port < 1) { $smtp_port = 587; }
    if (strlen(trim($smtp_host)) < 2 || strlen(trim($smtp_user)) < 3) {
        $email_errormsg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>SMTP Host and Username are required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        $qb2 = mysqli_query(
            $con,
            "UPDATE email_settings SET smtp_host='$smtp_host', smtp_port=$smtp_port, smtp_user='$smtp_user', smtp_pass='$smtp_pass', smtp_secure='$smtp_secure', from_email='$from_email', from_name='$from_name', logo_url='$logo_url', updated_at=NOW() WHERE id=1"
        );
        if ($qb2) {
            $email_errormsg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Email settings updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }
}

$es_rs = mysqli_query($con, "SELECT * FROM email_settings WHERE id=1 LIMIT 1");
$es = $es_rs ? mysqli_fetch_assoc($es_rs) : null;
$smtp_host_v = $es ? (string)$es['smtp_host'] : 'smtp.gmail.com';
$smtp_port_v = $es && !empty($es['smtp_port']) ? (int)$es['smtp_port'] : 587;
$smtp_user_v = $es ? (string)$es['smtp_user'] : '';
$smtp_pass_v = $es ? (string)$es['smtp_pass'] : '';
$smtp_secure_v = $es ? (string)$es['smtp_secure'] : 'tls';
$from_email_v = $es ? (string)$es['from_email'] : '';
$from_name_v = $es ? (string)$es['from_name'] : 'TimesTen Website';
$logo_url_v = $es ? (string)$es['logo_url'] : '';

$invoice_msg = '';
if (isset($_POST['save_invoice_settings'])) {
    $uploads_dir = 'uploads/logo';
    if (!is_dir($uploads_dir)) {
        @mkdir($uploads_dir, 0777, true);
    }

    $inv_rs = mysqli_query($con, "SELECT invoice_logo FROM invoice_settings WHERE id=1 LIMIT 1");
    $inv_row = $inv_rs ? mysqli_fetch_assoc($inv_rs) : null;
    $current_logo = $inv_row && isset($inv_row['invoice_logo']) ? (string)$inv_row['invoice_logo'] : '';

    $new_logo = '';
    if (isset($_FILES['invoice_logo']) && $_FILES['invoice_logo']['error'] === UPLOAD_ERR_OK) {
        $tmp_name = $_FILES['invoice_logo']['tmp_name'];
        $name = basename($_FILES['invoice_logo']['name']);
        $random_digit = rand(1000, 9999);
        $new_logo = $random_digit . $name;
        if (!move_uploaded_file($tmp_name, "$uploads_dir/$new_logo")) {
            $new_logo = '';
            $invoice_msg = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Failed to upload invoice logo.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }

    if (strlen($invoice_msg) < 1) {
        $logo_to_save = strlen($new_logo) > 0 ? $new_logo : $current_logo;
        $logo_to_save_s = mysqli_real_escape_string($con, $logo_to_save);
        $qb3 = mysqli_query($con, "UPDATE invoice_settings SET invoice_logo='$logo_to_save_s', updated_at=NOW() WHERE id=1");
        if ($qb3) {
            $invoice_msg = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Invoice settings updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }
}

$inv_rs2 = mysqli_query($con, "SELECT invoice_logo FROM invoice_settings WHERE id=1 LIMIT 1");
$inv2 = $inv_rs2 ? mysqli_fetch_assoc($inv_rs2) : null;
$invoice_logo_v = $inv2 && !empty($inv2['invoice_logo']) ? (string)$inv2['invoice_logo'] : '';
?>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Site Config</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Site</a></li>
                                        <li class="breadcrumb-item active">Config</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- end page title -->


                    <div class="row">

                        <!--end col-->
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-header">
                                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">
                                                <i class="fas fa-home"></i> Site Configuration
                                            </a>
                                        </li>


                                    </ul>
                                </div>



                                <?php
           $status = "OK"; //initial status
$msg="";
           if(ISSET($_POST['save'])){
$site_keyword = mysqli_real_escape_string($con,$_POST['site_keyword']);
$site_desc = mysqli_real_escape_string($con,$_POST['site_desc']);
$site_title = mysqli_real_escape_string($con,$_POST['site_title']);
$site_about = mysqli_real_escape_string($con,$_POST['site_about']);
$site_footer = mysqli_real_escape_string($con,$_POST['site_footer']);
$follow_text = mysqli_real_escape_string($con,$_POST['follow_text']);
$site_url = mysqli_real_escape_string($con,$_POST['site_url']);

 if ( strlen($site_keyword) < 1 ){
$msg=$msg."Site Keyword field can not be empty.<BR>";
$status= "NOTOK";}
 if ( strlen($site_desc) < 1 ){
$msg=$msg."Site Description Field Must contain a Character.<BR>";
$status= "NOTOK";}


 /*
$uploads_dir = 'uploads';

        $tmp_name = $_FILES["ufile"]["tmp_name"];
        // basename() may prevent filesystem traversal attacks;
        // further validation/sanitation of the filename may be appropriate
        $name = basename($_FILES["ufile"]["name"]);
        $random_digit=rand(0000,9999);
        $new_file_name=$random_digit.$name;

        move_uploaded_file($tmp_name, "$uploads_dir/$new_file_name");*/

if($status=="OK")
{
$qb=mysqli_query($con,"update siteconfig set site_keyword='$site_keyword', site_desc='$site_desc', site_title='$site_title',site_about='$site_about',site_footer='$site_footer',follow_text='$follow_text',site_url='$site_url' where id=1");

		if($qb){
		    	$errormsg= "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
                  Site Setting Updated successfully.
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



                                <div class="card-body p-4">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="personalDetails" role="tabpanel">

                                        <?php
					 $query="SELECT * FROM siteconfig where id=1 ";


 $result = mysqli_query($con,$query);
$i=0;
while($row = mysqli_fetch_array($result))
{
	$site_title="$row[site_title]";
	$site_keyword="$row[site_keyword]";
  $site_about="$row[site_about]";
  $site_footer="$row[site_footer]";
  $follow_text="$row[follow_text]";
  $site_desc="$row[site_desc]";
  $site_url="$row[site_url]";
}
  ?>




                                      <?php
if($_SERVER['REQUEST_METHOD'] == 'POST')
						{
						print $errormsg;
						}
   ?>
              <form action="" method="post" enctype="multipart/form-data">
                                                <div class="row">


   <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Site Title</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="site_title"  value="<?php print $site_title ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Site Keywords</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="site_keyword"  value="<?php print $site_keyword ?>">
                                                        </div>
                                                    </div>


                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label"> Site Description</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="site_desc" rows="3" placeholder="Enter Site Description"><?php print $site_desc ?></textarea>
                                                        </div>
                                                    </div>
                                                    <!--end col-->

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Footer About</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5"  name="site_about" rows="3" placeholder="Enter Footer About Text"> <?php print $site_about ?></textarea>
                                                        </div>
                                                    </div>


                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Footer Text</label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="site_footer" placeholder="&copy; 2022 All Rights Reserved"  value="<?php print $site_footer ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Social Follow Text</label>
                                                            <textarea class="form-control" id="exampleFormControlTextarea5" name="follow_text" rows="3" placeholder="Enter Footer follow us session Text"><?php print $follow_text ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="firstnameInput" class="form-label">Website URL </label>
                                                            <input type="text" class="form-control" id="firstnameInput" name="site_url" placeholder="https://website.com"  value="<?php print $site_url ?>">
                                                        </div>
                                                    </div>

                                                    <!--end col-->

                                                    <!--end col-->
                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Setting</button>

                                                        </div>
                                                    </div>
                                                    <!--end col-->
                                                </div>
                                                <!--end row-->
                                            </form>
                                        </div>
                                        <!--end tab-pane-->

                                        <!--end tab-pane-->

                                        <!--end tab-pane-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end col-->
                    </div>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-3">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Invoice Settings</h5>
                                </div>
                                <div class="card-body p-4">
                                    <?php if (strlen($invoice_msg) > 0) { print $invoice_msg; } ?>
                                    <form action="" method="post" enctype="multipart/form-data">
                                        <div class="row g-3">
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Invoice Logo</label>
                                                <input type="file" name="invoice_logo" class="form-control" accept="image/*">
                                                <div class="form-text">This logo will be used on invoice print/PDF.</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Current Invoice Logo</label>
                                                <div class="border rounded p-2 bg-light" style="min-height:70px;display:flex;align-items:center;justify-content:center;">
                                                    <?php if (strlen(trim($invoice_logo_v)) > 0) { ?>
                                                        <img src="<?php print htmlspecialchars('uploads/logo/' . $invoice_logo_v); ?>" alt="Invoice Logo" style="max-height:60px;max-width:220px;object-fit:contain;">
                                                    <?php } else { ?>
                                                        <div class="text-muted" style="font-size:12px;">No invoice logo set.</div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save_invoice_settings" class="btn btn-primary">Update Invoice Settings</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-3">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Email (SMTP) Settings</h5>
                                </div>
                                <div class="card-body p-4">
                                    <?php if (strlen($email_errormsg) > 0) { print $email_errormsg; } ?>
                                    <form action="" method="post">
                                        <div class="row g-3">
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">SMTP Host</label>
                                                <input type="text" name="smtp_host" class="form-control" value="<?php print htmlspecialchars($smtp_host_v); ?>">
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <label class="form-label">SMTP Port</label>
                                                <input type="number" name="smtp_port" class="form-control" value="<?php print (int)$smtp_port_v; ?>">
                                            </div>
                                            <div class="col-12 col-md-3">
                                                <label class="form-label">Security</label>
                                                <select name="smtp_secure" class="form-select">
                                                    <option value="tls" <?php print ($smtp_secure_v==='tls'?'selected':''); ?>>TLS</option>
                                                    <option value="ssl" <?php print ($smtp_secure_v==='ssl'?'selected':''); ?>>SSL</option>
                                                    <option value="" <?php print ($smtp_secure_v===''?'selected':''); ?>>None</option>
                                                </select>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">SMTP Username</label>
                                                <input type="text" name="smtp_user" class="form-control" value="<?php print htmlspecialchars($smtp_user_v); ?>">
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">SMTP Password / App Password</label>
                                                <input type="text" name="smtp_pass" class="form-control" value="<?php print htmlspecialchars($smtp_pass_v); ?>">
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">From Email</label>
                                                <input type="text" name="from_email" class="form-control" value="<?php print htmlspecialchars($from_email_v); ?>">
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">From Name</label>
                                                <input type="text" name="from_name" class="form-control" value="<?php print htmlspecialchars($from_name_v); ?>">
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label">Email Logo URL (optional)</label>
                                                <input type="text" name="logo_url" class="form-control" placeholder="https://.../logo.png" value="<?php print htmlspecialchars($logo_url_v); ?>">
                                            </div>
                                            <div class="col-12">
                                                <div class="hstack gap-2 justify-content-end">
                                                    <button type="submit" name="save_email" class="btn btn-primary">Update Email Settings</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

            <?php include"footer.php";?>
