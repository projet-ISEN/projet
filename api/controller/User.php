<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 26/02/2016
 * Time: 09:54
 */

namespace Controllers;

/**
 * Class User
 * @package Controllers
 */
class User {

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
     * Récupère les informations d'un utilisateur en fonction de son Login
     * @throws \Exception
     */
    public static function get( $id ) {

        $user = new \Models\User( $id );
        $user->load();
        echo json_encode($user);
        return;
    }

    /**
     * Renvoie tous les utilisateurs
     */
    public static function getAll() {
        $users = \Models\User::getAll();
        foreach ($users as $user) {
            $user->load();
        }
        echo json_encode( $users );
        return;
    }

    public static function getMe() {
        echo json_encode( $_SESSION['user'] );
        return;
    }

    public static function updateMe() {

        $put = json_decode( file_get_contents("php://input"), true);

        if( isset($put['user_mail']) ) {
            $_SESSION['user']->user_mail = $put['user_mail'];
        }

        if( isset($put['phone']) ) {
            $_SESSION['user']->phone = $put['phone'];
        }

        if( $_SESSION['user']->save() ) {
            echo json_encode([
                'err' => null
            ]);
        }
        else {
            echo json_encode([
                'err' => 'Impossible de modifier vos données.'
            ]);
        }
        return;
    }

    public static function addClub( $user_login, $year=null, $main_club=1 )
    {
        if( empty($year) ) $year = $_SESSION['year'];

        $user = new \Models\User($user_login);
        if( !$user->exist() )
        {
            return json_encode([
                'err' => "Cet utilisateur n'éxiste pas."
            ]);
        }

        $put = json_decode( file_get_contents("php://input"), true);
        if( empty( $put['club_id'] ) || empty( $put['project_id'] ) ) {
            return json_encode([
                'err' => 'Dans quel club doit on mettre cet user?'
            ]);
        }

        $member = new \Models\Member($put['club_id'], $user_login, $year );
        $member->project_id = $put['project_id'];
        $member->main_club = $main_club;

        if( $member->save() )
        {
            echo json_encode([
                'err' => null
            ]);
        }
        else{
            echo json_encode([
                'err' => 'Impossible de mettre ce menbre dans ce club'
            ]);
        }
        return;
    }
}
