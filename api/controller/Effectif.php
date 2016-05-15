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
     * Renvoi tout les effectifs demandés par les clubs
     */
    public function getAll()
    {
        $effectif = new \Models\Effectif();

        echo json_encode( $effectif->get() );
        return;
    }

    public function getOne( $id )
    {
        $effectif = new \Models\Effectif( $id );

        echo json_encode( $effectif->get() );
        return;
    }

    public static function set( $club_id )
    {
        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put['effectifs']) ){
            echo json_encode([
               'err' => 'Il manque des paramètres'
            ]);
            return;
        }
        foreach ( $put['effectifs'] as $effectif ) {
            var_dump($effectif);
        }
        return;
    }
}
