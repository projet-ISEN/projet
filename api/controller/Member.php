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
    public function ClubMembers($year = null){
        echo json_encode(\Models\Menu::ClubMembers($year));

    }


}