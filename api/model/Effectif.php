<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 03/05/2016
 * Time: 16:34
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Effectif
 * @package Models
 */
class Effectif
{
    public $club_id;
    public $project_id;
    public $nb_asked_min;
    public $nb_asked_max;

    /**
     * Effectif constructor.
     *
     * @param null $id_club
     * @param null $id_project
     */
    public function __construct( $id_club = null, $id_project = null )
    {
        $this->club_id      = $id_club;
        $this->project_id   = $id_project;
        $this->nb_asked_min = 0;
        $this->nb_asked_max = 0;
    }

    /**
     * Return all effectifs
     * Sinon renvoi tout les effectifs de ce club
     * @return null
     */
    public function get() {

        if( $this->club_id == null ) {
            return Database::Select("SELECT * FROM effectif WHERE nb_asked_max IS NOT NULL");
        }
        else {
            return Database::Select(
                "SELECT * FROM effectif ".
                "WHERE nb_asked_max IS NOT NULL AND club_id='".
                $this->club_id . "'"
            );
        }
    }

    /**
     * Loader
     */
    public function load()
    {
        $res = Database::Select("SELECT * FROM effectif WHERE club_id ='". $this->club_id
            ."' and project_id='". $this->project_id ."'")

            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }
    }

    /**
     * Save, do insert or update if exist
     * @return array|bool
     */
    public function save()
    {

        if( empty($this->club_id) || empty($this->project_id) )
        {
            return [
                'err' => 'Que voulez vous sauvegarder?'
            ];
        }

        $values = array();

        // Récupère les attributs de classe
        $props = (new ReflectionObject($this))->getProperties();
        foreach ($props as $prop)
        {
            $k = $prop->name;
            $values[$prop->name] = $this->$k;
        }

        $test = Database::Select("SELECT club_id FROM effectif WHERE club_id='". $this->club_id .
            "' AND project_id='". $this->project_id ."'"
        );

        // Création
        if( empty($test[0]->club_id) ){

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO effectif (club_id, project_id, nb_asked_min, nb_asked_max) ".
                "VALUES ( :club_id, :project_id, :nb_asked_min, :nb_asked_max )"
            );

        }
        // Mise à jour
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE effectif SET nb_asked_max=:nb_asked_max, nb_asked_min=:nb_asked_min ".
                "WHERE club_id=:club_id AND project_id=:project_id"
            );
        }
        return $req->execute($values);
    }

    /**
     * Delete all effectifs
     */
    public static function deleteAll() {
        $req = Database::getInstance()->PDOInstance->exec("Delete from effectif");
        if( $req ) return array( 'err' => null );
        else return array( 'err' => "An error occurred" );
    }
}
