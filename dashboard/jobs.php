<?php include"header.php";?>
<?php include"sidebar.php";?>
<div class="main-content">
 <div class="page-content">
       <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Jobs</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Careers</a></li>
                                        <li class="breadcrumb-item active">Jobs</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Jobs List</h5>
                                    <a href="createjob" class="btn btn-primary btn-sm">Add Job</a>
                                </div>
                                <div class="card-body">
                                    <table id="example" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Status</th>
                                                <th>Deadline</th>
                                                <th>Views</th>
                                                <th>Applicants</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                            $has_views_col = false;
                                            $col_rs_views = mysqli_query($con, "SHOW COLUMNS FROM jobs LIKE 'views'");
                                            if ($col_rs_views && mysqli_num_rows($col_rs_views) > 0) {
                                                $has_views_col = true;
                                            }

                                            $views_select_sql = $has_views_col ? "j.views" : "0 AS views";
                                            $q="SELECT j.*, $views_select_sql, COALESCE(apps.c, 0) AS applications_count
                                                FROM jobs j
                                                LEFT JOIN (
                                                    SELECT job_id, COUNT(*) AS c
                                                    FROM job_applications
                                                    GROUP BY job_id
                                                ) apps ON apps.job_id = j.id
                                                ORDER BY j.created_at DESC";
                                            $r123 = mysqli_query($con,$q);
                                            while($ro = mysqli_fetch_array($r123)){
                                                $id=$ro['id'];
                                                $job_title=$ro['job_title'];
                                                $status=$ro['status'];
                                                $deadline=$ro['deadline'];

                                                $views_count = isset($ro['views']) ? (int)$ro['views'] : 0;
                                                $applications_count = isset($ro['applications_count']) ? (int)$ro['applications_count'] : 0;
                                                $display_views = 100 + $views_count;
                                                $display_applications = 10 + $applications_count;

                                                print "<tr>
                                                    <td>$job_title</td>
                                                    <td>$status</td>
                                                    <td>$deadline</td>
                                                    <td>$display_views</td>
                                                    <td>$display_applications</td>
                                                    <td>
                                                        <div class='dropdown d-inline-block'>
                                                            <button class='btn btn-soft-secondary btn-sm dropdown' type='button' data-bs-toggle='dropdown' aria-expanded='false'>
                                                                <i class='ri-more-fill align-middle'></i>
                                                            </button>
                                                            <ul class='dropdown-menu dropdown-menu-end'>
                                                                <li><a href='editjob/$id' class='dropdown-item'><i class='ri-pencil-fill align-bottom me-2 text-muted'></i> Edit</a></li>
                                                                <li><a href='jobquestions/$id' class='dropdown-item'><i class='ri-question-answer-line align-bottom me-2 text-muted'></i> Questions</a></li>
                                                                <li><a href='jobapplications/$id' class='dropdown-item'><i class='ri-file-list-3-line align-bottom me-2 text-muted'></i> Applications</a></li>
                                                                <li><a href='delete-job.php?id=$id' class='dropdown-item'><i class='ri-delete-bin-fill align-bottom me-2 text-muted'></i> Delete</a></li>
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
