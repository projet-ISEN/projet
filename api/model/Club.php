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
    // Tout les attributs doivent correspondre à la table correspondante
    public $club_id;
    public $login;
    public $club_name;
    public $club_description;
    public $club_mail;
    public $blocknote;
    public $actif;

    /**
     * Club constructor.
     *
     * @param null $id
     */
    public function __construct( $id = null ) {

        $this->club_id          = $id;
        $this->login            = '';
        $this->club_name        = '';
        $this->club_description = '';
        $this->club_mail        = '';
        $this->blocknote        = '';
        $this->actif            = 1 ;
    }

    /**
     * Renvoi les informations de tout les clubs
     * Ou d'un club si un ID est spécifié
     * @param null $id
     * @return null
     */
    public static function get( $id=null )
    {
        if(!$id){
            return Database::getInstance()->Select("SELECT club_id, club_name FROM club");
        }
        else {
            return Database::getInstance()->Select(
                "SELECT club_id, club_name, club_description, club_mail, actif, login FROM club " .
                "WHERE club_id='" . $id . "'"
            )[0];
        }
    }

    /**
     * Charge toutes les données du club portant l'ID de l'objet courant
     */
    public function load() {

        // Récupère toutes les infos d'un club pour l'uid du this
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM club WHERE club_id='". $this->club_id ."'")
            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }

    }

    /**
     * Fait un UPDATE ou un INSERT en fonction du numero de club pour sauvegarder les modifications d'un club
     * @return bool
     */
    public function save() {

        $values = array();

        // Récupère les attributs de classe
        $props = (new ReflectionObject($this))->getProperties();
        foreach ($props as $prop) {
            $k = $prop->name;
            $values[$prop->name] = $this->$k;
        }

        // Creation
        if( empty($this->club_id) ) {

            // need a new uid
            $values['club_id'] = Database::getUID();

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO club (club_id, login, club_name, club_description, club_mail, actif, blocknote) ".
                "VALUES (:club_id, :login, :club_name, :club_description, :club_mail, :actif, :blocknote)"
            );

            if( $req->execute($values) ){
                $this->club_id = $values['club_id'];
                return true;
            }
            return false;

        }
        // Mise à jour
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE club SET login=:login, club_name=:club_name, club_description=:club_description, ".
                "club_mail=:club_mail, actif=:actif, blocknote=:blocknote WHERE club_id=:club_id"
            );
            return $req->execute($values);
        }
    }

    /**
     * Supprime le club de l'objet courant dans la base de donnée
     * /!\ Possible uniquement s'il n'a plus aucun membre
     * @return bool
     */
    public function delete() {

        $req = Database::getInstance()->PDOInstance->prepare("DELETE FROM club WHERE club_id=:club_id");
        return $req->execute(array('club_id'=> $this->club_id));
    }
}
?>