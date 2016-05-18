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
        $this->main_club    = 1;
        $this->project_validation = 1;
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
    public function ClubMembers($year = null)
    {
        if(!isset($year)) $year =$_SESSION['year'];
        return Database::Select("SELECT club.club_name, club.club_id FROM club INNER JOIN member ON member.club_id = club.club_id WHERE member.login = '". $this->login."' AND school_year = '". $year."'");
    }

    /**
     * Return list all member of user, in obj
     * @param $login
     */
    public static function clubOfMember( $login ){
        $members = [];
        $req = Database::Select("SELECT club_id, login FROM member WHERE login='". $login ."'");
        foreach( $req as $member) {
            array_push( $members, new self($member->club_id, $member->login) );
        }
        return $members;
    }

    /**
     * Return list all member of user, in obj
     * @param $login
     */
    public static function clubOfMemberAtYear( $login, $year ){
        $members = [];
        $req = Database::Select(
            "SELECT club_id, login FROM member WHERE login='". $login ."' AND school_year='" . $year . "'"
        );
        foreach( $req as $member) {
            array_push( $members, new self($member->club_id, $member->login) );
        }
        return $members;
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
     * Renvoi un tableau d'objet Member appartenant au club avec seulement login et clubId
     */
    public static function getMembersOfClub($club_id, $year = null)
    {
        if(empty($year)) $year = $_SESSION['year'];
        $req = Database::Select("SELECT * FROM member WHERE club_id='" . $club_id . "' AND school_year='".$year."'");
        //var_dump($req);
        return $req;
    }

    /**
     * Give a note to student
     */
    public static function noteStudent($member)
    {
        $year =$_SESSION['year'];

        $preMark = Database::Select("SELECT member_mark FROM member WHERE club_id='" . $member['club_id'] . "' AND school_year='".$year."' AND login='".$member['login']."'");

        if(isset($preMark[0]))$preMark = $preMark[0]->member_mark;
        else $preMark = "";
        //var_dump($member['member_mark'] != $preMark);

        if($member['member_mark'] != $preMark){
            $req = Database::getInstance()->PDOInstance->exec("UPDATE member SET member_mark='".$member['member_mark']."' WHERE club_id = '".$member['club_id']."' AND school_year='".$year."' AND login='".$member['login']."'");
            return $req;
        }
        else return 1;

    }

    /**
     * Valid or not a project
     */
    public static function projectValidationStudent($member)
    {
        $year =$_SESSION['year'];

        $prevalidProject = Database::Select("SELECT project_validation FROM member WHERE club_id='" . $member['club_id'] . "' AND school_year='".$year."' AND login='".$member['login']."'");
        if(isset($prevalidProject[0]))$prevalidProject = $prevalidProject[0]->project_validation;
        else $prevalidProject = "";
/*      var_dump($member);
        var_dump($prevalidProject);
        var_dump($member['project_validation'] != $prevalidProject);*/

        $temp = "false";
        if($member['project_validation']) $temp = "true";

        /*var_dump($temp);


        var_dump("UPDATE member SET project_validation='".$temp."' WHERE club_id = '".$member['club_id']."' AND school_year='".$year."' AND login='".$member['login']."'");*/

        if($member['project_validation'] != $prevalidProject || $prevalidProject == null){
            $req = Database::getInstance()->PDOInstance->exec("UPDATE member SET project_validation=".$temp." WHERE club_id = '".$member['club_id']."' AND school_year='".$year."' AND login='".$member['login']."'");

            return $req;
        }else return 1;


    }

    /**
     * callback a list with the the people who asked Capisen in first choice
     * @return array|null
     */
    public static function juniorCandidate()
    {
        $idJunior = \Models\Club::juniorEntrepriseID();

        $listMember = Database::Select("SELECT login FROM `choice` WHERE choice_number='1' AND club_id='". $idJunior . "'");


        $tableCandidateInfo = [];
        if(!empty($listMember)){
            foreach( $listMember as $value ) {
                //var_dump($value->login);

                $info =new \Models\User($value->login);
                $info->load();
                array_push ( $tableCandidateInfo , $info );
                //var_dump($info);
            }
            //var_dump($tableCandidateInfo);
            return $tableCandidateInfo;
        }else return null;


        /*   foreach( $res as $key => $val ) {
            $this->$key = $val;
        }*/
    }

    /**
     * Charge toutes les données d'un membre portant le login de l'objet courant
     */
    public function load()
    {
        if( empty($this->login) || empty($this->club_id) )
        {
            return [
                "err" => "Sans login et club serieux?"
            ];
        }
        // Récupère toutes les infos d'un club pour l'uid du this
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM member WHERE club_id='". $this->club_id .
            "' AND login='" . $this->login . "' AND school_year='" . $this->school_year . "'")
            ->fetchAll( \PDO::FETCH_ASSOC );

        if( !empty($res) && !empty($res[0]) ) {
            // complète le this avec les valeurs récupérées
            foreach( $res[0] as $key => $val ) {
                $this->$key = $val;
            }
        }
    }

    /**
     *
     * @param $year
     *
     * @return mixed
     */
    public static function juniorMember($year){
        $club_id = \Models\Club::juniorEntrepriseID();
        $res = Database::Select("SELECT COUNT(*) AS nb FROM member WHERE club_id='". $club_id ."' AND school_year='" . $year . "'");
        return $res[0] -> nb;

    }


    /**
     * do UPDATE if exist or an INSERT
     * @return bool
     */
    public function save()
    {

        if( empty($this->login) || empty($this->school_year) || empty($this->club_id) )
        {
            return [
                'err' => 'Que voulez vous sauvegarder?'
            ];
        }

        $values = array();

        // Récupère les attributs de classe
        $props = (new ReflectionObject($this))->getProperties();
        foreach ($props as $prop)
        {
            $k = $prop->name;
            $values[$prop->name] = $this->$k;
        }
        var_dump($this);
        $test = Database::Select("SELECT login FROM member WHERE login='". $this->login .
            "' AND school_year='". $this->school_year ."' AND club_id='". $this->club_id . "'"
        );

        // Création
        if( empty($test[0]->login) ){

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO member (club_id, login, school_year, id_projet_club, project_id, main_club, ".
                "member_mark, ex_member_not_wanted, recommandation, project_validation, member_comment) ".
                "VALUES (:club_id, :login, :school_year, :id_projet_club, :project_id, :main_club, ".
                ":member_mark, :ex_member_not_wanted, :recommandation, :project_validation, :member_comment)"
            );
            return $req->execute($values);
        }
        // Mise à jour
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE member SET id_projet_club=:id_projet_club, project_id=:project_id, main_club=:main_club, member_mark=:member_mark, ".
                "ex_member_not_wanted=:ex_member_not_wanted, recommandation=:recommandation, project_validation=:project_validation, ".
                "member_comment=:member_comment ".
                "WHERE login=:login AND school_year=:school_year AND club_id=:club_id"
            );
            return $req->execute($values);
        }
    }

    /**
     * Delete current object
     * @return int
     */
    public function delete()
    {
        return Database::getInstance()->PDOInstance->exec(
            "DELETE FROM member WHERE club_id='". $this->club_id .
            "' AND login='". $this->login .
            "' AND member.school_year='". $this->school_year ."'"
        );
    }
}
?>
