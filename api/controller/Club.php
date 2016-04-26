<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:26
 */

namespace Controllers;


/**
 * Class Club
 * @package Controllers
 */
class Club
{
    /**
     * Club constructor.
     *
     * @param $params
     */
    public function __construct( $params )
    {
        $this->params = $params;
    }

    /**
     * Renvoi la liste tout les clubs
     * STATIC
     */
    public static function getAll() {
        echo json_encode( \Models\Club::get() );
    }


    /**
     * Renvoi les informations d' 1 club
     * STATIC
     * @param $id
     */
    pusblic static function getOne( $id )
    {
        $club = new \Models\Club($id);
        $club->load();
        echo json_encode($club);
    }

    /**
     * Crée un nouveau club
     * STATIC
     */
    public static function create() {

        // if evaluator or admin

        if( empty($_POST['club_name']) ) {
            echo json_encode( array('err' => 'Un nom de club est nécéssaire') );
            return;
        }
        
        $club = new \Models\Club();
        $club->club_name        = $_POST['club_name'];
        $club->club_description = empty($_POST['club_description']) ? '' : $_POST['club_description'];
        $club->club_mail        = empty($_POST['club_mail'])        ? '' : $_POST['club_mail'] ;
        $club->login            = $_SESSION['user']->login;
        $club->actif            = 1;
        if( $club->save() ) {
            echo json_encode($club);
        }
        else {
            echo json_encode( array(
                'err' => 'Impossible de d\'enregistrer le nouveau club')
            );
        }
    }

    /**
     * Modifie un club existant
     * STATIC
     * @param $id
     */
    public static function update( $id ) {

        parse_str(file_get_contents("php://input"),$_PUT);

        $club = new \Models\Club($id);
        $club->load();

        // Pour toutes les modifs encoyées
        foreach ($_PUT as $k => $v) {
            // Si l'attribut existe
            $club->$k = $v;
        }

        if( $club->save() ){
            echo json_encode($club);
        }
        else {
            echo json_encode(array('err'=> 'Impossible de modifier ce club'));
        }

    }

    /**
     * Supprime un club existant
     * @param $id
     */
    public static function delete( $id ) {

        $club = new \Models\Club($id);
        if( $club->delete() ) {
            echo json_encode( array('err' => 'null') );
        }
        else {
            echo json_encode( array('err' => "Impossible de supprimer ce club, vérfiez qu'il n'éxiste ".
                'pas de dépendances comme des membres par exemple'));
        }

    }
}