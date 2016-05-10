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
    public $club_id;
    public $login;
    public $school_year;
    public $project_id;
    public $id_projet_club;
    public $main_club;
    public $member_mark;
    public $ex_member_not_wanted;
    public $recommandation;
    public $project_validation;
    public $member_comment;

    /**
     * Member constructor.
     *
     *
     */
    public function __construct( $club_id='', $login=null, $year=null)
    {
        if( empty($year) ) $year = $_SESSION['year'];

        $this->login        = empty($login)? $_SESSION['user']->login : $login;
        $this->club_id      = $club_id;
        $this->school_year  = $year;
    }

    /**
     * Check if the user is a member
     * @return number
     */
    public function isAMemberOf($year = null, $club_id = null)
    {
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

    /**
     * Is this member is in the club?
     * @param      $club_id
     * @param null $year
     *
     * @return null
     */
    public static function membersInClub($club_id,$year = null){

        if(!isset($year)) $year =$_SESSION['year'];
        return Database::Select("SELECT login FROM member WHERE club_id='".$club_id."' AND school_year = '". $year."'");
    }

    /**
     * Return intels of member in a club
     * @param      $club_id
     * @param null $year
     *
     * @return array
     */
    public static function membersIntelsInClub($club_id,$year = null){
        if(!isset($year)) $year =$_SESSION['year'];
       /* $user = new User();*/
        $intels = [];

        $list = self::membersInClub($club_id,$year);

        foreach($list as $value){
            $info = user::Info($value->login);
            $role = role::whichRoleID($year,$club_id,$value->login);
            //var_dump(empty($role));

            //var_dump($info);

            $info[0] ->roles = [];


            if(!empty($role)){
                foreach($role as $value) {
                    array_push($info[0] -> roles, role::ID2Role($value -> id_role));
                }
            }
            //var_dump($info);
            //var_dump(gettype($info["roles"]));

            //$info = array_merge($info, $role);
            $intels = array_merge($intels, $info);
        }
        return $intels;
    }

    /**
     * Charge toutes les données d'un membre portant le login de l'objet courant
     */
    public function load() {

        if( empty($this->login) || empty($this->club_id) )
        {
            return [
                "err" => "Sans login et club serieux?"
            ];
        }

        // Récupère toutes les infos d'un club pour l'uid du this
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM member WHERE club_id='". $this->club_id .
            "' AND login='" . $this->login . "' AND school_year='" . $this->school_year . "'")
            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }

    }
}
?>
