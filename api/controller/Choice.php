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
     * Renvoi la liste des choix de l'utilisateur connécté
     * sous forme de JSON
     * @param null $id
     */
    public static function get( $id=null ) {

        if( $id ) {

            $req = Database::Select("SELECT * FROM choice WHERE login='" .
                $_SESSION['user']->login . "' AND choice_number=" . $id
            );
        }
        else {

            $req = Database::Select("SELECT * FROM choice WHERE login='" .
                $_SESSION['user']->login . "'"
            );
        }
        echo json_encode($req);
    }

    /**
     * Ajoute les 3 choix de la personne postulante dans une club dans la base de donnée
     */
    public static function create() {

        $req = Database::getInstance()->PDOInstance->query("SELECT count(*) FROM choice WHERE login='" . $_SESSION['user']->login . "'");
        $res = $req->fetchAll();

        if( $res[0][0] >0 ){ // Il y a déja des choix
            echo json_encode(array('err' => 'il existe déja des choix, vous ne pouvez que les modifier'));
            return;
        }
        else {
            $choices = json_decode( $_POST['choices'], true );

            // Check les tricheurs
            if( count($choices) > 3 )
            {
                echo json_encode(array( 'err' => 'Pas plus de 3 choix possibles, ' . count($choices) . ' envoyés' ));
                return;
            }
            if( $choices[0] == $choices[1] OR $choices[1] == $choices[2] OR $choices[0] == $choices[2] )
            {
                echo json_encode(array( 'err' => 'Petit voyous....' ));
                return;
            }


            $req = Database::getInstance()->PDOInstance->prepare("INSERT INTO choice (login, club_id, choice_number) ".
            "VALUES (:login, :club_id, :choice_number)");

            $status = true;

            foreach( $choices as $number => $club ) {
                if( !$req->execute( array(
                    ':login' => $_SESSION['user']->login,
                    ':club_id' => $club,
                    'choice_number' => $number
                ))) {
                    $status = false;
                }
            }

            if($status) {
                echo json_encode(array( 'err' => 'null' ));
            }
            else {
                echo json_encode(array( 'err' => 'Impossible de sauvegarder vos choix' ));
            }
        }
    }

    /**
     * Permet de changer un choix de l'utilisateur connécté
     * @param $id
     */
    public static function update( $id ) {

        parse_str(file_get_contents("php://input"),$_PUT);

        $req = Database::getInstance()->PDOInstance->prepare("UPDATE choice SET club_id=:club WHERE login=:login " .
            "AND choice_number=:number");
        if( $req->execute(array(
            ':club' => $_PUT['club'],
            ':login' => $_SESSION['user']->login,
            ':number' => $id
        )) ) {
            echo json_encode(array( 'err' => 'null' ));
            return;
        }
        echo json_encode(array( 'err' => 'Impossible de sauvegarder votre choix' ));
    }
}