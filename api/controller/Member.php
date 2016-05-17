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
        if( !$user->exist() ){

            echo json_encode([
                'err' => "Cet utilisateur n'existe pas."
            ]);
            return;
        }

        $put = json_decode( file_get_contents("php://input"), true);
        if( empty( $put['club_id'] ) ) {  //empty( $put['project_id']) need to push without project

            return json_encode([
                'err' => 'Dans quel club doit on mettre cet user?'
            ]);
        }

        $member                 = new \Models\Member($put['club_id'], $user_login, $year );
        $member->project_id     = $put['project_id'];
        $member->main_club      = $main_club;

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
    public static function ClubMembers($year = null)
    {
        echo json_encode(\Models\Member::ClubMembers($year));
    }

    /**
     * Return all members object of an user
     * @param $login
     */
    public static function get( $login, $year )
    {

        $members = \Models\Member::clubOfMember( $login );
        foreach( $members as $member ) {
            $member->load();
        }
        echo json_encode( $members );
        return;
    }

    /**
     * Return all members object of an user at a specific year
     * @param $login
     */
    public static function getWithYear( $login, $year )
    {

        $members = \Models\Member::clubOfMemberAtYear( $login, $year );
        foreach( $members as $member ) {
            $member->load();
        }
        echo json_encode( $members );
        return;
    }

    /**
     * Delete a member in a club
     * @param $login
     */
    public static function delete( $login, $year=null )
    {
        if( empty($year) ) $year = $_SESSION['year'];

        $delete = json_decode( file_get_contents("php://input"), true);
        if( empty($delete['club_id']) ) {
            echo json_encode([
                'err' => "il manque quelque chose...."
            ]);
            return;
        }
        $tmp = new \Models\Member($delete['club_id'], $login, $year);
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


    public function membersIntelsInClub($club_id,$year = null)
    {
        echo json_encode(\Models\Member::membersIntelsInClub($club_id,$year));
    }

    /**
     * Return all members of a club
     * @param $club_id
     */
    public static function getMembersOfClub($club_id)
    {
        $tmp = \Models\Member::getMembersOfClub($club_id);
        //var_dump($tmp);
        echo json_encode($tmp);
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


    public static function noteStudent()
    {
        $post = json_decode( file_get_contents("php://input"), true);
        $id =  ($post["member"][0]['club_id']);

        $noteClub = \Models\Club::markClub($id)-> note_club;

        //var_dump($noteClub); // 20
        $tempPR = true;
        //var_dump($post["member"]);
        $total_member = 0;
        $count_member = 0;
        foreach ($post["member"] as $value)
        {
            if( $value['project'] != 'PR+' )
            {
                $total_member += $value['member_mark'];
                $count_member++;
                if ($value["project"] == "PR")
                {
                    if ($value["project_validation"])
                        if ($value["member_mark"] < 10) $tempPR = false;
                        else {
                            if ($value["member_mark"] >= 10) $tempPR = false;
                        }
                }
            }
        }
        $total = $noteClub * $count_member;

        $lockmark = \Models\Club::isLock($id);
        $lockmark = $lockmark['lock_member_mark'];

        //var_dump($total_member == $total && !$lockmark);

        if($total_member == $total && $lockmark && $tempPR){
            $i = 0;
            foreach ($post["member"] as $value){
                $i += intval(\Models\Member::noteStudent($value),10);
            }
            if(count($post["member"]) == $i)
                echo 1;
            else echo 0;
         } else echo 0;
    }
      //callback a list with the the people who asked Capisen in first choice

    /**
     * Ajout des membres pour CAPISEN l'&année pro
     */
    public static function juniorCandidate()
    {
        echo json_encode(\Models\Member::juniorCandidate( ));
        //echo json_encode( $members );
        //var_dump($idJunior);
    }

    public static function getMemberAndIntels($club_id, $year){
         //echo json_encode(\Models\Member::getMembersOfClub($club_id, $year));
         $members = \Models\Member::getMembersOfClub($club_id, $year);
         //var_dump($members);
         foreach( $members as $value ) {
             $user = new \Models\User( $value->login );
             $user->load();
             $value -> user_firstname = $user -> user_firstname;
             $value -> user_name = $user -> user_name;

             $value -> phone = $user -> phone;
             $value -> user_mail = $user -> user_mail;
             //var_dump($user);
         }
         echo json_encode($members);

     }


    public static function juniorMember($year){
        echo \Models\Member::juniorMember($year);
     }



    public static function projectValidationStudent()
    {
        $post = json_decode( file_get_contents("php://input"), true);
        if( empty($post['member']) || empty( $post['member'][0] ) ) return 0;

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

        if( ($locks['lock_member_project_validation']  && $is_pres ) || $_SESSION['user']->isEvaluator() )
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

    /**
     * Retourne la liste des membres recommandées par un club
     * @param $club_id
     */
    public static function recommended ($club_id)
    {
        if( in_array($club_id, [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']]) ){
            echo json_encode([
                'err' => 'Non autorisé'
            ]);
            return;
        }

        $res = \Models\Member::getMembersOfClub($club_id, $_SESSION['year'] + 1 );
        echo json_encode($res);
        return;
    }

    /**
     * Recommand a member for next year for a club
     * @param $login
     */
    public static function recommend( $login )
    {
        $post = json_decode( file_get_contents("php://input"), true);

        if( empty($post['club_id']) )
        {
            echo json_encode([
                'err' => 'Il manque quelque chose'
            ]);
            return;
        }

        if( in_array($post['club_id'], [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']]) ){
            echo json_encode([
                'right' => false
            ]);
            return;
        }

        $clubId = $post['club_id'];
        $member = new \Models\Member($clubId, $login, $_SESSION['year'] + 1);
        $member->recommandation = '1';
        $member->project_validation = '0';

        if( $member->save() ) {
            echo json_encode([
                'err' => null
            ]);
            return;
        }
        echo json_encode([
            'err' => "Une erreur c'est produite"
        ]);
        return;
    }

    /**
     * Unrecommand a member for next year for a club
     * @param $login
     */
    public static function unRecommend( $login )
    {
        $put = json_decode( file_get_contents("php://input"), true);

        if( empty($put['club_id']) )
        {
            echo json_encode([
                'err' => 'Il manque quelque chose'
            ]);
            return;
        }

        if( in_array($put['club_id'], [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']]) ){
            echo json_encode([
                'right' => false
            ]);
            return;
        }

        $clubId = $put['club_id'];
        $member = new \Models\Member($clubId, $login, $_SESSION['year'] + 1);
        $member->recommandation = '0';
        $member->project_validation = '0';

        if( $member->save() ) {
            echo json_encode([
                'err' => null
            ]);
            return;
        }
        echo json_encode([
            'err' => "Une erreur c'est produite"
        ]);
        return;
    }

    /**
     * Say a member is not wanted for a club, next year
     * @param $login
     */
    public static function disgrace( $login )
    {
        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put['club_id']) )
        {
            echo json_encode([
                'err' => 'Il manque quelque chose'
            ]);
            return;
        }

        if( in_array($put['club_id'], [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']]) ){
            echo json_encode([
                'right' => false
            ]);
            return;
        }

        $clubId = $put['club_id'];
        $member = new \Models\Member($clubId, $login, $_SESSION['year'] + 1);
        $member->recommandation = '0';
        $member->ex_member_not_wanted = '1';

        if( $member->save() ) {
            echo json_encode([
                'err' => null
            ]);
            return;
        }
        echo json_encode([
            'err' => "Une erreur c'est produite"
        ]);
        return;
    }

    /**
     * * Say a member finally not not wanted for a club, next year
     * @param $login
     */
    public static function unDisgrace( $login )
    {
        $put = json_decode( file_get_contents("php://input"), true);
        if( empty($put['club_id']) )
        {
            echo json_encode([
                'err' => 'Il manque quelque chose'
            ]);
            return;
        }

        if( in_array($put['club_id'], [$_SESSION['Capisenid'], $_SESSION['BDEid'], $_SESSION['BDSid']]) ){
            echo json_encode([
                'right' => false
            ]);
            return;
        }

        $clubId = $put['club_id'];
        $member = new \Models\Member($clubId, $login, $_SESSION['year'] + 1);
        $member->recommandation = '0';
        $member->ex_member_not_wanted = '0';

        if( $member->save() ) {
            echo json_encode([
                'err' => null
            ]);
            return;
        }
        echo json_encode([
            'err' => "Une erreur c'est produite"
        ]);
        return;
    }
}
