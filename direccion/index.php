<?php
// Controladores
require_once "./app/controller/PlantillaControlador.php";
require_once "./app/controller/UsuariosControlador.php";


require_once "./app/model/UsuariosModelo.php";



$template = new ControladorPlantilla();
$template->ctrPlantilla();