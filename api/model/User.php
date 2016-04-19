<?php

    namespace Models;

    class User extends \API\Model {

        protected static $table = 'USER';
        
        public function __construct( $login ) {

            parent::__construct();

            // Champs de la base de donnée
            $this->needed = [ 'uid', 'groupe', 'prenom', 'nom'];
            $this->uid = $login ;


        }

        public function existInOwnDb() {

            // user in already in db ? else create
        }
    }
?>