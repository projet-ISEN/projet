<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:26
 */

namespace Controllers;

use \API\Excel;
use Models\NoteClub;
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
     * Return a list of all clubs
     * STATIC
     */
    public static function getAll()
    {
        echo json_encode( \Models\Club::get() );
    }

    /**
     * Return informations of club
     * STATIC
     * @param $id
     */
    public static function getOne( $id_Club )
    {
        $club = new \Models\Club($id_Club);
        $club->load();
        echo json_encode($club);
    }

    /**
     * Get Capisen ID?
     */
    public static function juniorEntrepriseID()
    {
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
     * Create a new Club
     * STATIC
     */
    public static function create()
    {
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
            Logger::info( $_SESSION['user']->login . ' create a club: ' . $post['club_name'] );
        }
        else {
            echo json_encode( array(
                'err' => 'Impossible de d\'enregistrer le nouveau club')
            );
        }
    }

    /**
     * Edit an existing club
     * STATIC
     * @param $id
     */
    public static function update( $id_Club )
    {
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
     * Delete an existing club
     * @param $id
     */
    public static function delete( $id_Club )
    {
        $club = new \Models\Club($id_Club);
        if( $club->delete() ) {
            echo json_encode( array('err' => 'null') );
            Logger::warn( $_SESSION['user']->login . ' delete a club: ' . $club->club_name );
        }
        else {
            echo json_encode( array('err' => "Impossible de supprimer ce club, vérfiez qu'il n'éxiste ".
                'pas de dépendances comme des membres par exemple'));
        }
    }

    /**
     * Return club of evaluator
     */
    public static function ClubsIntelsEvaluator($login = null)
    {
        $club = new \Models\Club();
         echo json_encode ($club -> getMyClubsIntelsEvaluator($login));
    }

    /**
     * Check locks
     * @param $id
     */
    public static function isLock($id)
    {
        $club = new \Models\Club();
         echo json_encode ($club -> isLock($id));
    }

    /**
     * Return members of specific club
     */
    public static function getMembersCurrent($id)
    {
        $club = new \Models\Club();
        $club -> club_id = $id;
        echo json_encode ($club -> getMembers());
    }

    /**
     * Give a mark to club
     */
    public static function giveClubMark(){
        $post = json_decode( file_get_contents("php://input"), true);
        $club = new \Models\Club();
        echo json_encode($club -> giveClubMark($post["club_id"], $post["note"]));
        Logger::info( $_SESSION['user']->login . ' give a mark to club: ' . $post["club_id"] );
    }

    /**
     * Get a club's mark
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
     * Return all procurement file of a club
     * @param $clubId
     */
    public function getAllPassations( $clubId )
    {
        $noteClubs = \Models\NoteClub::getAll( $clubId );
        $passations = [];
        foreach( $noteClubs as $noteClub )
        {
            $noteClub->load();
            if( $noteClub->procurement_file == '1' )
            {
                array_push($passations, [
                    'name' => 'dossier_passation_' . $noteClub->school_year,
                    'year' => $noteClub->school_year
                ]);
            }
        }
        echo json_encode( $passations );
        return;
    }

    /**
     *  Get a procurement file for a club at a year
     * @param $clubId
     * @param $year
     */
    public static function getOnePassation( $clubId, $year )
    {
        $noteClub   = new \Models\NoteClub($clubId, $year);
        $noteClub->load();
        $club       = new \Models\Club( $clubId );
        $club->load();
        $file       = $noteClub->club_id . '&' . $noteClub->school_year; # 16144.2016.pdf
        $path       = realpath(__DIR__ . '../../../uploads/passation/');
        $filePath   = $path . '/' . $file . '.pdf';
        //var_dump($path);
        var_dump($filePath);
        $clubName   = str_replace(' ', '_', $club->club_name);

        if( file_exists( $filePath ) )
        {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=dossier_passation_'.
                $clubName . '_' . $noteClub->school_year .'.pdf' );
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
            header('Pragma: public');
            header('Content-Length: ' . filesize($filePath));
            ob_clean();
            flush();
            readfile($filePath);
            die();
            return;
        }
        else {
            echo json_encode([
                'err' => 'No file'
            ]);
            return;
        }
    }

    /**
     * Add a procurment file for this year
     * @param $clubId
     */
    public static function addPassation( $clubId )
    {
        if( empty($_FILES['file']['tmp_name']) )
        {
            echo json_encode([
                'err' => 'Ou est le fichier?'
            ]);
            return;
        }

        $file       = $_FILES   ['file'];
        $year       = $_SESSION ['year'];
        $path       = realpath(__DIR__ . '../../../uploads/passation/');
        $fileName   = $clubId . '&' . $_SESSION['year'] . '.pdf' ;
        $filePath   = $path . '/' . $fileName;

        /*if( is_uploaded_file($file['tmp_name']) ) {
            echo json_encode([
                'err' => "Le fichier n'a pas réussi à être téléversé"
            ]);
            return;
        }*/

        if( $file["error"] !== UPLOAD_ERR_OK) {
            echo json_encode([
                'err' => "Téléversement interrompu"
            ]);
            return;
        }

        if( filesize($file['tmp_name']) > 30000000 ) // 30Mo
        {
            echo json_encode([
                'err' => "Fichier trop volumineux"
            ]);
            return;
        }
        if( move_uploaded_file($file['tmp_name'], $filePath ) )
        {

            $noteClub = new NoteClub($clubId, $year);
            $noteClub->procurement_file = '1';
            $noteClub->save();

            echo json_encode([
               'err' => null

            ]);
            Logger::info( $_SESSION['user']->login . ' add procurement file' );
            return;
        }
        echo json_encode([
            'err' => "Une erreur c'est produite"
        ]);
        return;

    }

    /**
     * Add a logo for this year
     * @param $clubId
     */
    public static function setLogo( $clubId )
    {
        //var_dump( $_FILES );
        if( empty($_FILES['file']['tmp_name']) )
        {
            echo json_encode([
                'err' => 'Ou est le fichier?'
            ]);
            return;
        }

        if( !$_SESSION['user']->isPresident() )
        {
            echo json_encode([
                'err' => "Vous n'êtes pas autorisé à faire ça"
            ]);
            return;
        }

        $file       = $_FILES   ['file'];
        $path       = realpath(__DIR__ . '../../../public/build/images/');
        $fileName   = $clubId .'.jpg' ;
        $filePath   = $path . '/' . $fileName;

        if( $file["error"] !== UPLOAD_ERR_OK) {
            echo json_encode([
                'err' => "Téléversement interrompu"
            ]);
            return;
        }

        if( filesize($file['tmp_name']) > 10000000 ) // 30Mo
        {
            echo json_encode([
                'err' => "Fichier trop volumineux"
            ]);
            return;
        }
        if( move_uploaded_file($file['tmp_name'], $filePath ) )
        {
            echo json_encode([
                'err' => null
            ]);
            Logger::info( $_SESSION['user']->login . ' set new logo of club '. $clubId );
            return;
        }
        echo json_encode([
            'err' => "Une erreur c'est produite"
        ]);
        return;
    }


    /**
     * Set description of club
     * @param $clubID
     */
    public static function setDescription ($clubID)
    {
        $club = new \Models\Club( $clubID );
        $club->load();

        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put['club']['club_description']) )
        {
            echo json_encode([
                'err' => "Aucune description ?"
            ]);
            return;
        }

        $club->club_description = $put['club']['club_description'];
        if( $club->save() )
        {
            echo json_encode([
                'err' => null
            ]);
            Logger::info( $_SESSION['user']->login . ' change description of club ' . $club->club_name );
            return;
        }
        echo json_encode([
            'err' => "Une erreur est survenue"
        ]);
        return;
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

    /**
     * Create an xls for a year and a club (null = all clubs)
     * @param      $year
     * @param null $club_id
     */
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
