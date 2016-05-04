<?php
/**
 * User: Vincent Riouallon
 * Date: 29/04/2016
 * Time: 14:00
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Member
 * @package Models
 */
class Member {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante
    public $login;

    /**
     * Member constructor.
     *
     *
     */
    public function __construct( ) {

        $this->login = $_SESSION['user']->login;

    }


    /**
     * Check if the user is a member
     * @return number
     */
    public function isAMemberOf($year = null, $club_id = null){
            if(!isset($year)) $year =$_SESSION['year'];
            $query = "SELECT count(*) FROM member WHERE login='".$this->login ."' AND school_year='".$year."' ORDER BY main_club";

            if(isset($club)){
                $query .= "AND club_id = '".$club_id."'";
            }

            $res = Database::getInstance()->PDOInstance->query($query);
            return $res->fetchAll(\PDO::FETCH_NUM)[0][0];
    }





    /**
     * Return the list of clubs of the member
     * @return array
     */
    public function ClubMembers($year = null){

        if(!isset($year)) $year =$_SESSION['year'];
        return Database::Select("SELECT club.club_name, club.club_id FROM club INNER JOIN member ON member.club_id = club.club_id WHERE member.login = '". $this->login."' AND school_year = '". $year."'");
    }


    public static function membersInClub($club_id,$year = null){

        if(!isset($year)) $year =$_SESSION['year'];
        return Database::Select("SELECT login FROM member WHERE club_id='".$club_id."' AND school_year = '". $year."'");
    }

    public static function membersIntelsInClub($club_id,$year = null){

       /* $user = new User();*/
        $intels = [];

        $list = self::membersInClub($club_id,$year = null);

        foreach($list as $value){
            array_push($intels, user::Info($value->login));
        }

        return $intels;


    }



}
?>
