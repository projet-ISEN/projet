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

        // Database fields
        $this->login            = $cas_data['Login'];
        $this->user_firstname   = $cas_data['FirstName'];
        $this->user_name        = $cas_data['LastName'];
        $this->user_mail        = $cas_data['Mail'];
        $this->is_administrator = 0;//TODO... ???
        $this->phone            = $cas_data['Telephone'];

    }

    /**
     * the user exist in database or not
     * @return bool
     */
    public function exist() {
        $res = Database::getInstance()->PDOInstance->query("SELECT login FROM users WHERE login='" . $this->login . "'")
            ->fetchAll(\PDO::FETCH_NUM);
        return !empty($res);
    }


    /**
     * The user return if he is an evaluator
     *and only of an active club (this mean his evaluator this year)
     * @return bool
     */
    public function isEvaluator() {
        $res = Database::getInstance()->PDOInstance->query("SELECT count(*) FROM club WHERE login='" . $this->login . "' AND actif = 1 ")
            ->fetchAll(\PDO::FETCH_NUM)[0][0];
        return ($res >= 1);
    }


    public static function Info($login) {

        return Database::Select("SELECT * FROM users WHERE login='" .$login . "'" );

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
     * Save all the modifications of the USER in the database
     * If not it create it
     * @return bool
     */
    public function save() {

        $values = array();

        // Take back the class attributs
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
        // Update
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE users SET user_firstname=:user_firstname, user_name=:user_name, ".
                "user_mail=:user_mail, is_administrator=:is_administrator, phone=:phone WHERE login=:login"
            );
            return $req->execute($values);
        }
    }

}
