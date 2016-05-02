<?php
/**
 * User: Vincent Riouallon
 * Date: 29/04/2016
 * Time: 17:37
 */

namespace Models;

use \API\Database;

/**
 * Class Role
 * @package Models
 */
class Role {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante




    /**
     * Role constructor.
     */
    public function __construct( ) {

    }


     /**
     * Return id of the role
     * @return string
     */
    public static function whichRoleID($year,$club_id,$login){

        $role = Database::Select("SELECT id_role FROM role_link WHERE club_id='".$club_id."' AND login = '".$login."' AND school_year='".$year."'");

        return (isset($role[0]->role_id))? $role[0]->role_id : false;

    }

    /**
     * Return name of the role
     * @return string
     */
    public static function ID2Role($role_id){

        $role = Database::Select("SELECT role FROM role WHERE id_role = '".$role_id."'");

        return (isset($role[0]->role))? $role[0]->role : false;
    }


}
?>
