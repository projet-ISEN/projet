<?php
/**
 * User: vincent riouallon
 * Date: 10/05/2016
 * Time: 14:30
 */

namespace Controllers;

use API\Database;

/**
 * Class Role
 * @package Controllers
 */
class Role
{


    /**
     * Return the list of role
     */
    public static function getAll()
    {

        $role = new \Models\Role();
        echo json_encode( $role->getAll() );
        return;
    }

    public static function Role2ID($roleName){
       $role = new \Models\Role();
       echo $role -> Role2ID($roleName);
    }

    public static function IDPrez(){
        $role = new \Models\Role();
       return $role -> Role2ID($_SESSION['president']);
    }

    public static function whoPrez($clubId){
        $role = new \Models\Role();
       echo json_encode($role -> ClubRole2Login($clubId, self::IDPrez()));

    }


    public static function pushPrez()
    {

        $post = json_decode( file_get_contents("php://input"), true);
        $role = new \Models\Role();
        echo json_encode( $role->pushPrez($post['login'],$post['clubId']) );
        return;
    }

    public static function add()
    {

        $post = json_decode( file_get_contents("php://input"), true);

        $role = new \Models\Role();
        $role->role_name         = $post['role_name'];

        echo json_encode( $role->add() );
        return;
    }

    public static function update() {

        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put) ) {

            echo json_encode([
                'err' => 'Aucune données reçues'
            ]);
        }
        else {
           $role = new \Models\Role();
            $role->role_id = $put['role_id'];
            $role->role_name = $put['role_name'];
            echo json_encode( $role->update() );
        }
    }

    /**
     * delete the role
     * @param $id
     */
    public static function delete( $role_id ) {

        $role = new \Models\Role();
        $role->role_id = $role_id;
        echo json_encode( $role->remove() );
    }

    /**
     * Get role of a member in a club
     */
    public static function roleOfMember( $clubId, $login )
    {


            $res = \Models\Role::roleOfMember($clubId, $login);
            if (empty($res[0])) {
                echo json_encode([
                    'err' => 'No roles'
                ]);
            } else {
                echo json_encode($res[0]);
            }
            return;
    }

    /**
     * Set Role of member in a club
     * @param $clubId
     * @param $login
     * @param $id_project
     */
    public static function setRoleOfMember( $clubId, $login )
    {
        $post = json_decode( file_get_contents("php://input"), true);
        if(empty($post['member']) || empty($post['member']['id_project']))

        if( $_SESSION['user']->isPresident() )
        {
            $roleName = \Models\Role::ID2Role( $post['member']['role']['id_role'] );
            //var_dump($roleName);
            \Models\Role::setRoleOfMember($clubId, $login, $post['member']['role']['id_role'], $_SESSION['year']);

            echo json_encode([
                'err' => null
            ]);

        }
        else {
            echo json_encode([
                'err' => "Vous n'êtes pas autoriser à faire ca"
            ]);
        }
    }

}







