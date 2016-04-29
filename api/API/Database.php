<?php
    /**
     * Created by PhpStorm.
     * User: rcd18
     * Date: 26/02/2016
     * Time: 14:42
     */

    namespace API;

    use \PDOException;

    /**
     * Fournit une connexion à la base de donnée
     * Class Database
     * @package API
     */
    class Database {

        public          $PDOInstance    = null;
        private static  $instance       = null;

        /**
         * Database constructor.
         * Initialise la connexion
         */
        private function __construct()
        {
            try {

                $dsn        = 'mysql:dbname='. \API\conf::$DB_NAME .';host=' . \API\conf::$DB_HOST;
                $user       = \API\conf::$DB_USER;
                $pass       = \API\conf::$DB_PASSWORD;
                $options    = array(
                    \PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8',
                    \PDO::ATTR_ERRMODE => \PDO::ERRMODE_WARNING
                );

                $this->PDOInstance = new \PDO( $dsn, $user, $pass, $options );
            }
            catch( PDOException $e ) {

                echo json_encode([
                    'err' => $e
                ]);
                die();
            }
        }

        /**
         * Fonction du singleton
         * retourne une instance unique de la classe Database
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
         * Raccourcis permettant d'effectuer une requête de stype SELECT dans la base
         * Elle retourne un TABLEAU de résultat
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

                    return $statement->fetchAll( \PDO::FETCH_OBJ ); // ne double pas les résultats
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
         * Demande au SGBD de génerer un identifiant unique
         * (utilisé pour l'insertion d'éléments)
         * @return mixed
         */
        public static function getUID() {

            return self::getInstance()->PDOInstance->query("SELECT UUID()")->fetchAll(\PDO::FETCH_NUM)[0][0];
        }
    }
?>
