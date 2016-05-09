<?php

namespace API;

/**
 * Permet de stocker des valeurs servant à la configuration de l'application
 * Class conf
 * @package API
 */
class Conf{

	public static $DB_NAME = 'projetm1';
	
	public static $DB_HOST = 'localhost';
	
	public static $DB_USER = 'root';
	
	public static $DB_PASSWORD = '';

/*  public static $PROTOCOLE = 'http://';
    
  	public static $DOMAIN = '127.0.0.1/projet';*/

	public static function isDebug() {

		if( empty($_ENV['DEBUG']) ) return false;
		else return $_ENV['DEBUG'];
	}
}
