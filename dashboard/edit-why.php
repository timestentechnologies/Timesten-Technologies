<?php include"header.php";?>
<?php include"sidebar.php";?>

<?php
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$row = null;
if ($id > 0) {
    $rs = mysqli_query($con, "SELECT * FROM why_us WHERE id=$id LIMIT 1");
    $row = $rs ? mysqli_fetch_assoc($rs) : null;
}

$status = "OK";
$msg = "";
$errormsg = "";

if (isset($_POST['save']) && $id > 0) {
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $detail = mysqli_real_escape_string($con, $_POST['detail']);
    $icon_class = mysqli_real_escape_string($con, $_POST['icon_class']);
    $icon_type = mysqli_real_escape_string($con, $_POST['icon_type']);

    // Handle icon upload
    $icon_image = $icon_image_v; // Keep existing by default
    if($icon_type == 'upload' && isset($_FILES['icon_image']) && $_FILES['icon_image']['name'] != '') {
        $target_dir = "uploads/whyicons/";
        if(!is_dir($target_dir)) {
            mkdir($target_dir, 0755, true);
        }
        $file_extension = strtolower(pathinfo($_FILES['icon_image']['name'], PATHINFO_EXTENSION));
        $allowed_extensions = array('jpg', 'jpeg', 'png', 'gif', 'svg');
        if(in_array($file_extension, $allowed_extensions)) {
            $new_filename = time() . '_' . basename($_FILES['icon_image']['name']);
            $target_file = $target_dir . $new_filename;
            if(move_uploaded_file($_FILES['icon_image']['tmp_name'], $target_file)) {
                // Delete old icon if exists
                if($icon_image_v && file_exists($target_dir . $icon_image_v)) {
                    unlink($target_dir . $icon_image_v);
                }
                $icon_image = $new_filename;
            }
        } else {
            $msg = $msg . "Invalid file type. Only JPG, PNG, GIF, SVG allowed.<BR>";
            $status = "NOTOK";
        }
    } elseif($icon_type == 'class') {
        // If switching to class, clear the image
        $icon_image = '';
        if($icon_image_v && file_exists("uploads/whyicons/" . $icon_image_v)) {
            unlink("uploads/whyicons/" . $icon_image_v);
        }
    }

    if (strlen($title) < 2) {
        $msg = $msg . "Title Must Contain A Char.<BR>";
        $status = "NOTOK";
    }
    if (strlen($detail) > 500) {
        $msg = $msg . "Detail Must Not Be More Than 500 Char Long.<BR>";
        $status = "NOTOK";
    }

    if ($status == "OK") {
        $qb = mysqli_query($con, "UPDATE why_us SET title='$title', detail='$detail', icon_class='$icon_class', icon_type='$icon_type', icon_image='$icon_image' WHERE id=$id LIMIT 1");
        if ($qb) {
            $errormsg = "
<div class='alert alert-success alert-dismissible alert-outline fade show'>
               Data updated successfully.
                  <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                  </div>
";
            $rs2 = mysqli_query($con, "SELECT * FROM why_us WHERE id=$id LIMIT 1");
            $row = $rs2 ? mysqli_fetch_assoc($rs2) : $row;
        }
    } elseif ($status !== "OK") {
        $errormsg = "
<div class='alert alert-danger alert-dismissible alert-outline fade show'>
                     " . $msg . " <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button> </div>";
    } else {
        $errormsg = "
      <div class='alert alert-danger alert-dismissible alert-outline fade show'>
                 Some Technical Glitch Is There. Please Try Again Later Or Ask Admin For Help.
                 <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                 </div>";
    }
}

$title_v = $row ? (string)$row['title'] : '';
$detail_v = $row ? (string)$row['detail'] : '';
$icon_class_v = $row ? (string)$row['icon_class'] : '';
$icon_type_v = $row ? (string)$row['icon_type'] : 'class';
$icon_image_v = $row ? (string)$row['icon_image'] : '';
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Edit Why Choose Us</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="why-us.php">Why Choose Us</a></li>
                                        <li class="breadcrumb-item active">Edit</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-3">
                                <div class="card-header">
                                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="false">
                                                <i class="fas fa-home"></i> Edit Why Choose Us
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="card-body p-4">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="personalDetails" role="tabpanel">

                                        <?php
                                        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                                            print $errormsg;
                                        }
                                        if ($id < 1 || !$row) {
                                            print "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Record not found.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                                        }
                                        ?>

              <form action="" method="post" enctype="multipart/form-data">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="titleInput" class="form-label"> Title</label>
                                                            <input type="text" class="form-control" id="titleInput" name="title" placeholder="Enter Title" value="<?php print htmlspecialchars($title_v); ?>">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Icon Type</label>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="icon_type" id="iconTypeClass" value="class" <?php print ($icon_type_v == 'class' || empty($icon_type_v)) ? 'checked' : ''; ?> onchange="toggleIconType()">
                                                                <label class="form-check-label" for="iconTypeClass">Font Awesome Icon</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="icon_type" id="iconTypeUpload" value="upload" <?php print $icon_type_v == 'upload' ? 'checked' : ''; ?> onchange="toggleIconType()">
                                                                <label class="form-check-label" for="iconTypeUpload">Upload Icon Image</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12" id="iconClassSection" style="<?php print ($icon_type_v == 'class' || empty($icon_type_v)) ? 'display:block;' : 'display:none;'; ?>">
                                                        <div class="mb-3">
                                                            <label for="iconClassInput" class="form-label">Icon Class (Font Awesome)</label>
                                                            <select class="form-control" id="iconClassInput" name="icon_class">
                                                                <option value="">Select an icon</option>
                                                                <option value="fas fa-check-circle" <?php print $icon_class_v == 'fas fa-check-circle' ? 'selected' : ''; ?>>Check Circle</option>
                                                                <option value="fas fa-star" <?php print $icon_class_v == 'fas fa-star' ? 'selected' : ''; ?>>Star</option>
                                                                <option value="fas fa-heart" <?php print $icon_class_v == 'fas fa-heart' ? 'selected' : ''; ?>>Heart</option>
                                                                <option value="fas fa-shield-alt" <?php print $icon_class_v == 'fas fa-shield-alt' ? 'selected' : ''; ?>>Shield</option>
                                                                <option value="fas fa-award" <?php print $icon_class_v == 'fas fa-award' ? 'selected' : ''; ?>>Award</option>
                                                                <option value="fas fa-trophy" <?php print $icon_class_v == 'fas fa-trophy' ? 'selected' : ''; ?>>Trophy</option>
                                                                <option value="fas fa-medal" <?php print $icon_class_v == 'fas fa-medal' ? 'selected' : ''; ?>>Medal</option>
                                                                <option value="fas fa-gem" <?php print $icon_class_v == 'fas fa-gem' ? 'selected' : ''; ?>>Gem</option>
                                                                <option value="fas fa-crown" <?php print $icon_class_v == 'fas fa-crown' ? 'selected' : ''; ?>>Crown</option>
                                                                <option value="fas fa-thumbs-up" <?php print $icon_class_v == 'fas fa-thumbs-up' ? 'selected' : ''; ?>>Thumbs Up</option>
                                                                <option value="fas fa-lightbulb" <?php print $icon_class_v == 'fas fa-lightbulb' ? 'selected' : ''; ?>>Lightbulb</option>
                                                                <option value="fas fa-rocket" <?php print $icon_class_v == 'fas fa-rocket' ? 'selected' : ''; ?>>Rocket</option>
                                                                <option value="fas fa-bolt" <?php print $icon_class_v == 'fas fa-bolt' ? 'selected' : ''; ?>>Bolt</option>
                                                                <option value="fas fa-fire" <?php print $icon_class_v == 'fas fa-fire' ? 'selected' : ''; ?>>Fire</option>
                                                                <option value="fas fa-cog" <?php print $icon_class_v == 'fas fa-cog' ? 'selected' : ''; ?>>Cog</option>
                                                                <option value="fas fa-wrench" <?php print $icon_class_v == 'fas fa-wrench' ? 'selected' : ''; ?>>Wrench</option>
                                                                <option value="fas fa-tools" <?php print $icon_class_v == 'fas fa-tools' ? 'selected' : ''; ?>>Tools</option>
                                                                <option value="fas fa-headset" <?php print $icon_class_v == 'fas fa-headset' ? 'selected' : ''; ?>>Headset</option>
                                                                <option value="fas fa-handshake" <?php print $icon_class_v == 'fas fa-handshake' ? 'selected' : ''; ?>>Handshake</option>
                                                                <option value="fas fa-users" <?php print $icon_class_v == 'fas fa-users' ? 'selected' : ''; ?>>Users</option>
                                                                <option value="fas fa-user-check" <?php print $icon_class_v == 'fas fa-user-check' ? 'selected' : ''; ?>>User Check</option>
                                                                <option value="fas fa-chart-line" <?php print $icon_class_v == 'fas fa-chart-line' ? 'selected' : ''; ?>>Chart Line</option>
                                                                <option value="fas fa-chart-bar" <?php print $icon_class_v == 'fas fa-chart-bar' ? 'selected' : ''; ?>>Chart Bar</option>
                                                                <option value="fas fa-dollar-sign" <?php print $icon_class_v == 'fas fa-dollar-sign' ? 'selected' : ''; ?>>Dollar Sign</option>
                                                                <option value="fas fa-percent" <?php print $icon_class_v == 'fas fa-percent' ? 'selected' : ''; ?>>Percent</option>
                                                                <option value="fas fa-tag" <?php print $icon_class_v == 'fas fa-tag' ? 'selected' : ''; ?>>Tag</option>
                                                                <option value="fas fa-tags" <?php print $icon_class_v == 'fas fa-tags' ? 'selected' : ''; ?>>Tags</option>
                                                                <option value="fas fa-gift" <?php print $icon_class_v == 'fas fa-gift' ? 'selected' : ''; ?>>Gift</option>
                                                                <option value="fas fa-box" <?php print $icon_class_v == 'fas fa-box' ? 'selected' : ''; ?>>Box</option>
                                                                <option value="fas fa-box-open" <?php print $icon_class_v == 'fas fa-box-open' ? 'selected' : ''; ?>>Box Open</option>
                                                                <option value="fas fa-truck" <?php print $icon_class_v == 'fas fa-truck' ? 'selected' : ''; ?>>Truck</option>
                                                                <option value="fas fa-shipping-fast" <?php print $icon_class_v == 'fas fa-shipping-fast' ? 'selected' : ''; ?>>Shipping Fast</option>
                                                                <option value="fas fa-clock" <?php print $icon_class_v == 'fas fa-clock' ? 'selected' : ''; ?>>Clock</option>
                                                                <option value="fas fa-calendar-check" <?php print $icon_class_v == 'fas fa-calendar-check' ? 'selected' : ''; ?>>Calendar Check</option>
                                                                <option value="fas fa-phone" <?php print $icon_class_v == 'fas fa-phone' ? 'selected' : ''; ?>>Phone</option>
                                                                <option value="fas fa-envelope" <?php print $icon_class_v == 'fas fa-envelope' ? 'selected' : ''; ?>>Envelope</option>
                                                                <option value="fas fa-comments" <?php print $icon_class_v == 'fas fa-comments' ? 'selected' : ''; ?>>Comments</option>
                                                                <option value="fas fa-comment-dots" <?php print $icon_class_v == 'fas fa-comment-dots' ? 'selected' : ''; ?>>Comment Dots</option>
                                                                <option value="fas fa-smile" <?php print $icon_class_v == 'fas fa-smile' ? 'selected' : ''; ?>>Smile</option>
                                                                <option value="fas fa-globe" <?php print $icon_class_v == 'fas fa-globe' ? 'selected' : ''; ?>>Globe</option>
                                                                <option value="fas fa-wifi" <?php print $icon_class_v == 'fas fa-wifi' ? 'selected' : ''; ?>>Wifi</option>
                                                                <option value="fas fa-lock" <?php print $icon_class_v == 'fas fa-lock' ? 'selected' : ''; ?>>Lock</option>
                                                                <option value="fas fa-unlock" <?php print $icon_class_v == 'fas fa-unlock' ? 'selected' : ''; ?>>Unlock</option>
                                                                <option value="fas fa-key" <?php print $icon_class_v == 'fas fa-key' ? 'selected' : ''; ?>>Key</option>
                                                                <option value="fas fa-database" <?php print $icon_class_v == 'fas fa-database' ? 'selected' : ''; ?>>Database</option>
                                                                <option value="fas fa-server" <?php print $icon_class_v == 'fas fa-server' ? 'selected' : ''; ?>>Server</option>
                                                                <option value="fas fa-cloud" <?php print $icon_class_v == 'fas fa-cloud' ? 'selected' : ''; ?>>Cloud</option>
                                                                <option value="fas fa-laptop" <?php print $icon_class_v == 'fas fa-laptop' ? 'selected' : ''; ?>>Laptop</option>
                                                                <option value="fas fa-desktop" <?php print $icon_class_v == 'fas fa-desktop' ? 'selected' : ''; ?>>Desktop</option>
                                                                <option value="fas fa-mobile-alt" <?php print $icon_class_v == 'fas fa-mobile-alt' ? 'selected' : ''; ?>>Mobile</option>
                                                                <option value="fas fa-tablet-alt" <?php print $icon_class_v == 'fas fa-tablet-alt' ? 'selected' : ''; ?>>Tablet</option>
                                                                <option value="fas fa-camera" <?php print $icon_class_v == 'fas fa-camera' ? 'selected' : ''; ?>>Camera</option>
                                                                <option value="fas fa-video" <?php print $icon_class_v == 'fas fa-video' ? 'selected' : ''; ?>>Video</option>
                                                                <option value="fas fa-microphone" <?php print $icon_class_v == 'fas fa-microphone' ? 'selected' : ''; ?>>Microphone</option>
                                                                <option value="fas fa-music" <?php print $icon_class_v == 'fas fa-music' ? 'selected' : ''; ?>>Music</option>
                                                                <option value="fas fa-film" <?php print $icon_class_v == 'fas fa-film' ? 'selected' : ''; ?>>Film</option>
                                                                <option value="fas fa-image" <?php print $icon_class_v == 'fas fa-image' ? 'selected' : ''; ?>>Image</option>
                                                                <option value="fas fa-file" <?php print $icon_class_v == 'fas fa-file' ? 'selected' : ''; ?>>File</option>
                                                                <option value="fas fa-folder" <?php print $icon_class_v == 'fas fa-folder' ? 'selected' : ''; ?>>Folder</option>
                                                                <option value="fas fa-book" <?php print $icon_class_v == 'fas fa-book' ? 'selected' : ''; ?>>Book</option>
                                                                <option value="fas fa-bookmark" <?php print $icon_class_v == 'fas fa-bookmark' ? 'selected' : ''; ?>>Bookmark</option>
                                                                <option value="fas fa-flag" <?php print $icon_class_v == 'fas fa-flag' ? 'selected' : ''; ?>>Flag</option>
                                                                <option value="fas fa-map-marker-alt" <?php print $icon_class_v == 'fas fa-map-marker-alt' ? 'selected' : ''; ?>>Map Marker</option>
                                                                <option value="fas fa-home" <?php print $icon_class_v == 'fas fa-home' ? 'selected' : ''; ?>>Home</option>
                                                                <option value="fas fa-building" <?php print $icon_class_v == 'fas fa-building' ? 'selected' : ''; ?>>Building</option>
                                                                <option value="fas fa-city" <?php print $icon_class_v == 'fas fa-city' ? 'selected' : ''; ?>>City</option>
                                                            </select>
                                                            <small class="form-text text-muted">Choose from Font Awesome icons</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12" id="iconUploadSection" style="<?php print $icon_type_v == 'upload' ? 'display:block;' : 'display:none;'; ?>">
                                                        <div class="mb-3">
                                                            <label for="iconImageInput" class="form-label">Upload Icon Image</label>
                                                            <?php if($icon_image_v) { ?>
                                                                <div class="mb-2">
                                                                    <img src="uploads/whyicons/<?php print htmlspecialchars($icon_image_v); ?>" alt="Current Icon" style="max-height: 50px;">
                                                                    <small class="text-muted d-block">Current icon</small>
                                                                </div>
                                                            <?php } ?>
                                                            <input type="file" class="form-control" id="iconImageInput" name="icon_image" accept=".jpg,.jpeg,.png,.gif,.svg">
                                                            <small class="form-text text-muted">Upload new icon to replace (JPG, PNG, GIF, SVG)</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="mb-3">
                                                            <label for="detailInput" class="form-label">Detail</label>
                                                            <textarea class="form-control" id="detailInput" name="detail" rows="3"><?php print htmlspecialchars($detail_v); ?></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button type="submit" name="save" class="btn btn-primary">Update Why Us</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

<script>
function toggleIconType() {
    var iconType = document.querySelector('input[name="icon_type"]:checked').value;
    if(iconType == 'upload') {
        document.getElementById('iconClassSection').style.display = 'none';
        document.getElementById('iconUploadSection').style.display = 'block';
    } else {
        document.getElementById('iconClassSection').style.display = 'block';
        document.getElementById('iconUploadSection').style.display = 'none';
    }
}
</script>

                </div>
            </div>

            <?php include"footer.php";?>
