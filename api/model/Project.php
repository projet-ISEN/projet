<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 04/05/2016
 * Time: 09:29
 */

namespace Models;

use \API\Database;

class Project
{
    public $project_id;
    public $project_type;
    public $project_description;

    public function __construct( $project_id = null )
    {
        $this->project_id           = $project_id;
        $this->project_type         = '';
        $this->project_description  = '';
    }

    /**
     * Charge toutes les données du projet portant l'ID de l'objet courant
     */
    public function load() {

        if( $this->project_id ) {

            // Récupère toutes les infos d'un club pour l'uid du this
            $res = Database::getInstance()->PDOInstance->query("SELECT * FROM projet WHERE project_id='". $this->project_id ."'")
                ->fetchAll( \PDO::FETCH_ASSOC )[0];

            // complète le this avec les valeurs récupérées
            foreach( $res as $key => $val ) {
                $this->$key = $val;
            }
        }
        else {
            return  Database::Select("SELECT * FROM projet");
        }
    }
}