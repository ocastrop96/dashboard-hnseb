<?php
require_once "dbConnect.php";
class UsuariosModelo
{
    static public function mdlLoginUsuario($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL LOGIN_USUARIO(:cuentaUsuario)");
        $stmt->bindParam(":cuentaUsuario", $datos, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlRegistroIntentos($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRO_INTENTOS(:idUsuario)");
        $stmt->bindParam(":idUsuario", $datos, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarUsuarios($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            tabcont_usuarios.idUsuario, 
            tabcont_usuarios.dniUsuario, 
            tabcont_usuarios.apellidosUsuario, 
            tabcont_usuarios.nombresUsuario, 
            tabcont_usuarios.cuentaUsuario, 
            tabcont_usuarios.correoUsuario, 
            tabcont_usuarios.claveUsuario, 
            tabcont_usuarios.intentosUsuario,
            tabcont_usuarios.fechaAlta, 
            tabcont_usuarios.profileUsuario, 
            tabcont_usuarios.idPerfil, 
            tabcont_perfiles.detallePerfil, 
            tabcont_usuarios.idEstado, 
            tabcont_estadosu.detalleEstadoU
        FROM
            tabcont_usuarios
            INNER JOIN
            tabcont_perfiles
            ON 
                tabcont_usuarios.idPerfil = tabcont_perfiles.idPerfil
            INNER JOIN
            tabcont_estadosu
            ON 
		tabcont_usuarios.idEstado = tabcont_estadosu.idEstado 
        WHERE $item = :$item 
            ORDER BY tabcont_usuarios.idPerfil ASC");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_USUARIOS()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarPerfilesUsuarios($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            tabcont_perfiles.idPerfil, 
            tabcont_perfiles.detallePerfil
        FROM
            tabcont_perfiles WHERE $item = :$item");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_PERFILES_USUARIO()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }

    static public function mdlRegistrarUsuario($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_USUARIO(:idPerfil,:dniUsuario,:apellidosUsuario,:nombresUsuario,:cuentaUsuario,:correoUsuario,:claveUsuario)");
        $stmt->bindParam(":idPerfil", $datos["idPerfil"], PDO::PARAM_INT);
        $stmt->bindParam(":dniUsuario", $datos["dniUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":apellidosUsuario", $datos["apellidosUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":nombresUsuario", $datos["nombresUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":cuentaUsuario", $datos["cuentaUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":correoUsuario", $datos["correoUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":claveUsuario", $datos["claveUsuario"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEditarUsuario($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_USUARIO(:idUsuario,:idPerfil,:dniUsuario,:apellidosUsuario,:nombresUsuario,:cuentaUsuario,:correoUsuario,:claveUsuario)");
        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idPerfil", $datos["idPerfil"], PDO::PARAM_INT);
        $stmt->bindParam(":dniUsuario", $datos["dniUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":apellidosUsuario", $datos["apellidosUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":nombresUsuario", $datos["nombresUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":cuentaUsuario", $datos["cuentaUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":correoUsuario", $datos["correoUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":claveUsuario", $datos["claveUsuario"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlActualizarUsuario($idUsuario, $idEstado)
    {
        $stmt = Conexion::conectar()->prepare("CALL HABILITAR_USUARIO(:idUsuario,:idEstado)");
        $stmt->bindParam(":idUsuario", $idUsuario, PDO::PARAM_STR);
        $stmt->bindParam(":idEstado", $idEstado, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlDesbloquearUsuario($idUsuario)
    {
        $stmt = Conexion::conectar()->prepare("CALL DESBLOQUEAR_USUARIO(:idUsuario)");
        $stmt->bindParam(":idUsuario", $idUsuario, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }

    static public function mdlValidarEstado($idUsuario)
    {
        $stmt = Conexion::conectar()->prepare("CALL VERIFICA_ESTADO_LOG(:idUsuario)");
        $stmt->bindParam(":idUsuario", $idUsuario, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlEliminarUsuario($dato)
    {
        $stmt = Conexion::conectar()->prepare("CALL ELIMINAR_USUARIO(:idUsuario)");
        $stmt->bindParam(":idUsuario", $dato, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
