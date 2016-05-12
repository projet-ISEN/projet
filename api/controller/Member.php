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
    public static function clubOfMember( $login ) {
        $clubs = \Models\Member::clubOfMember( $login );
        foreach( $clubs as $club ) {
            $club->load( $clubs );
        }
        echo json_encode( $clubs );
        return;
    }

    public function membersInClub($club_id,$year = null){
        echo json_encode(\Models\Member::membersInClub($club_id,$year));

    }


    public function membersIntelsInClub($club_id,$year = null){
        echo json_encode(\Models\Member::membersIntelsInClub($club_id,$year));

    }
    public static function getMembersOfClub($club_id){
        echo json_encode(\Models\Member::getMembersOfClub($club_id));

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
