<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:26
 */

namespace Controllers;

use \API\Excel;
use Models\User;

/**
 * Class Club
 * @package Controllers
 */
class Club
{
    /**
     * Club constructor.
     *
     * @param $params
     */
    public function __construct( $params )
    {
        $this->params = $params;
    }

    /**
     * Renvoie la liste tout les clubs
     * STATIC
     */
    public static function getAll() {
        echo json_encode( \Models\Club::get() );
    }

    /**
     * Renvoie les informations d' 1 club
     * STATIC
     * @param $id
     */
    public static function getOne( $id_Club )
    {
        $club = new \Models\Club($id_Club);
        $club->load();
        echo json_encode($club);
    }

    public static function juniorEntrepriseID() {
        echo \Models\Club::juniorEntrepriseID();
    }

    /**
     * Send statistics of a club, with a club_id
     * @param $id_Club
     */
    public static function stat( $id_Club )
    {
        $club = new \Models\Club($id_Club);
        echo json_encode( [
            'members' => $club->numberOfMembers(),
            'details' => $club->memberDetails()
        ]);
        return;
    }

    /**
     * Crée un nouveau club
     * STATIC
     */
    public static function create() {

        $post = json_decode( file_get_contents("php://input"), true);

        // if evaluator or admin
        if( empty($post['club_name']) ) {
            echo json_encode( array('err' => 'Un nom de club est nécéssaire') );
            return;
        }

        $club = new \Models\Club();
        $club->club_name        = $post['club_name'];
        $club->club_description = empty($post['club_description']) ? '' : $post['club_description'];
        $club->club_mail        = empty($post['club_mail'])        ? '' : $post['club_mail'] ;
        $club->login            = empty($post['login_evaluator'])  ? $_SESSION['user']->login : $post['login_evaluator'];
        $club->actif            = 1;

        if( $club->save() ) {
            echo json_encode(['err' => null] );
        }
        else {
            echo json_encode( array(
                'err' => 'Impossible de d\'enregistrer le nouveau club')
            );
        }
    }

    /**
     * Modifie un club existant
     * STATIC
     * @param $id
     */
    public static function update( $id_Club ) {

        $put = json_decode( file_get_contents("php://input"), true);

        if( empty($put['club']) ){
            echo json_encode([
                'err' => 'Il manque des paramètres'
            ]);
            return;
        }

        $club = new \Models\Club($id_Club);
        $club->load();

        // Pour toutes les modifs encoyées
        foreach ($put['club'] as $k => $v) {
            // Si l'attribut existe
            $club->$k = $v;
        }

        if( $club->save() ){
            echo json_encode([
                'err' => null
            ]);
        }
        else {
            echo json_encode([
                'err'=> 'Impossible de modifier ce club'
            ]);
        }
    }

    /**
     * Supprime un club existant
     * @param $id
     */
    public static function delete( $id_Club ) {

        $club = new \Models\Club($id_Club);
        if( $club->delete() ) {
            echo json_encode( array('err' => 'null') );
        }
        else {
            echo json_encode( array('err' => "Impossible de supprimer ce club, vérfiez qu'il n'éxiste ".
                'pas de dépendances comme des membres par exemple'));
        }
    }

    /**
     * Renvoi les clubs qu'un Evaluateur peut administrer
     */
    public static function ClubsIntelsEvaluator($login = null)
    {
        $club = new \Models\Club();
         echo json_encode ($club -> getMyClubsIntelsEvaluator($login));
    }

    public static function isLock($id)
    {
        $club = new \Models\Club();
         echo json_encode ($club -> isLock($id));
    }

    /**
     * Renvoi les clubs qu'un Evaluateur peut administrer
     */
    public static function getMembersCurrent($id)
    {
        $club = new \Models\Club();
        $club -> club_id = $id;
        echo json_encode ($club -> getMembers());
    }

    public static function giveClubMark(){
        $post = json_decode( file_get_contents("php://input"), true);
        $club = new \Models\Club();
        echo json_encode($club -> giveClubMark($post["club_id"], $post["note"]));
    }

    /**
     * Renvoi les clubs qu'un Evaluateur peut administrer
     */
    public static function markClub($id)
    {
        $club = new \Models\Club();
        $club -> club_id = $id;
        echo json_encode ($club -> markClub($id));
    }

    /**
     * Lock the mark of a club (no limitations for Evaluator)
     * @param $id
     */
    public static function lockMark($id)
    {
        echo json_encode ( \Models\Club::lock($id, "lock_member_mark"));
    }

    /**
     * Lock projects validation of a club (no limitations for Evaluator)
     * @param $id
     */
    public static function lockProject($id)
    {
        echo json_encode ( \Models\Club::lock($id, "lock_member_project_validation"));
    }

    /**
     * Unlock the mark of a club
     * @param $id
     */
    public static function unLockMark($id)
    {
        echo json_encode ( \Models\Club::unLock($id, "lock_member_mark"));
    }

    /**
     * Unlock projects validation of a club
     * @param $id
     */
    public static function unLockProject($id)
    {
        echo json_encode ( \Models\Club::unLock($id, "lock_member_project_validation"));
    }

    /**
     * Generate an xls of members of all clubs for a specific year
     * @param $year
     */
    public static function clubMembers2excelWithYear( $year )
    {
        self::generateXls( $year );
    }

    /**
     * genetate an Xls of members of club for this year
     */
    public static function clubMembers2excel()
    {
        self::generateXls( $_SESSION['year'] );
    }

    public static function generateXls( $year, $club_id=null )
    {
        $all = [];
        $clubs = \Models\Club::get( $club_id );

        foreach( $clubs as $club )
        {
            $clubObj = new \Models\Club( $club->club_id );
            $clubObj->load();
            $users = [];
            foreach( $clubObj->getMembers($year) as $member )
            {
                $user = new \Models\User($member->login);
                $user->load();
                $user->project_id = $member->project_id;
                array_push($users, $user);
            }

            $all[ $clubObj->club_name] = $users;

        }
        //var_dump($all);
        $E = new Excel( 'Composition_clubs_' . $_SESSION['year'] );
        $sheet = $E->file->getActiveSheet();

        $sheet->getStyle('A1:AK1')->getFont()->setBold(true);
        //$sheet->getStyle('A1:AK1')->getBorders()->getAllBorders()->setBorderStyle('medium');
        //$sheet->getStyle('A2:AK500')->getBorders()->getAllBorders()->setBorderStyle('thin');
        //$sheet->setAutoFilter('A1:K50');

        $i=0;
        foreach( $all as $k => $clubs )
        {
            $sheet->setCellValueByColumnAndRow($i, 1, $k);
            $j=2;

            foreach ($clubs as $member)
            {
                $projet = \Models\Project::id2Type($member->project_id);
                //var_dump($member->project_id);
                //var_dump( $projet);
                $sheet->setCellValueByColumnAndRow($i,$j, $projet .' '. $member->user_firstname .' '. $member->user_name);
                //$sheet->getCellByColumnAndRow($i, $j)->getStyle()->getBorders()->getAllBorders()->setBorderStyle('thin');
                $j++;
            }
            $i++;
        }
        $sheet->setAutoFilterByColumnAndRow(0, 1, $i - 1, 100);
        for($col = 0; $col < $i; $col++) {
            $sheet->getColumnDimensionByColumn($col)->setAutoSize(true);
        }
        $E->send();
    }
}
