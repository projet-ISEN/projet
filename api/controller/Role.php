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

}







