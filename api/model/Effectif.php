<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 03/05/2016
 * Time: 16:34
 */

namespace Models;

use \API\Database;

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
    }

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

}