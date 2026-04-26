<?php include "header.php"; ?>
<?php include "sidebar.php"; ?>
<?php
include_once "../pricing_data.php";
pricing_ensure_schema($con);

$successmsg = '';
$errormsg = '';

if (isset($_POST['save_settings'])) {
    $heading = mysqli_real_escape_string($con, $_POST['heading']);
    $subheading = mysqli_real_escape_string($con, $_POST['subheading']);
    $intro_text = mysqli_real_escape_string($con, $_POST['intro_text']);
    $cta_text = mysqli_real_escape_string($con, $_POST['cta_text']);
    $cta_link = mysqli_real_escape_string($con, $_POST['cta_link']);

    $ok = mysqli_query(
        $con,
        "UPDATE pricing_page_settings SET heading='$heading', subheading='$subheading', intro_text='$intro_text', cta_text='$cta_text', cta_link='$cta_link', updated_at=NOW() WHERE id=1"
    );

    if ($ok) {
        $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Pricing page settings updated.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        $errormsg = "<div class='alert alert-danger'>Failed to update settings: " . mysqli_error($con) . "</div>";
    }
}

if (isset($_POST['save_plan'])) {
    $plan_id = isset($_POST['plan_id']) ? (int)$_POST['plan_id'] : 0;

    $name = mysqli_real_escape_string($con, $_POST['name']);
    $price = mysqli_real_escape_string($con, $_POST['price']);
    $billing_period = mysqli_real_escape_string($con, $_POST['billing_period']);
    $short_desc = mysqli_real_escape_string($con, $_POST['short_desc']);
    $features = mysqli_real_escape_string($con, $_POST['features']);
    $button_text = mysqli_real_escape_string($con, $_POST['button_text']);
    $button_link = mysqli_real_escape_string($con, $_POST['button_link']);
    $is_featured = isset($_POST['is_featured']) ? 1 : 0;
    $is_active = isset($_POST['is_active']) ? 1 : 0;
    $sort_order = isset($_POST['sort_order']) ? (int)$_POST['sort_order'] : 0;

    if (strlen(trim($name)) < 2 || strlen(trim($price)) < 1) {
        $errormsg = "<div class='alert alert-danger alert-dismissible fade show'>Plan name and price are required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        if ($plan_id > 0) {
            $ok = mysqli_query(
                $con,
                "UPDATE pricing_plans SET name='$name', price='$price', billing_period='$billing_period', short_desc='$short_desc', features='$features', button_text='$button_text', button_link='$button_link', is_featured=$is_featured, sort_order=$sort_order, is_active=$is_active, updated_at=NOW() WHERE id=$plan_id"
            );
        } else {
            $ok = mysqli_query(
                $con,
                "INSERT INTO pricing_plans (name, price, billing_period, short_desc, features, button_text, button_link, is_featured, sort_order, is_active, created_at, updated_at)
                 VALUES ('$name', '$price', '$billing_period', '$short_desc', '$features', '$button_text', '$button_link', $is_featured, $sort_order, $is_active, NOW(), NOW())"
            );
        }

        if ($ok) {
            $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Pricing plan saved.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $errormsg = "<div class='alert alert-danger'>Failed to save plan: " . mysqli_error($con) . "</div>";
        }
    }
}

if (isset($_POST['delete_plan']) && isset($_POST['delete_id'])) {
    $delete_id = (int)$_POST['delete_id'];
    $ok = mysqli_query($con, "DELETE FROM pricing_plans WHERE id=$delete_id");
    if ($ok) {
        $successmsg = "<div class='alert alert-success alert-dismissible fade show'>Pricing plan deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } else {
        $errormsg = "<div class='alert alert-danger'>Failed to delete plan: " . mysqli_error($con) . "</div>";
    }
}

$settings_rs = mysqli_query($con, "SELECT * FROM pricing_page_settings WHERE id=1 LIMIT 1");
$settings = $settings_rs ? mysqli_fetch_assoc($settings_rs) : null;

$plans_rs = mysqli_query($con, "SELECT * FROM pricing_plans ORDER BY sort_order ASC, id ASC");
$plans = [];
if ($plans_rs) {
    while ($r = mysqli_fetch_assoc($plans_rs)) {
        $plans[] = $r;
    }
}

$editing_plan = null;
if (isset($_GET['edit']) && is_numeric($_GET['edit'])) {
    $edit_id = (int)$_GET['edit'];
    $edit_rs = mysqli_query($con, "SELECT * FROM pricing_plans WHERE id=$edit_id LIMIT 1");
    $editing_plan = $edit_rs ? mysqli_fetch_assoc($edit_rs) : null;
}
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Pricing Page</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Website</a></li>
                                <li class="breadcrumb-item active">Pricing</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <?php if (strlen($successmsg)) { print $successmsg; } ?>
            <?php if (strlen($errormsg)) { print $errormsg; } ?>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Page Content</h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Heading</label>
                                        <input type="text" class="form-control" name="heading" value="<?php print htmlspecialchars($settings ? $settings['heading'] : ''); ?>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Subheading</label>
                                        <input type="text" class="form-control" name="subheading" value="<?php print htmlspecialchars($settings ? $settings['subheading'] : ''); ?>">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Intro Text</label>
                                        <textarea class="form-control" name="intro_text" rows="3"><?php print htmlspecialchars($settings ? $settings['intro_text'] : ''); ?></textarea>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">CTA Button Text</label>
                                        <input type="text" class="form-control" name="cta_text" value="<?php print htmlspecialchars($settings ? $settings['cta_text'] : ''); ?>">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">CTA Link (e.g. contact)</label>
                                        <input type="text" class="form-control" name="cta_link" value="<?php print htmlspecialchars($settings ? $settings['cta_link'] : ''); ?>">
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" name="save_settings" class="btn btn-primary">Save Page Content</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <h5 class="card-title mb-0">Pricing Plans</h5>
                            <a href="pricing" class="btn btn-sm btn-soft-primary">Add New</a>
                        </div>
                        <div class="card-body">
                            <form method="post" action="" class="mb-4">
                                <input type="hidden" name="plan_id" value="<?php print $editing_plan ? (int)$editing_plan['id'] : 0; ?>">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="form-label">Plan Name</label>
                                        <input type="text" class="form-control" name="name" value="<?php print htmlspecialchars($editing_plan ? $editing_plan['name'] : ''); ?>" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Price</label>
                                        <input type="text" class="form-control" name="price" value="<?php print htmlspecialchars($editing_plan ? $editing_plan['price'] : ''); ?>" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Billing Period</label>
                                        <input type="text" class="form-control" name="billing_period" value="<?php print htmlspecialchars($editing_plan ? $editing_plan['billing_period'] : ''); ?>" placeholder="one-time / monthly">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Short Description</label>
                                        <textarea class="form-control" name="short_desc" rows="2"><?php print htmlspecialchars($editing_plan ? $editing_plan['short_desc'] : ''); ?></textarea>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Features (one per line)</label>
                                        <textarea class="form-control" name="features" rows="5"><?php print htmlspecialchars($editing_plan ? $editing_plan['features'] : ''); ?></textarea>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Button Text</label>
                                        <input type="text" class="form-control" name="button_text" value="<?php print htmlspecialchars($editing_plan ? $editing_plan['button_text'] : ''); ?>" placeholder="Get Started">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Button Link (e.g. contact)</label>
                                        <input type="text" class="form-control" name="button_link" value="<?php print htmlspecialchars($editing_plan ? $editing_plan['button_link'] : ''); ?>" placeholder="contact">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Sort Order</label>
                                        <input type="number" class="form-control" name="sort_order" value="<?php print htmlspecialchars($editing_plan ? $editing_plan['sort_order'] : '0'); ?>">
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check mt-2">
                                            <input class="form-check-input" type="checkbox" name="is_featured" id="is_featured" value="1" <?php print ($editing_plan && (int)$editing_plan['is_featured'] === 1) ? 'checked' : ''; ?>>
                                            <label class="form-check-label" for="is_featured">Featured Plan</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check mt-2">
                                            <input class="form-check-input" type="checkbox" name="is_active" id="is_active" value="1" <?php print (!$editing_plan || (int)$editing_plan['is_active'] === 1) ? 'checked' : ''; ?>>
                                            <label class="form-check-label" for="is_active">Active</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" name="save_plan" class="btn btn-primary">Save Plan</button>
                                        <?php if ($editing_plan) { ?>
                                            <a href="pricing" class="btn btn-light ms-2">Cancel</a>
                                        <?php } ?>
                                    </div>
                                </div>
                            </form>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped align-middle" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Active</th>
                                            <th>Featured</th>
                                            <th>Sort</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($plans as $p) { ?>
                                            <tr>
                                                <td><?php print (int)$p['id']; ?></td>
                                                <td><?php print htmlspecialchars($p['name']); ?></td>
                                                <td><?php print htmlspecialchars($p['price']); ?></td>
                                                <td><?php print ((int)$p['is_active'] === 1) ? '<span class="badge bg-success">Yes</span>' : '<span class="badge bg-secondary">No</span>'; ?></td>
                                                <td><?php print ((int)$p['is_featured'] === 1) ? '<span class="badge bg-primary">Yes</span>' : '<span class="badge bg-secondary">No</span>'; ?></td>
                                                <td><?php print (int)$p['sort_order']; ?></td>
                                                <td>
                                                    <a href="pricing?edit=<?php print (int)$p['id']; ?>" class="btn btn-sm btn-soft-primary">Edit</a>
                                                    <form method="post" action="" class="d-inline" onsubmit="return confirm('Delete this plan?');">
                                                        <input type="hidden" name="delete_id" value="<?php print (int)$p['id']; ?>">
                                                        <button type="submit" name="delete_plan" class="btn btn-sm btn-soft-danger">Delete</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<?php include "footer.php"; ?>
