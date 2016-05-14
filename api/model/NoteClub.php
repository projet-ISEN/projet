<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 09/05/2016
 * Time: 14:23
 */

namespace Models;

use \ReflectionObject;
use \API\Database;

/**
 * Class NoteClub
 * @package Models
 */
class NoteClub
{
    public $club_id;
    public $school_year;
    public $note_club;
    public $procurement_file;
    public $budget;
    public $lock_member_mark;
    public $lock_member_project_validation;

    /**
     * NoteClub constructor.
     *
     * @param null $club_id
     * @param null $school_year
     */
    public function __construct( $club_id='', $school_year=null )
    {
        if( empty($school_year) ) $school_year = $_SESSION['year'];

        $this->club_id                          = $club_id;
        $this->school_year                      = $school_year;
        $this->lock_member_mark                 = 0;
        $this->lock_member_project_validation   = 1;
    }

    /**
     * Load data from a club_id and a year
     */
    public function load()
    {
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM note_club WHERE club_id='" . $this->club_id .
            "' and school_year='". $this->school_year ."'")
            ->fetchAll(\PDO::FETCH_ASSOC);
            // complète le this avec les valeurs récupérées

        if(!empty($res)) {
            foreach ($res[0] as $key => $val) {
                $this->$key = $val;
            }
        }
    }

    /**
     *
     * @return bool
     */
    public function exist()
    {
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM note_club WHERE club_id='" .
            $this->club_id .
            "' AND school_year='" . $this->school_year . "'")
            ->fetchAll(\PDO::FETCH_NUM);
        return !empty($res);
    }

    /**
     * Enregistre les données de l'objet courant en base
     * @return bool
     */
    public function save()
    {
        $values = array();

        // Take back the class attributs
        $props = (new ReflectionObject($this))->getProperties();
        foreach ($props as $prop) {
            $k = $prop->name;
            $values[$prop->name] = $this->$k;
        }

        $values['lock_member_mark']                 = (int) $values['lock_member_mark'];
        $values['lock_member_project_validation']   = (int) $values['lock_member_project_validation'];



        // Creation
        if( !$this->exist() ) {
            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO note_club (club_id, school_year, note_club, procurement_file, budget, lock_member_mark, lock_member_project_validation) ".
                "VALUES (:club_id, :school_year, :note_club, :procurement_file, :budget, :lock_member_mark, :lock_member_project_validation)"
            );
        }
        // Update
        else {
            echo 'update';
            var_dump($values);
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE note_club SET note_club=:note_club, procurement_file=:procurement_file, budget=:budget, lock_member_mark=:lock_member_mark, lock_member_project_validation=:lock_member_project_validation ".
                "WHERE club_id=:club_id AND school_year=:school_year"
            );

        }
        return $req->execute($values);
    }
}
