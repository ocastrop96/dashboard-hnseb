<?php
session_start();
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="https://portal.hnseb.gob.pe/wp-content/uploads/2021/12/logo-hnseb.png" />
    <title>HNSEB - Tablero de Gestión</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Font Awesome -->
  <!-- <link rel="stylesheet" href="public/views/plugins/fontawesome-free/css/all.min.css"> -->
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Datatables -->
  <link rel="stylesheet" href="public/views/plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="public/views/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="public/views/plugins/datatables-bs4/css/dataTables.bootstrap4.css">
  <!-- Select2 -->
  <link rel="stylesheet" href="public/views/plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="public/views/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <!--iCheck -->
  <link rel="stylesheet" href="public/views/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JqueryUI -->
  <link rel="stylesheet" href="public/views/plugins/jquery-ui/jquery-ui.min.css">
  <!-- Sweetalert -->
  <link rel="stylesheet" href="public/views/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <link rel="stylesheet" href="public/views/plugins/bootstrap-datepicker/bootstrap-datepicker.css">
  <link rel="stylesheet" href="public/views/plugins/bootstrap-datepicker/bootstrap-datepicker.css.map">
  <!-- Toastr -->
  <link rel="stylesheet" href="public/views/plugins/toastr/toastr.min.css">
  <link rel="stylesheet" href="public/views/plugins/daterangepicker/daterangepicker.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="public/views/resources/css/adminlte.css">
  <link rel="stylesheet" href="public/views/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- CSS -->
  <!-- JS -->
  <script src="public/views/plugins/jquery/jquery.min.js"></script>
  <!-- jQuery UI 1.11.4 -->
  <script src="public/views/plugins/jquery-ui/jquery-ui.min.js"></script>
  <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
  <!-- Bootstrap 4 -->
  <script src="public/views/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="https://kit.fontawesome.com/a073170c04.js" crossorigin="anonymous"></script>
  <!-- ChartJS -->
  <script src="public/views/plugins/chart.js/Chart.js"></script>

  <!-- Datatables -->
  <script src="public/views/plugins/datatables/jquery.dataTables.js"></script>
  <script src="public/views/plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
  <script src="public/views/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script src="public/views/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <!-- Select2 -->
  <script src="public/views/plugins/select2/js/select2.full.min.js"></script>
  <script src="public/views/plugins/jquery-ui/jquery-ui.min.js"></script>
  <!-- Sweetalert -->
  <script src="public/views/plugins/sweetalert2/sweetalert2.min.js"></script>
  <!-- Toastr -->
  <script src="public/views/plugins/toastr/toastr.min.js"></script>
  <script src="public/views/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
  <script src="public/views/plugins/bootstrap-datepicker/bootstrap-datepicker.es.min.js"></script>
  <!-- daterangepicker -->
  <script src="public/views/plugins/moment/moment.min.js"></script>
  <script src="public/views/plugins/inputmask/jquery.inputmask.min.js"></script>
  <script src="public/views/plugins/daterangepicker/daterangepicker.js"></script>
  <!-- overlayScrollbars -->
  <!-- jquery-validation -->
  <script src="public/views/plugins/jquery-validation/jquery.validate.min.js"></script>
  <script src="public/views/plugins/jquery-validation/additional-methods.min.js"></script>
  <!-- AdminLTE App -->
  <script src="public/views/resources/js/adminlte.js"></script>
  <script src="public/views/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
</head>

<body class="hold-transition layout-top-nav layout-footer-fixed layout-navbar-fixed">


    <!-- VALIDACIÓN DE VARIABLE DE SESIÓN -->
    <?php
    if (isset($_SESSION["loginDashBI"]) && $_SESSION["loginDashBI"] == "ok") {
        echo '<div class="wrapper">';
        include "pages/header.php";
        if (isset($_GET["ruta"])) {
            if (
                $_GET["ruta"] == "dash-emergencia" ||
                $_GET["ruta"] == "dash-consulta-externa" ||
                $_GET["ruta"] == "dash-hospitalizacion" ||
                $_GET["ruta"] == "dash-salaoperaciones" ||
                $_GET["ruta"] == "dash-gestion" ||
                $_GET["ruta"] == "dash-gestion-camas" ||
                $_GET["ruta"] == "dash-gestion-farmacia" ||
                $_GET["ruta"] == "signin" ||
                $_GET["ruta"] == "signout"
            ) {
                include "pages/" . $_GET["ruta"] . ".php";
            } else {
                include "pages/404.php";
            }
        } else {
            include "pages/dash-consulta-externa.php";
        }
        include "pages/footer.php";

        echo '</div>';
    } else {
        include "pages/signin.php";
    }
    ?>
    <!-- VALIDACIÓN DE VARIABLE DE SESIÓN -->
    <script type="text/javascript" src="public/js/main.js"></script>
    <script type="text/javascript" src="public/js/login.js"></script>
    <script type="text/javascript" src="public/js/usuarios.js"></script>
</body>

</html>