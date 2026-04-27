<?php include"header.php";?>
<?php include"sidebar.php";?>

<?php
$status = "OK";
$msg = "";

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id < 1) {
    header("Location: clients");
    exit;
}

$qr = mysqli_query($con, "SELECT * FROM clients WHERE id = $id");
if (!$qr || mysqli_num_rows($qr) < 1) {
    header("Location: clients");
    exit;
}
$client = mysqli_fetch_assoc($qr);

if (isset($_POST['save'])) {
    $name = mysqli_real_escape_string($con, $_POST['name']);
    $website_url = mysqli_real_escape_string($con, $_POST['website_url']);
    $is_active = isset($_POST['is_active']) ? 1 : 0;
    $sort_order = isset($_POST['sort_order']) ? (int)$_POST['sort_order'] : 0;

    if (strlen(trim($_POST['name'])) < 2) {
        $msg .= "Client name must be at least 2 characters.<br>";
        $status = "NOTOK";
    }

    $uploads_dir = 'uploads/clients';
    if (!is_dir($uploads_dir)) {
        @mkdir($uploads_dir, 0755, true);
    }

    $logo_file = $client['logo'];
    if (isset($_FILES['logo']) && isset($_FILES['logo']['tmp_name']) && strlen($_FILES['logo']['tmp_name'])) {
        $tmp_name = $_FILES['logo']['tmp_name'];
        $original_name = basename($_FILES['logo']['name']);
        $safe_name = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
        $random_digit = rand(1000, 9999);
        $logo_file = $random_digit . '_' . $safe_name;
        move_uploaded_file($tmp_name, "$uploads_dir/$logo_file");
    }

    if ($status == "OK") {
        $qb = mysqli_query($con, "UPDATE clients SET name='$name', website_url='$website_url', logo='$logo_file', is_active=$is_active, sort_order=$sort_order WHERE id=$id");
        if ($qb) {
            $errormsg = "<div class='alert alert-success alert-dismissible fade show'>Client updated successfully.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            $qr = mysqli_query($con, "SELECT * FROM clients WHERE id = $id");
            $client = mysqli_fetch_assoc($qr);
        } else {
            $errormsg = "<div class='alert alert-danger alert-dismissible fade show'>Database error: " . mysqli_error($con) . "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    } else {
        $errormsg = "<div class='alert alert-danger alert-dismissible fade show'>" . $msg . "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }
}
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Edit Client</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="clients">Clients</a></li>
                                        <li class="breadcrumb-item active">Edit</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <?php if (isset($errormsg)) { print $errormsg; } ?>

                    <div class="row">
                        <div class="col-xxl-9">
                            <div class="card mt-xxl-n5">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Client Details</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Client Name</label>
                                                    <input type="text" name="name" class="form-control" value="<?php echo htmlspecialchars($client['name']); ?>" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Website URL (optional)</label>
                                                    <input type="text" name="website_url" class="form-control" placeholder="https://example.com" value="<?php echo htmlspecialchars($client['website_url'] ?? ''); ?>">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Logo</label>
                                                    <input type="file" name="logo" class="form-control" accept="image/*">
                                                    <?php if ($client['logo']) { ?>
                                                        <div class="mt-2">
                                                            <img src="uploads/clients/<?php echo $client['logo']; ?>" alt="Current logo" style="max-height: 60px;">
                                                            <small class="text-muted d-block">Current logo</small>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3">
                                                    <label class="form-label">Sort Order</label>
                                                    <input type="number" name="sort_order" class="form-control" value="<?php echo (int)($client['sort_order'] ?? 0); ?>">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="mb-3 mt-4">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="is_active" id="is_active" <?php echo ($client['is_active'] ?? 1) ? 'checked' : ''; ?>>
                                                        <label class="form-check-label" for="is_active">Active</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <button type="submit" name="save" class="btn btn-primary">Update Client</button>
                                        <a href="clients" class="btn btn-light">Back</a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <?php include"footer.php";?>
