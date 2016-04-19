<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:26
 */

    namespace Controllers;


    class Club
    {

        public static function all(){

            var_dump( \Models\Club::getAll() );//test de debug
        }
    }