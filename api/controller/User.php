<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 26/02/2016
 * Time: 09:54
 */

    namespace Controllers;


    class User {


        private $model;
        private $params;

        /**
         * User constructor.
         *
         * @param $params
         */
        public function __construct($params)
        {
            $this->params = $params;
        }

        /**
         * Load an user with his ID
         * @throws \Exception
         */
        public function get() {

            $user = new \Models\User( $this->params[0] );
            $user->load();
            var_dump($user);
        }
    }

    /*

    1000 : Personnel

    1001 : CSI1

    1101 : CIR1

    1201 : BTS-INFO-1

    1301 : BTS-ELEC-1

    1002 : CSI2

    1102 : CIR2

    1202 : BTS-INFO-2

    1302 : BTS-ELEC-2

    1003 : CSI3

    1103 : CIR3

    1303 : CIPA3

    1004 :  M1

    1304 : CIPA4

    1005 : M2

    1305 : CIPA5

    1006 : N6

    1306 : CIPA6

    1010 : Divers

    1011 : Vacataire

    1012 : Invite

    1013 : Thesard

    1100 : club

    */
?>