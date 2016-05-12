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


}
