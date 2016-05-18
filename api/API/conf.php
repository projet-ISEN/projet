<?php

namespace API;

/**
 * sets of key/value, for application's configuration
 * All the Database configuration can be override by environement variables
 * Class conf
 * @package API
 */
class Conf{

	/**
	 *  Name of the database
	 * @var string
	 */
	public static $DB_NAME = 'projetm1';

	/**
	 * Adress of the database
	 * @var string
	 */
	public static $DB_HOST = 'localhost';

	/**
	 * User of database
	 * @var string
	 */
	public static $DB_USER = 'root';

	/**
	 * Database password
	 * @var string
	 */
	public static $DB_PASSWORD = '';

/*  public static $PROTOCOLE = 'http://';
    
  	public static $DOMAIN = '127.0.0.1/projet';*/

	/**
	 * use to know if we are on local for test or in production mod
	 * @return bool
	 */
	public static function isDebug()
	{
		$whitelist = array(
			'127.0.0.1',
			'::1',
			'localhost'
		);

		if(!in_array($_SERVER['REMOTE_ADDR'], $whitelist)){
			// not valid
			return false;
		}
		return true;
	}
}
