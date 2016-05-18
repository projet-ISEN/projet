<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 04/05/2016
 * Time: 09:29
 */

namespace Models;

use \API\Database;

/**
 * Class Project
 * @package Models
 */
class Project
{

    public $project_id;
    public $project_type;
    public $project_description;

    /**
     * Project constructor.
     *
     * @param null $project_id
     */
    public function __construct( $project_id = null )
    {
        $this->project_id           = $project_id;
        $this->project_type         = '';
        $this->project_description  = '';
    }

    /**
     * Loader
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

    /**
     * Create a new project
     * @return array
     */
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

    /**
     * Update an existing project
     * @return array
     */
    public function update() {
        //création d'une variable locale _PUT

        $req = Database::getInstance()->PDOInstance->prepare("UPDATE projet SET  project_type = :project_type, project_description = :project_description WHERE project_id = :project_id ");

        $status = true;
        if( !$req->execute( [
                ':project_id' => $this->project_id,
                ':project_type' => $this->project_type,
                ':project_description' => $this->project_description
            ])) {
                $status = false;
            }

        if( $status ) {
            return array( 'err' => null );
        }
        return array( 'err' => 'Impossible de sauvegarder votre choix' );
    }

    /**
     * delete the project
     * @return bool
     */
    public function delete() {

        $req = Database::getInstance()->PDOInstance->prepare("DELETE FROM projet WHERE project_id=:project_id");
        return $req->execute(array('project_id'=> $this->project_id));
    }

    /**
     * Return name of project ID
     * @param $id
     */
    public static function id2Type ($id)
    {
        $res = Database::Select("SELECT project_type FROM projet WHERE project_id='" . $id . "'");
        if( !empty($res) && !empty($res[0]) ){
            return $res[0]->project_type;
        }
        return null;
    }
}
