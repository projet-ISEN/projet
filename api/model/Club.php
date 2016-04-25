<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:15
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Club
 * @package Models
 */
class Club {

    // Equivalent d'une collection JS, plus simple pour les modifier
    public $uid;
    public $login;
    public $club_name;
    public $club_description;
    public $club_mail;
    public $actif;

    public function __construct( $id = null ) {

        $this->uid              = $id;
        $this->login            = '';
        $this->club_name        = '';
        $this->club_description = '';
        $this->club_mail        = '';
        $this->actif            = 1;

    }

    /**
     * Static -> renvoi des tableaux
     * @param null $id
     * @return null
     */
    public static function get( $id=null )
    {
        if(!$id){

            return Database::getInstance()->Select("SELECT id_club, club_name FROM club");
        }
        else {

            return Database::getInstance()->Select(
                "SELECT id_club, club_name, club_description, club_mail, actif, login FROM club " .
                "WHERE id_club='" . $id . "'"
            )[0];
        }
    }

    /**
     * Load data from db with an id
     */
    public function load() {

        // Récupère toutes les infos d'un club pour l'uid du this
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM club WHERE id_club='". $this->uid ."'")
            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }

    }

    public function save() {

        $values = array();

        // Récupère les attributs d'une classe
        $props = (new ReflectionObject($this))->getProperties();
        foreach ($props as $prop) {
            $k = $prop->name;
            $values[$prop->name] = $this->$k;
        }


        // Creation
        if( empty($this->uid) ) {

            // need a new uid
            $values['uid'] = Database::getUID();

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO club (id_club, login, club_name, club_description, club_mail, actif) ".
                "VALUES (:uid, :login, :club_name, :club_description, :club_mail, :actif)"
            );
            if( $req->execute($values) ) {

                $this->uid = $values['uid'];
                print_r( array(
                    'err' => '',
                    'res' => $this->uid));
            }
            else {

            }
        }
        // Mise à jour
        else {
            \API\Database::getInstance()->PDOInstance->prepare();
        }
    }
}
?>