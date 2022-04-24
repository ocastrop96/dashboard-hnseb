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

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="public/views/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="public/views/resources/css/adminlte.css">
</head>

<body class="hold-transition layout-top-nav layout-footer-fixed layout-navbar-fixed">


    <!-- VALIDACIÓN DE VARIABLE DE SESIÓN -->
    <?php
    if (isset($_SESSION["loginDashBI"]) && $_SESSION["loginDashBI"] == "ok") {
        echo '<div class="wrapper">';
        include "pages/header.php";
        if (isset($_GET["ruta"])) {
            if (
                $_GET["ruta"] == "home" ||
                $_GET["ruta"] == "dash-emergencia" ||
                $_GET["ruta"] == "dash-consulta-externa" ||
                $_GET["ruta"] == "dash-hospitalizacion" ||
                $_GET["ruta"] == "signin" ||
                $_GET["ruta"] == "signout"
            ) {
                include "pages/" . $_GET["ruta"] . ".php";
            } else {
                include "pages/404.php";
            }
        } else {
            include "pages/home.php";
        }
        include "pages/footer.php";

        echo '</div>';
    } else {
        include "pages/signin.php";
    }
    ?>
    <!-- VALIDACIÓN DE VARIABLE DE SESIÓN -->
    <script src="public/views/plugins/jquery/jquery.min.js"></script>
    <script src="public/views/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="public/views/resources/js/adminlte.min.js"></script>

    <script type="text/javascript" src="public/js/main.js"></script>
    <script type="text/javascript" src="public/js/login.js"></script>
    <script type="text/javascript" src="public/js/usuarios.js"></script>
</body>

</html>