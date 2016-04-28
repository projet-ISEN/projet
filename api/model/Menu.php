<?php
/**
 * User: Vincent Riouallon
 * Date: 28/04/2016
 * Time: 15:37
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Menu
 * @package Models
 */
class Menu {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante

    public $login;


    /**
     * Menu constructor.
     */
    public function __construct( ) {

        $this->login            =  $_SESSION["user"] -> login;


    }

    public function addMenuUserNonMember() {

    }

    public function addMenuUserMember() {

    }

    public function addMenuPresident() {

    }

    public function addMenuCapisen() {

    }


    public function addMenuBDE() {

    }


    public function addMenuEvaluator() {

    }


    public function addMenuAdministrator() {

    }

    public function jsonMenu() {

        $menu ='';


        //$_SESSION["user"] -> login;


        echo json_encode($menu);

    }

}
?>
