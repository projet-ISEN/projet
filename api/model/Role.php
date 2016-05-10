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


 public $role_name;
 public $role_id;

    /**
     * Role constructor.
     */
    public function __construct( ) {
        $this->role_name           = "";
        $this->role_id           = "";
    }


     /**
     * Return an array of IDs of role or false
     * @return string
     */
    public static function whichRoleID($year,$club_id,$login){

        $role = Database::Select("SELECT id_role FROM role_link WHERE club_id='".$club_id."' AND login = '".$login."' AND school_year='".$year."'");
        return (isset($role[0]->id_role))? $role : false;

    }

    /**
     * Return name of the role
     * @return string
     */
    public static function ID2Role($role_id){

        $role = Database::Select("SELECT role FROM role WHERE id_role = '".$role_id."'");

        return (isset($role[0]->role))? $role[0]->role : false;
    }

     public static function getAll()
    {
        return  Database::Select("SELECT * FROM role");
    }



    public function add()
    {


        $values['id_role'] =  Database::getUID();
        $values['role'] = $this->role_name ;

        $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO `role`(`id_role`, `role`)"
                ."VALUES (:id_role, :role)"
            );


            if( $req->execute($values) ) {
                return ['err' => null];
            }
            else {
                return ['err' => 'Impossible de d\'enregistrer le nouveau club'];
            }

    }

        public function update() {
        //création d'une variable locale _PUT

        $req = Database::getInstance()->PDOInstance->prepare("UPDATE role SET  role = :role WHERE id_role = :id_role ");

        $status = true;
        if( !$req->execute( [
                ':id_role' => $this->role_id,
                ':role' => $this->role_name,
            ])) {
                $status = false;
            }

        if( $status ) {
            return array( 'err' => null );
        }
        return array( 'err' => 'Impossible de sauvegarder votre choix' );
    }

    /**
     * delete the project
     * @return bool
     */
    public function remove() {

        $req = Database::getInstance()->PDOInstance->prepare("DELETE FROM role WHERE id_role=:id_role");
        return $req->execute(array('id_role'=> $this->role_id));
    }





}
?>
