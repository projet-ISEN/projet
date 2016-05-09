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

    public function create() {

            $this->project_id = Database::getUID();
            $values['project_id'] = $this->project_id;
            $values['project_type'] = $this->project_type;
            $values['project_description'] = $this->project_description;

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO `projet`(`project_id`, `project_type`, `project_description`)"
                ."VALUES (:project_id, :project_type, :project_description)"
            );


            if( $req->execute($values) ) {
                return ['err' => null];
            }
            else {
                return ['err' => 'Impossible de d\'enregistrer le nouveau club'];
            }
    }


}
