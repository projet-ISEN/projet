<?php
/**
 * User: vincent riouallon
 * Date: 29/04/2016
 * Time: 14:30
 */

namespace Controllers;

use API\Database;

/**
 * Class Member
 * @package Controllers
 */
class Member
{

    /**
     * Member constructor.
     *
     * @param $params
     */
    public function __construct( $params )
    {
        $this->params = $params;
    }

    /**
     * Ajoute un membre avec le login, annee, et club par default
     * @param      $user_login
     * @param null $year
     * @param int  $main_club
     */
    public static function addClub( $user_login, $main_club=0, $year=null )
    {
        if( empty($year) ) $year = $_SESSION['year'];

        $user = new \Models\User($user_login);
        if( !$user->exist() )
        {
            return json_encode([
                'err' => "Cet utilisateur n'éxiste pas."
            ]);
        }

        $put = json_decode( file_get_contents("php://input"), true);
        if( empty( $put['club_id'] ) || empty( $put['project_id'] ) ) {
            return json_encode([
                'err' => 'Dans quel club doit on mettre cet user?'
            ]);
        }

        $member = new \Models\Member($put['club_id'], $user_login, $year );
        $member->project_id = $put['project_id'];
        $member->main_club = $main_club;

        if( $member->save() )
        {
            echo json_encode([
                'err' => null
            ]);
        }
        else{
            echo json_encode([
                'err' => 'Impossible de mettre ce menbre dans ce club'
            ]);
        }
        return;
    }


    /**
     *returns the number of clubs which the member belongs
     */
    public function isAMemberOf($year = null , $club = null) {

         echo json_encode(\Models\Member::isAMember($year,$club));
    }


    /**
     * Return the list of the club of the member
     * @return array
     */
    public static function ClubMembers($year = null){
        echo json_encode(\Models\Member::ClubMembers($year));

    }

    /**
     * Return all members object of an user
     * @param $login
     */
    public static function get( $login ) {

        $members = \Models\Member::clubOfMember( $login );
        foreach( $members as $member ) {
            $member->load();
        }
        echo json_encode( $members );
        return;
    }

    public static function delete( $login )
    {
        $delete = json_decode( file_get_contents("php://input"), true);
        if( empty($delete['club_id']) ) {
            echo json_encode([
                'err' => "il manque quelque chose...."
            ]);
            return;
        }
        $tmp = new \Models\Member($delete['club_id'], $login);
        if( $tmp->delete() ) {
            echo json_encode([
                'err' => "Membre du club supprimé"
            ]);
        }
        else {
            echo json_encode([
                'err' => "Quelque chose c'est mal passé pendant la suppression"
            ]);
        }
        return;
    }

    /**
     * Return login of user in the club
     * @param      $club_id
     * @param null $year
     */
    public function membersInClub( $club_id, $year = null )
    {
        echo json_encode(\Models\Member::membersInClub($club_id,$year));
    }


    public function membersIntelsInClub($club_id,$year = null){
        echo json_encode(\Models\Member::membersIntelsInClub($club_id,$year));

    }
    public static function getMembersOfClub($club_id){
        echo json_encode(\Models\Member::getMembersOfClub($club_id));

    }

    /**
     * Put the main_club field to 1 for this member
     * @return mixed
     */
    public static function setMain( $login ) {

        $put = json_decode( file_get_contents("php://input"), true);

        if( empty($put['club_id']) ){
            echo json_encode([
                'err' => 'il manque l id de club'
            ]);
            return;
        }
        $members = \Models\Member::clubOfMember( $login );
        foreach( $members as $member ) {
            $member->load();
            if( $member->club_id == $put['club_id'] ) {
                $member->main_club = '1';
            }
            else {
                $member->main_club = '0';
            }
            if(!$member->save() ) {
                echo json_encode([
                    'err' => "Quelque chose c'est mal passé pendant la mise à jour"
                ]);
                return;
            }
        }

        echo json_encode([
            'err' => null
        ]);
        return;
    }


    public static function noteStudent(){

        $post = json_decode( file_get_contents("php://input"), true);
        $id =  ($post["member"][0]['club_id']);

        $noteClub = \Models\Club::markClub($id)-> note_club;

        //var_dump($noteClub);
        $tempPR = true;
        //var_dump($post["member"]);
        $total = $noteClub * count($post["member"]);
        $total_member = 0;
        foreach ($post["member"] as $value){
            $total_member += $value['member_mark'];
            if($value["project"] == "PR"){
                if($value["project_validation"])
                    if($value["member_mark"] < 10) $tempPR = false;
                else{
                    if($value["member_mark"] >= 10) $tempPR = false;
                }
            }
        }

        $lockmark = \Controllers\Club::lockMark($id);


        if($total_member == $total && !$lockmark && $tempPR){

            $i = 0;
            foreach ($post["member"] as $value){
                $i += intval(\Models\Member::noteStudent($value),10);
            }

            if(count($post["member"]) == $i)
                echo 1;
            else echo 0;
         } else echo 0;

    }

    public static function projectValidationStudent()
    {
        $post = json_decode( file_get_contents("php://input"), true);
        $id =  ($post["member"][0]['club_id']);
        
        $club   = new \Models\Club();
        $locks  = $club -> isLock($id);


        $role       = \Models\Role::whichRoleID( $_SESSION['year'], $id, $_SESSION['user']->login );
        if( empty($role[0]->id_role) ) {
            $is_pres = false;
        }
        else {
            $is_pres = \Models\Role::ID2Role( $role[0]->id_role ) == $_SESSION['president'];

        }

        var_dump($locks['lock_member_project_validation']);
        var_dump($_SESSION['user']->isEvaluator());
        if( (!$locks['lock_member_project_validation']  && $is_pres ) || $_SESSION['user']->isEvaluator() )
        {
            $i = 0;
            foreach ($post["member"] as $value){
                $i += intval(\Models\Member::projectValidationStudent($value),10);
            }

            if(count($post["member"]) == $i) echo 1;
            else echo 0;
         }
         else echo 0;
    }
}
