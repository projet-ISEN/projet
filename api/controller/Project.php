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

    public function create()
    {
        $post = json_decode( file_get_contents("php://input"), true);

        $projects = new \Models\Project();

        $projects->project_type         = $post['project_type'];
        $projects->project_description  = $post['project_description'] ;
        echo json_encode( $projects -> create() );
    }

    public static function update() {

        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put) ) {

            echo json_encode([
                'err' => 'Aucune données reçues'
            ]);
        }
        else {
            $projects = new \Models\Project();
            $projects->project_id           = $put['project_id'];
            $projects->project_type         = $put['project_type'];
            $projects->project_description  = $put['project_description'] ;
            echo json_encode( $projects->update() );
        }
    }

}
