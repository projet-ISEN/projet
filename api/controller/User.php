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
     * Get a user with his login
     * @throws \Exception
     */
    public static function get( $id ) {

        $user = new \Models\User( $id );
        $user->load();
        echo json_encode($user);
        return;
    }

    /**
     * Return all users
     */
    public static function getAll()
    {
        $testPres = $_SESSION['user']->isPresident();
        if($_SESSION['user']->is_administrator || $_SESSION['user']->is_administrator || $testPres )
        {
            $users = \Models\User::getAll();
            foreach ($users as $user)
            {
                $user->load();
            }
            echo json_encode( $users );
            return;
        }
        echo json_encode([
            'err' => "Vous n'avez pas le droit"
        ]);
        return;
    }

    /**
     * Return all evaluators
     */
    public function getEvaluators()
    {
        $evals = \Models\User::getAllEvaluators();
        foreach( $evals as $user)
        {
            $user->load();
        }
        echo json_encode($evals);
        return;
    }

    /**
     * Return current user
     */
    public static function getMe() {
        echo json_encode( $_SESSION['user'] );
        return;
    }

    /**
     * Set my informations
     */
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
}
