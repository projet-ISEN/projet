<?php

    namespace API;
    use Models\Club;

    /**
     * Class Model
     * @package API
     */
    abstract class Model {
     
        
        public  $uid;
        public  $needed;    // Champs nécéssaires
        private $dbFields;  // Valeurs corréspondantes

        /**
         * Model constructor.
         */
        public function __construct(){
            
            $this->dbFields = array();
        }

        /**
         *
         */
        public function save() {

            $req = 'INSERT INTO ' . $this->table . ' ( ';

            foreach( $this->dbFields as $k => $v ) {

                $req .= $k . ', ';
            }
            substr( $req, 0, -3 ); // enlève les derniers ", "

            $req .= ") VALUES ( ";

            foreach( $this->dbFields as $k => $v ) {

                $req .= $v . ', ';
            }
            substr( $req, 0, -2 ); // enlève les derniers ", "
            $req .= ')';

            echo $req;

        }

        public function update() {

            // take $data and push it into db with good id
        }

        /**
         *
         */
        public function delete() {

            // delete in db with id
        }

        public static function getAll() {

            $req = "SELECT * FROM " . static::$table;
            $d = Database::getInstance();
            return $d->Select( $req );
        }

        public function load( $uid = null ) {

            $id = $uid? $uid : $this->uid;

            if( empty($id) ) {

                throw new \Exception( "What do you want to load ?" );
                return;
            }

            $req = "SELECT * FROM " . static::$table . " WHERE uid=:uid";
            $res = Database::prepare( $req );
            $res->execute( [":uid" => $id] );
            $tab = $res->fetch( \PDO::FETCH_ASSOC );

            if( empty($tab) ) {
                return false; // n'existe pas en base de données
            }

            foreach ($tab as $k => $v) {

                $this->$k = $v;
            }

        }


        public function toJson($param) {

            return json_encode( $param );
        }

        /**
         * Dynamic Getter
         * @param $property
         * @return mixed
         * @throws Exception
         */
        /*public function __get( $property ) {

            if( array_key_exists($property, $this->dbFields) ) {

                return $this->dbFields[$property];
            }

            $trace = debug_backtrace();
            trigger_error(
                'Propriété non-définie via __get() : '
                . $property
                . ' dans '
                . $trace[0]['file']
                . ' à la ligne ' . $trace[0]['line'],
                E_USER_NOTICE);
            return null;
        }*/


        /**
         * Dynamic getter
         * @param $property
         * @param $value
         * @return mixed
         */
        /*public function __set( $property, $value ) {

            $this->dbFields[$property] = $value;
        }

        public function __isset( $name ) {

            return isset( $this->dbFields[$name] );
        }

        public function __unset( $name ) {

            unset($this->dbFields[$name]);
        }*/
    }
?>