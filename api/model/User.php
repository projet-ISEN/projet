<?php

namespace Models;
use API\Database;
use \ReflectionObject;

/**
 * Class User
 * @package Models
 */
class User {

    public $login;
    public $user_firstname;
    public $user_name;
    public $user_mail;
    public $is_administrator;
    public $phone;

    /**
     * User constructor.
     *
     * @param $cas_data
     */
    public function __construct( $cas_data ) {

        // Champs de la base de donnée
        $this->login            = $cas_data['Login'];
        $this->user_firstname   = $cas_data['FirstName'];
        $this->user_name        = $cas_data['LastName'];
        $this->user_mail        = $cas_data['Mail'];
        $this->is_administrator    = ($cas_data['gidNumber'] = 0;//TODO... ???
        $this->phone            = $cas_data['Telephone'];

    }

    /**
     * Es ce que l'utilisateur existe dans la base?
     * @return bool
     */
    public function exist() {
        $res = Database::getInstance()->PDOInstance->query("SELECT login FROM users WHERE login='" . $this->login . "'")
            ->fetchAll(\PDO::FETCH_NUM);
        return !empty($res);
    }

    public function load() {

        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM users WHERE login='" . $this->login . "'" )
            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }
    }

    /**
     * Sauvegarde toutes les modifications de l'USER dans la base de donnée
     * Le crée s'il n'y est pas encore
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
        if( !$this->exist() ) {

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO users (login, user_firstname, user_name, user_mail, is_administrator, phone) ".
                "VALUES (:login, :user_firstname, :user_name, :user_mail, :is_administrator, :phone)"
            );

            return $req->execute($values);
        }
        // Mise à jour
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE users SET user_firstname=:user_firstname, user_name=:user_name, ".
                "user_mail=:user_mail, is_administrator=:is_administrator, phone=:phone WHERE login=:login"
            );
            return $req->execute($values);
        }
    }

}
