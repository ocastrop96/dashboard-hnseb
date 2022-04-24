<?php
class Conexion
{
	static public function conectar()
	{
		$link = new PDO(
			"mysql:host=localhost;dbname=db-tablero-web",
			"adm-tablero",
			'!B@FXLP@9drwrHMV^F$I'
		);
		$link->exec("set names utf8");
		return $link;
	}
}
