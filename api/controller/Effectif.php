<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 26/04/2016
 * Time: 14:01
 */

namespace Controllers;

use API\Database;

/**
 * Class Effectif
 * @package Controllers
 */
class Effectif
{

    /**
     * Effectif constructor.
     *
     * @param $params
     */
    public function __construct( $params )
    {
        $this->params = $params;
    }

    /**
     * Return all asked effectifs
     */
    public function getAll()
    {
        $effectif = new \Models\Effectif();

        echo json_encode( $effectif->get() );
        return;
    }

    /**
     * Return effectif demand of club
     * @param $id
     */
    public function getOne( $id )
    {
        $effectif = new \Models\Effectif( $id );

        echo json_encode( $effectif->get() );
        return;
    }

    /**
     * Set effectif demand for a club, for all projects type
     * @param $club_id
     */
    public static function set( $club_id )
    {
        $notAllow = [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']];
        # Some clubs can't give effectifs
        if( in_array($club_id, $notAllow) )
        {
            echo  json_encode([
                'err' => "Votre club ne peut pas donner d'effectifs"
            ]);
            return;
        }

        if( !$_SESSION['user']->isPresident() ) {
            echo json_encode([
                'err' => "Vous n'êtes pas autorisé à faire cela"
            ]);
            return;
        }

        $put = json_decode( file_get_contents("php://input"), true);

        if( empty($put['effectifs']) ){
            echo json_encode([
               'err' => 'Il manque des paramètres'
            ]);
            return;
        }
        $status = true;
        foreach ( $put['effectifs'] as $effectif ) {
            //var_dump($effectif);
            $tmp = new \Models\Effectif($club_id, $effectif['project_id']);
            $tmp->nb_asked_min = $effectif['nb_asked_min'];
            $tmp->nb_asked_max = $effectif['nb_asked_max'];

            if( !$tmp->save() ) {
                $status = false;
            }
        }

        if( $status ) {
            echo json_encode([
                'err' => null
            ]);
        }
        else {
            echo json_encode([
                'err' => 'Un problème est survenu'
            ]);
        }
        return;
    }

    /**
     * Is this club can give effectifs
     * @param $club_id
     */
    public static function rights( $club_id )
    {
        if( in_array($club_id, [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']]) ){
            echo json_encode([
                'right' => false
            ]);
            return;
        }
        echo json_encode([
           'right' => true
        ]);
        return;
    }
}
