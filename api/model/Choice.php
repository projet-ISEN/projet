<?php
/**
 * User: Vincent Riouallon
 * Date: 28/04/2016
 * Time: 11:28
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Choice
 * @package Models
 */
class Choice {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante

    public $login;


    /**
     * Choice constructor.
     */
    public function __construct( $login=null )
    {
        $this->login            =  $_SESSION["user"] -> login;

        if( !empty($login) ) $this->login = $login;
    }

    /**
     * Renvoi un boolean en fonction de si les choix ont été fait ou non
     */

    public function alreadyChoose() {
        $res = Database::getInstance()->PDOInstance->query("SELECT count(*) FROM choice WHERE login='" . $this->login . "'")
            ->fetchAll(\PDO::FETCH_NUM)[0][0];
        return ($res == 3);
    }

    /**
     * Renvoi la liste des choix de l'utilisateur connécté
     * sous forme de JSON
     * @param null $choiceNumber
     */
    public static function getChoice( $choiceNumber=null ) {

        if( $choiceNumber ) {

            $req = Database::Select("SELECT * FROM choice WHERE login='" .
                $_SESSION['user']->login . "' AND choice_number=" . $choiceNumber
            );
        }
        else {

            $req = Database::Select("SELECT * FROM choice WHERE login='" .
                $_SESSION['user']->login . "'"
            );
        }
        return $req;

    }

    /**
     * Ajoute les 3 choix de la personne postulante dans une club dans la base de donnée
     *param $choices
     */
    public function create($choices) {

        if( $this->alreadyChoose() ){ // Il y a déja des choix
            return ['err' => 'Il existe déja des choix, vous ne pouvez que les modifier' ];
        }
        else {

            // Check les tricheurs
            if( count($choices) != 3 )
            {
                return [ 'err' => '3 choix obligatoirement ' . count($choices) . ' envoyés' ];
            }
            if( $choices[1] == $choices[2] OR $choices[2] == $choices[3] OR $choices[1] == $choices[3] )
            {
                return [ 'err' => 'Les choix doivent être différents' ];
            }

            $req = Database::getInstance()->PDOInstance->prepare("INSERT INTO choice (login, club_id, choice_number) ".
            "VALUES (:login, :club_id, :choice_number)");

            $status = true;

            foreach( $choices as $number => $club ) {
                if( !$req->execute( [
                    ':login' => $_SESSION['user']->login,
                    ':club_id' => $club,
                    ':choice_number' => $number
                ])) {
                    $status = false;
                }
            }

            if($status) {
                return [ 'err' => null ];
                \Controllers\Logger::info( $_SESSION['user']->login . "made his choices");
            }
            else {
                return [ 'err' => 'Impossible de sauvegarder vos choix' ];
            }
        }
    }

    /**
     * Permet de changer un choix de l'utilisateur connecté
     * @param $choice_number
     */
    public static function update( $choices ) {
        //création d'une variable locale _PUT

        $req = Database::getInstance()->PDOInstance->prepare("UPDATE choice SET club_id=:club_id WHERE login=:login " . "AND choice_number=:choice_number");

        $status = true;
        foreach( $choices as $number => $club ) {
            if( !$req->execute( [
                    ':login' => $_SESSION['user']->login,
                    ':club_id' => $club,
                    ':choice_number' => $number
                ])) {
                    $status = false;
                }
        }

        if( $status ) {
            return array( 'err' => null );
        }
        return array( 'err' => 'Impossible de sauvegarder votre choix' );
    }


    /**
     * Supprime tous les élément de la table choice
     */
    public static function deleteAll()
    {
        $req = Database::getInstance()->PDOInstance->exec("Delete from choice");
        if( $req ) return array( 'err' => null );
        else return array( 'err' => "An error occurred" );
    }

    public function delete() {
        $req = Database::getInstance()->PDOInstance->prepare("DELETE FROM choice WHERE login=:login");
        $values = [
            ':login' => $this->login
        ];
        return $req->execute( $values );
    }
}
?>
