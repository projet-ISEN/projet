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
    public static function setActive( $login ) {

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
            $member->save();
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

        $total = $noteClub * count($post["member"]);
        $total_member = 0;
        foreach ($post["member"] as $value){
            $total_member += $value['member_mark'];
        }

        $lockmark = \Controllers\Club::lockMark($id);


        if($total_member == $total && !$lockmark){

            $i = 0;
            foreach ($post["member"] as $value){
                $i += intval(\Models\Member::noteStudent($value),10);
            }

            if(count($post["member"]) == $i)
                echo 1;
            else echo 0;
         } else echo 0;

    }

    public static function projectValidationStudent(){

        $post = json_decode( file_get_contents("php://input"), true);
        $id =  ($post["member"][0]['club_id']);

        $lockproject = \Controllers\Club::lockProject($id);

        if(!$lockproject || $_SESSION["user"]->isEvaluator){

            $i = 0;
            foreach ($post["member"] as $value){
                $i += intval(\Models\Member::projectValidationStudent($value),10);
            }

            if(count($post["member"]) == $i)
                echo 1;
            else echo 0;
         } else echo 0;

    }


}
