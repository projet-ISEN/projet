<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:26
 */

    namespace Controllers;


    /**
     * Class Club
     * @package Controllers
     */
    class Club
    {

        public function __construct( $params )
        {
            $this->params = $params;
        }

        public function getAll()
        {
            var_dump( \Models\Club::get() );//test de debug
        }
        public static function getOne($id)
        {
            $club = new \Models\Club($id);
            $club->load();
            var_dump($club);
        }

        public static function create() {

            // if evaluator or admin

            if( empty($_POST['club_name']) ) {
                return print_r( array('err' => 'Un nom de club est nécéssaire') );
            }

            $club = new \Models\Club();
            $club->club_name        = $_POST['club_name'];
            $club->club_description = empty($_POST['club_description']) ? '' : $_POST['club_description'];
            $club->club_mail        = empty($_POST['club_mail'])        ? '' : $_POST['club_mail'] ;
            $club->login            = 'rcolli17';
            //$club->login            = $_SESSION['login'];
            $club->actif            = 1;
            $club->save();
        }
    }