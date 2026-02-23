<?php
ob_start();
include "header.php";
include "sidebar.php";

mysqli_query($con, "CREATE TABLE IF NOT EXISTS document_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  created_at DATETIME NULL
)");

mysqli_query($con, "CREATE TABLE IF NOT EXISTS documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NULL,
  title VARCHAR(255) NOT NULL,
  doc_type VARCHAR(20) NOT NULL,
  file_name VARCHAR(255) NULL,
  original_name VARCHAR(255) NULL,
  link_url TEXT NULL,
  uploaded_by VARCHAR(120) NULL,
  related_employee_id INT NULL,
  created_at DATETIME NULL
)");

$username = isset($_SESSION['username']) ? $_SESSION['username'] : '';

$errormsg = '';
$successmsg = '';

if (isset($_SESSION['documents_flash_success'])) {
    $successmsg = (string)$_SESSION['documents_flash_success'];
    unset($_SESSION['documents_flash_success']);
}
if (isset($_SESSION['documents_flash_error'])) {
    $errormsg = (string)$_SESSION['documents_flash_error'];
    unset($_SESSION['documents_flash_error']);
}

$cat_id = isset($_GET['cat']) ? (int)$_GET['cat'] : 0;
$view = isset($_GET['view']) ? (string)$_GET['view'] : 'grid';
if ($view !== 'grid' && $view !== 'list') { $view = 'grid'; }

$cats = [];
$active_cat_name = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_doc_id'])) {
    $doc_id = (int)$_POST['delete_doc_id'];
    if ($doc_id > 0) {
        $doc_q = mysqli_query($con, "SELECT * FROM documents WHERE id=$doc_id LIMIT 1");
        $doc = $doc_q ? mysqli_fetch_assoc($doc_q) : null;
        if ($doc) {
            if ($doc['doc_type'] === 'file' && !empty($doc['file_name'])) {
                $fp = __DIR__ . '/uploads/documents/' . $doc['file_name'];
                if (is_file($fp)) {
                    @unlink($fp);
                }
            }
            mysqli_query($con, "DELETE FROM documents WHERE id=$doc_id LIMIT 1");
            $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Document deleted.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        }
    }

    $qs = [];
    if ($cat_id > 0) { $qs[] = 'cat=' . (int)$cat_id; }
    if (strlen($view) > 0) { $qs[] = 'view=' . urlencode($view); }
    $to = 'documents.php' . (count($qs) ? ('?' . implode('&', $qs)) : '');
    header('Location: ' . $to);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['upload_doc'])) {
    $title = trim((string)($_POST['title'] ?? ''));
    $category_id = (int)($_POST['category_id'] ?? 0);
    $doc_type = (string)($_POST['doc_type'] ?? 'file');
    $link_url = trim((string)($_POST['link_url'] ?? ''));

    if (strlen($title) < 2) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Title is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($category_id < 1) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Please select a category.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($doc_type === 'link' && strlen($link_url) < 5) {
        $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>Link URL is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    } elseif ($doc_type === 'file') {
        if (!isset($_FILES['doc_file']) || $_FILES['doc_file']['error'] !== UPLOAD_ERR_OK) {
            $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>File is required.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
        } else {
            $uploads_dir = __DIR__ . '/uploads/documents';
            if (!is_dir($uploads_dir)) {
                @mkdir($uploads_dir, 0775, true);
            }

            $tmp_name = $_FILES['doc_file']['tmp_name'];
            $original_name = basename($_FILES['doc_file']['name']);
            $safe_original = preg_replace("/[^a-zA-Z0-9.\-_]/", "", $original_name);
            $random_digit = rand(1000, 9999);
            $file_name = $random_digit . '_' . $safe_original;

            if (!move_uploaded_file($tmp_name, $uploads_dir . '/' . $file_name)) {
                $_SESSION['documents_flash_error'] = "<div class='alert alert-danger alert-dismissible alert-outline fade show'>File upload failed.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            } else {
                $title_s = mysqli_real_escape_string($con, $title);
                $file_s = mysqli_real_escape_string($con, $file_name);
                $orig_s = mysqli_real_escape_string($con, $original_name);
                $uploader_s = mysqli_real_escape_string($con, $username);
                mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, created_at) VALUES ($category_id, '$title_s', 'file', '$file_s', '$orig_s', NULL, '$uploader_s', NOW())");
                $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Document uploaded.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            }
        }
    } else {
        $title_s = mysqli_real_escape_string($con, $title);
        $link_s = mysqli_real_escape_string($con, $link_url);
        $uploader_s = mysqli_real_escape_string($con, $username);
        mysqli_query($con, "INSERT INTO documents (category_id, title, doc_type, file_name, original_name, link_url, uploaded_by, created_at) VALUES ($category_id, '$title_s', 'link', NULL, NULL, '$link_s', '$uploader_s', NOW())");
        $_SESSION['documents_flash_success'] = "<div class='alert alert-success alert-dismissible alert-outline fade show'>Link saved.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
    }

    $qs = [];
    $qs[] = 'cat=' . (int)$category_id;
    if (strlen($view) > 0) { $qs[] = 'view=' . urlencode($view); }
    $to = 'documents.php' . (count($qs) ? ('?' . implode('&', $qs)) : '');
    header('Location: ' . $to);
    exit;
}

$cat_q = mysqli_query($con, "SELECT c.id, c.name, COALESCE(d.cnt,0) AS cnt
  FROM document_categories c
  LEFT JOIN (SELECT category_id, COUNT(*) AS cnt FROM documents GROUP BY category_id) d
  ON d.category_id = c.id
  ORDER BY c.name ASC");
if ($cat_q) {
    while ($r = mysqli_fetch_assoc($cat_q)) {
        $cats[] = $r;
    }
}

if ($cat_id > 0) {
    $ac_q = mysqli_query($con, "SELECT name FROM document_categories WHERE id=$cat_id LIMIT 1");
    $ac = $ac_q ? mysqli_fetch_assoc($ac_q) : null;
    $active_cat_name = $ac ? (string)$ac['name'] : '';
    if (strlen($active_cat_name) < 1) { $cat_id = 0; }
}

$docs = [];
$where = "1=1";
if ($cat_id > 0) {
    $where .= " AND category_id=$cat_id";
}
$docs_q = mysqli_query($con, "SELECT d.*, c.name AS category_name FROM documents d LEFT JOIN document_categories c ON c.id=d.category_id WHERE $where ORDER BY d.id DESC LIMIT 200");
if ($docs_q) {
    while ($r = mysqli_fetch_assoc($docs_q)) {
        $docs[] = $r;
    }
}

$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
$basePath = isset($_SERVER['SCRIPT_NAME']) ? rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'])), '/') : '';
$publicBase = $scheme . '://' . $host . $basePath;
?>

<div class="main-content">
  <div class="page-content">
    <div class="container-fluid">

      <div class="row">
        <div class="col-12">
          <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Documents</h4>
            <div class="page-title-right">
              <ol class="breadcrumb m-0">
                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                <li class="breadcrumb-item active">Documents</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <?php
      if (!empty($errormsg)) { print $errormsg; }
      if (!empty($successmsg)) { print $successmsg; }
      ?>

      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header d-flex flex-wrap align-items-center">
              <h5 class="card-title mb-0">Folders</h5>
              <div class="ms-auto d-flex gap-2">
                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#addDocumentModal">Add Document</button>
                <a href="document-categories.php" class="btn btn-sm btn-soft-primary">Categories</a>
                <a href="documents.php?view=grid" class="btn btn-sm btn-soft-secondary">Grid</a>
                <a href="documents.php?view=list" class="btn btn-sm btn-soft-secondary">List</a>
              </div>
            </div>
            <div class="card-body">
              <?php if (count($cats) < 1) { ?>
                <div class="alert alert-warning mb-0">Create document categories first.</div>
              <?php } else { ?>
                <div class="row">
                  <?php foreach ($cats as $c) {
                      $id = (int)$c['id'];
                      $nm = htmlspecialchars($c['name']);
                      $cnt = (int)$c['cnt'];
                      $active = $cat_id === $id ? ' border border-primary' : '';
                      print "<div class='col-12 col-md-6 col-xl-4 mb-3'>";
                      print "<a class='text-decoration-none text-reset' href='documents.php?cat=$id&view=$view'>";
                      print "<div class='card mb-0$active' style='cursor:pointer;'>";
                      print "<div class='card-body d-flex align-items-center'>";
                      print "<div class='avatar-sm me-3'><span class='avatar-title bg-light text-primary rounded-circle fs-3'><i class='ri-folder-3-line'></i></span></div>";
                      print "<div class='flex-grow-1'><div class='fw-semibold'>$nm</div><div class='text-muted fs-12'>$cnt items</div></div>";
                      print "</div></div></a></div>";
                  } ?>
                </div>
              <?php } ?>
            </div>
          </div>

          <div class="card">
            <div class="card-header d-flex flex-wrap align-items-center">
              <h5 class="card-title mb-0"><?php print $cat_id > 0 ? htmlspecialchars($active_cat_name) : 'All Documents'; ?></h5>
              <div class="ms-auto" style="min-width:260px;">
                <input type="text" class="form-control" id="docSearch" placeholder="Search documents...">
              </div>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-striped table-sm align-middle mb-0" id="docsTable">
                  <thead>
                    <tr>
                      <th>Title</th>
                      <th>Category</th>
                      <th>Type</th>
                      <th>Uploaded</th>
                      <th class="text-end">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    if (count($docs) < 1) {
                        print "<tr><td colspan='5' class='text-center text-muted'>No documents found.</td></tr>";
                    }
                    foreach ($docs as $d) {
                        $id = (int)$d['id'];
                        $title = htmlspecialchars($d['title']);
                        $catn = htmlspecialchars((string)$d['category_name']);
                        $type = htmlspecialchars($d['doc_type']);
                        $created = htmlspecialchars((string)$d['created_at']);

                        $open = '';
                        $shareUrl = '';
                        if ($d['doc_type'] === 'file' && !empty($d['file_name'])) {
                            $fn = rawurlencode($d['file_name']);
                            $open = "uploads/documents/$fn";
                            $shareUrl = $publicBase . "/uploads/documents/$fn";
                        }
                        if ($d['doc_type'] === 'link' && !empty($d['link_url'])) {
                            $open = $d['link_url'];
                            $shareUrl = $open;
                        }
                        $open_h = htmlspecialchars($open);
                        $share_h = htmlspecialchars($shareUrl);

                        print "<tr>";
                        print "<td data-search='$title'>$title</td>";
                        print "<td>$catn</td>";
                        print "<td>$type</td>";
                        print "<td>$created</td>";
                        print "<td class='text-end'>";
                        if (strlen($open) > 0) {
                            print "<a class='btn btn-sm btn-soft-primary' href='$open_h' target='_blank'>Open</a> ";
                        }

                        if (strlen($shareUrl) > 0) {
                            $wa = 'https://wa.me/?text=' . rawurlencode($shareUrl);
                            $wa_h = htmlspecialchars($wa);
                            $em = 'mailto:?subject=' . rawurlencode('Document: ' . $d['title']) . '&body=' . rawurlencode($shareUrl);
                            $em_h = htmlspecialchars($em);

                            print "<div class='btn-group position-static'>";
                            print "<button type='button' class='btn btn-sm btn-soft-secondary dropdown-toggle' data-bs-toggle='dropdown' data-bs-display='static' aria-expanded='false'>Share</button>";
                            print "<ul class='dropdown-menu dropdown-menu-end'>";
                            print "<li><a class='dropdown-item' href='$wa_h' target='_blank'>WhatsApp</a></li>";
                            print "<li><a class='dropdown-item' href='$em_h'>Email</a></li>";
                            print "<li><button type='button' class='dropdown-item js-copy-link' data-url='$share_h'>Copy public URL</button></li>";
                            if ($d['doc_type'] === 'file') {
                                print "<li><a class='dropdown-item' href='$share_h' download>Download</a></li>";
                            }
                            print "</ul>";
                            print "</div> ";
                        }

                        print "<form method='post' class='d-inline' onsubmit=\"return confirm('Delete this document?');\">";
                        print "<input type='hidden' name='delete_doc_id' value='$id'>";
                        print "<button type='submit' class='btn btn-sm btn-soft-danger'>Delete</button>";
                        print "</form>";
                        print "</td>";
                        print "</tr>";
                    }
                    ?>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <div class="modal fade" id="addDocumentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Add Document</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form method="post" enctype="multipart/form-data" id="addDocumentForm">
                    <input type="hidden" name="upload_doc" value="1">

                    <div class="row g-3">
                      <div class="col-12">
                        <label class="form-label" for="title">Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="e.g. Company Policy" required>
                      </div>

                      <div class="col-12">
                        <label class="form-label" for="category_id">Category</label>
                        <select class="form-select" id="category_id" name="category_id" required>
                          <option value="">Select category</option>
                          <?php
                          foreach ($cats as $c) {
                              $id = (int)$c['id'];
                              $nm = htmlspecialchars($c['name']);
                              $sel = $cat_id === $id ? ' selected' : '';
                              print "<option value='$id'$sel>$nm</option>";
                          }
                          ?>
                        </select>
                      </div>

                      <div class="col-12">
                        <label class="form-label">Type</label>
                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="doc_type" id="type_file" value="file" checked>
                          <label class="form-check-label" for="type_file">File upload</label>
                        </div>
                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="doc_type" id="type_link" value="link">
                          <label class="form-check-label" for="type_link">Link</label>
                        </div>
                      </div>

                      <div class="col-12" id="file_box">
                        <label class="form-label" for="doc_file">File</label>
                        <input class="form-control" type="file" id="doc_file" name="doc_file">
                        <div class="form-text">Any file type is allowed.</div>
                      </div>

                      <div class="col-12 d-none" id="link_box">
                        <label class="form-label" for="link_url">Link URL</label>
                        <input class="form-control" type="url" id="link_url" name="link_url" placeholder="https://...">
                      </div>
                    </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" form="addDocumentForm" class="btn btn-primary">Save</button>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

    </div>
  </div>
  <?php include "footer.php"; ?>
</div>

<script>
(function(){
  var fileRadio = document.getElementById('type_file');
  var linkRadio = document.getElementById('type_link');
  var fileBox = document.getElementById('file_box');
  var linkBox = document.getElementById('link_box');
  if (fileRadio && linkRadio && fileBox && linkBox) {
    function toggle(){
      if (linkRadio.checked) {
        fileBox.classList.add('d-none');
        linkBox.classList.remove('d-none');
      } else {
        fileBox.classList.remove('d-none');
        linkBox.classList.add('d-none');
      }
    }
    fileRadio.addEventListener('change', toggle);
    linkRadio.addEventListener('change', toggle);
    toggle();
  }

  var input = document.getElementById('docSearch');
  var table = document.getElementById('docsTable');
  if (input && table) {
    input.addEventListener('input', function(){
      var q = (input.value || '').toLowerCase();
      var rows = table.querySelectorAll('tbody tr');
      rows.forEach(function(tr){
        var text = tr.innerText.toLowerCase();
        tr.style.display = text.indexOf(q) !== -1 ? '' : 'none';
      });
    });
  }

  document.addEventListener('click', function(e){
    var btn = e.target && e.target.closest ? e.target.closest('.js-copy-link') : null;
    if (!btn) return;
    var url = btn.getAttribute('data-url') || '';
    if (!url) return;

    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(url);
      return;
    }

    var ta = document.createElement('textarea');
    ta.value = url;
    ta.style.position = 'fixed';
    ta.style.left = '-9999px';
    document.body.appendChild(ta);
    ta.select();
    try { document.execCommand('copy'); } catch (err) {}
    document.body.removeChild(ta);
  });
})();
</script>
