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
     * Return all choices of current user
     * STATIC
     */
    public static function getChoiceAll()
    {
        echo json_encode( \Models\Choice::getChoice() );
    }


    /**
     * Return a specific choice of current user
     * STATIC
     */
    public static function getChoiceOne($choice_number)
    {
        echo json_encode( \Models\Choice::getChoice($choice_number) );
    }


    /**
     * Create 3 choices for current user when doesn't exist
     * STATIC
     */
    public static function create()
    {
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
     * Change choices of current user
     * @param $choice_number
     * STATIC
     */
    public static function update()
    {
        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put['choices']) ) {

            echo json_encode([
                'err' => 'Aucune données reçues'
            ]);
        }
        else {
            $choices = $put['choices'];//récupére les choix émis en POST
            $tmp = new \Models\Choice();
            echo json_encode( $tmp->update($choices) );
        }
    }

    /**
     * DELETE ALL CHOICES
     * STATIC
     */
    public static function deleteAll()
    {
        echo json_encode (\Models\Choice::deleteAll());
    }

    /**
     * Delete all choices from a user
     * STATIC
     */
    public static function deleteOne( $login )
    {
        $tmp = new \Models\Choice( $login );
        if( $tmp->delete() ) {
            echo json_encode([
                'err' => null
            ]);
            return;
        }
        else {
            echo json_encode([
                'err' => "Impossible de supprimer les choix de l'utilisateurs"
            ]);
            return;
        }
    }
}
