<?php
    /**
     * Created by PhpStorm.
     * User: rcd18
     * Date: 26/02/2016
     * Time: 14:42
     */

    namespace API;

    /**
     * Class Database
     * @package API
     */
    class Database {

        private         $PDOInstance    = null;
        private static  $instance       = null;

        /**
         * Database constructor.
         */
        private function __construct()
        {
            try {

                $dsn        = 'mysql:dbname='. getenv('DB_NAME') .';host=' . getenv('DB_HOST');
                $user       = getenv( 'DB_USER' );
                $pass       = getenv( 'DB_PASSWORD' );
                $options    = array(
                    \PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8',
                    \PDO::ATTR_ERRMODE => \PDO::ERRMODE_WARNING
                );

                $this->PDOInstance = new \PDO( $dsn, $user, $pass, $options );
            }
            catch( \PDOException $e ) {

                throw new \Exception($e->getMessage());
            }
        }

        /**
         * Fonction du singleton
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
         * @param $query
         *
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

        public static function prepare( $req ) {

            $d = self::getInstance();
            return $d->PDOInstance->prepare( $req );
        }
    }
?>