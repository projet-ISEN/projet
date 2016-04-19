<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:15
 */

    namespace Models;


    class Club extends \API\Model {

        protected static $table = 'CLUB';

        public function __construct( $id = null ) {

            parent::__construct();

            $this->needed = ['name', 'description'];

            if( $id ) {

                $this->uid = $id ;
            }

        }
    }
?>