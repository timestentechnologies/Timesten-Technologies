<?php include"header.php";?>
<?php include"sidebar.php";?>

<?php
mysqli_query($con, "CREATE TABLE IF NOT EXISTS clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    website_url VARCHAR(255),
    logo VARCHAR(255),
    is_active TINYINT(1) DEFAULT 1,
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");
?>

<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">

                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Clients</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Home Page</a></li>
                                        <li class="breadcrumb-item active">Clients</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header d-flex align-items-center justify-content-between">
                                    <h5 class="card-title mb-0">Clients List</h5>
                                    <a href="add-client.php" class="btn btn-primary btn-sm"><i class="ri-add-line"></i> Add Client</a>
                                </div>
                                <div class="card-body">
                                    <table id="example" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th data-ordering="false">Logo</th>
                                                <th>Name</th>
                                                <th>Website</th>
                                                <th>Status</th>
                                                <th>Order</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        <?php
                                           $q="SELECT * FROM clients ORDER BY sort_order ASC, id DESC";
                                           $r123 = mysqli_query($con,$q);

                                           while($ro = mysqli_fetch_array($r123))
                                           {
                                                $id="$ro[id]";
                                                $name=htmlspecialchars($ro['name']);
                                                $website=isset($ro['website_url']) ? htmlspecialchars($ro['website_url']) : '';
                                                $logo=isset($ro['logo']) ? $ro['logo'] : '';
                                                $is_active=isset($ro['is_active']) ? (int)$ro['is_active'] : 1;
                                                $sort_order=isset($ro['sort_order']) ? (int)$ro['sort_order'] : 0;
                                                $status_badge = $is_active ? "<span class='badge bg-success'>Active</span>" : "<span class='badge bg-secondary'>Inactive</span>";

                                                $logo_html = $logo ? "<img src='uploads/clients/$logo' alt='logo' style='max-height:60px; max-width:120px;'>" : "<span class='text-muted'>No logo</span>";

                                                print "<tr>
                                                    <td>$logo_html</td>
                                                    <td>$name</td>
                                                    <td>" . ($website ? "<a href='$website' target='_blank'>$website</a>" : "<span class='text-muted'>-</span>") . "</td>
                                                    <td>$status_badge</td>
                                                    <td>$sort_order</td>
                                                    <td>
                                                        <div class='dropdown d-inline-block'>
                                                            <button class='btn btn-soft-secondary btn-sm dropdown' type='button' data-bs-toggle='dropdown' aria-expanded='false'>
                                                                <i class='ri-more-fill align-middle'></i>
                                                            </button>
                                                            <ul class='dropdown-menu dropdown-menu-end'>
                                                                <li>
                                                                    <a href='edit-client.php?id=$id' class='dropdown-item'>
                                                                        <i class='ri-pencil-fill align-bottom me-2 text-muted'></i> Edit
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a href='deleteclient.php?id=$id' class='dropdown-item remove-item-btn'>
                                                                        <i class='ri-delete-bin-fill align-bottom me-2 text-muted'></i> Delete
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>";
                                           }
                                        ?>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <?php include"footer.php";?>
