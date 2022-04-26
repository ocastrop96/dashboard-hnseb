<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="https://portal.hnseb.gob.pe/wp-content/uploads/2021/12/logo-hnseb.png" />
    <title>HNSEB - Tablero de Gestión</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- <link rel="stylesheet" href="public/views/plugins/fontawesome-free/css/all.min.css"> -->
    <link rel="stylesheet" href="public/views/resources/css/adminlte.min.css">
    <script src="https://kit.fontawesome.com/a073170c04.js" crossorigin="anonymous"></script>
</head>

<body class="hold-transition layout-top-nav layout-footer-fixed layout-navbar-fixed">
    <div class="wrapper">
        <?php
        include "pages/header.php";
        if (isset($_GET["ruta"])) {
            if (
                // $_GET["ruta"] == "home" ||
                $_GET["ruta"] == "dash-emergencia" ||
                $_GET["ruta"] == "dash-consulta-externa" ||
                $_GET["ruta"] == "dash-hospitalizacion" ||
                $_GET["ruta"] == "dash-salaoperaciones" ||
                $_GET["ruta"] == "dash-gestion" ||
                $_GET["ruta"] == "direccion"
            ) {
                include "pages/" . $_GET["ruta"] . ".php";
            } else {
                include "pages/404.php";
            }
        } else {
            include "pages/dash-consulta-externa.php";
        }
        include "pages/footer.php";
        ?>
    </div>


    <script src="public/views/plugins/jquery/jquery.min.js"></script>

    <script src="public/views/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script src="public/views/resources/js/adminlte.min.js"></script>
</body>

</html>