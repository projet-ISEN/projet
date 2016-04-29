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
 * Class Choice
 * @package Controllers
 */
class Choice
{

    /**
     * Choice constructor.
     *
     * @param $params
     */
    public function __construct( $params )
    {
        $this->params = $params;
    }

    /**
     * Renvoi la liste des choix de l'utilisateur courrant
     * STATIC
     */
    public static function getChoiceAll() {
        echo json_encode( \Models\Choice::getChoice() );
    }


    /**
     * Renvoi un choix particulier de l'utilisateur courrant
     * STATIC
     */
    public static function getChoiceOne($choice_number) {
        echo json_encode( \Models\Choice::getChoice($choice_number) );
    }


    /**
     * Permet d'ajouter des choix lorsque qu'ils n'ont jamais été fait
     * STATIC
     */
    public static function create() {
        // Get angular POST variables
        $post = json_decode( file_get_contents("php://input"), true);
        if( empty($post['choices']) ) {

            echo json_encode([
                'err' => 'Aucune données reçue'
            ]);
        }
        else {
            $choices = $post['choices'];//récupére les choix émis en POST
            $tmp = new \Models\Choice();
            echo json_encode( $tmp->create($choices) );
        }
    }

    /**
     * Permet de changer un choix de l'utilisateur connecté
     * @param $choice_number
     * STATIC
     */
    public static function update($choice_number) {
        echo json_encode (\Models\Choice::update($choice_number));
    }

    /**
     * Supprime tous les élément de la table choice
     * STATIC
     */
    public static function deleteAll() {
        echo json_encode (\Models\Choice::deleteAll());
    }
}
