<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 26/02/2016
 * Time: 14:42
 */

namespace API;

use \PDOException;
use \PDO;
use \API\Conf;
use \Controllers\Logger;

/**
 * Fournit une connexion à la base de donnée
 * Class Database
 * @package API
 */
class Database {

    /**
     * PDO Object for Singleton
     * @var null|PDO
     */
    public          $PDOInstance    = null;
    /**
     * Singleton of this class
     * @var null
     */
    private static  $instance       = null;

    /**
     * Database constructor.
     * Initialise la connexion
     */
    private function __construct()
    {
        $user       = empty($_ENV['DB_USER'])?          Conf::$DB_USER       : $_ENV['DB_USER'];
        $pass       = empty($_ENV['DB_PASSWORD'])?      Conf::$DB_PASSWORD   : $_ENV['DB_PASSWORD'];
        $name       = empty($_ENV['DB_NAME'])?          Conf::$DB_NAME       : $_ENV['DB_NAME'];
        $host       = empty($_ENV['DB_HOST'])?          Conf::$DB_HOST       : $_ENV['DB_HOST'];
        $dsn        = 'mysql:dbname='. $name .';host=' . $host . ';charset=utf8';

        $options    = array(
            PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING
        );

        try {

            $this->PDOInstance = new PDO( $dsn, $user, $pass, $options );
        }
        catch( PDOException $e ) {

            Logger::error( 'PDO: ' . $e->getMessage() );
            die();
        }
    }

    /**
     * Return a unique instance of this class
     * @return Database|null
     */
    public static function getInstance()
    {
        if( self::$instance == null )
        {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    /**
     * Shortcut for a SELECT sql request
     * @param $query
     * @return null
     */
    public static function Select( $query )
    {
        $dbInstance = self::getInstance();
        $statement 	= $dbInstance->PDOInstance->query( $query );

        if( $statement != NULL )
        {
            try {

                return $statement->fetchAll( PDO::FETCH_OBJ ); // ne double pas les résultats
            }
            catch (\PDOException $e) {

                echo $e->getMessage();
            }
        }
        else {
            return null;
        }
    }

    /**
     * Get a UUID from SGBD
     * (Use for add elements with UUID)
     * @return mixed
     */
    public static function getUID()
    {
        return self::getInstance()->PDOInstance->query("SELECT UUID()")->fetchAll(PDO::FETCH_NUM)[0][0];
    }
}
?>
