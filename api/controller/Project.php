<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 04/05/2016
 * Time: 09:23
 */

namespace Controllers;

/**
 * Gère les type de projets (PA PI PR)
 * Class Project
 * @package Controllers
 */
class Project
{

    /**
     * Send back a project if we specify an id
     * @param $project_id
     */
    public function getOne( $project_id )
    {
        $project = new \Models\Project( $project_id );
        $project->load();
        echo json_encode($project);
        return;
    }

    public function getAll()
    {
        $projects = new \Models\Project();
        echo json_encode( $projects->load() );
        return;
    }
}
