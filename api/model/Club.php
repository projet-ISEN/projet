<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 07/03/2016
 * Time: 13:15
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Club
 * @package Models
 */
class Club {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante
    public $club_id;
    public $login;
    public $club_name;
    public $club_description;
    public $club_mail;
    public $blocknote;
    public $actif;

    /**
     * Club constructor.
     *
     * @param null $id
     */
    public function __construct( $id_Club = null ) {

        $this->club_id          = $id_Club;
        $this->login            = '';
        $this->club_name        = '';
        $this->club_description = '';
        $this->club_mail        = '';
        $this->blocknote        = '';
        $this->actif            = 1 ;
    }

    /**
     * Renvoi les informations de tous les clubs
     * Ou d'un club si un ID est spécifié
     * @param null $id
     * @return null
     */
    public static function get( $id=null )
    {
        if(!$id){
            return Database::getInstance()->Select("SELECT club_id, club_name, club_description, club_mail, actif, login FROM club");
        }
        else {
            return Database::getInstance()->Select(
                "SELECT club_id, club_name, club_description, club_mail, actif, login FROM club " .
                "WHERE club_id='" . $id . "'"
            )[0];

        }
    }


    public static function getByName( $name )
    {
            return Database::getInstance()->Select(
                "SELECT club_id, club_name, club_description, club_mail, actif, login FROM club " .
                "WHERE club_name='" . $name . "'"
            )[0];

        }

    /**
     * Renvoi les clubs (objets avec seulement id) qu'un Evaluateur peut administrer
     */
    public static function getMyClubsForEvaluator($login = null)
    {

        if(empty($login)) $login = $_SESSION['user']->login;
        $myClubs = Database::Select("SELECT club_id FROM club WHERE login='". $login ."'");

        if( $_SESSION['user']->is_administrator ){
            $myClubs = Database::Select("SELECT club_id FROM club");
        }
        else {
            $myClubs = Database::Select("SELECT club_id FROM club WHERE login='". $_SESSION['user']->login ."'");
        }


        $myClubsObj = [];

        foreach ($myClubs as $club) {
            array_push( $myClubsObj, new self( $club->club_id) );
        }
        return $myClubsObj;
    }

    /**
     * Rnvoie un tableau avec tous les info du clubs de l'évaluateur
     */
    public static function getMyClubsIntelsEvaluator($login = null)
    {

        if(empty($login)) $login = $_SESSION['user']->login;
        $myClubs = Database::Select("SELECT * FROM club WHERE login='". $login ."'");

        return $myClubs;
    }


    public static function isLock($id)
    {
        $year = $_SESSION['year'];
        $lock = Database::Select("SELECT lock_member_mark, lock_member_project_validation FROM note_club WHERE club_id='". $id ."' AND school_year = '".$year."'");

        if(isset($lock[0])) $lock = $lock[0];
        else $lock = [
            'lock_member_mark'=> '1', "lock_member_project_validation" => '0'
        ];


        return $lock;
    }

    /**
     * Return the number of member in the club and
     *escape the member as second club
     *
     * @param currentYear $year
     * @return null
     */
    public function numberOfMembers($year = null) {
        if( !$year) $year = $_SESSION['year'];
        $res = Database::getInstance()->PDOInstance->query(
            "SELECT count(*) FROM member WHERE club_id='".
            $this->club_id ."' AND school_year='".$year."' AND main_club='1'");
        return $res->fetchAll(\PDO::FETCH_NUM)[0][0];

    }

    /**
     * Return type of project and number of it in array
     * @param null $year
     *
     * @return array
     */
    public function memberDetails($year = null ) {
        if( !$year) $year = $_SESSION['year'];

        $res = Database::getInstance()->PDOInstance->query(
            "SELECT p.project_type, count(p.project_type) as number FROM member m, projet p ".
            "WHERE club_id='" . $this->club_id . "' ".
            "AND school_year='" . $year . "' AND main_club='1' ".
            "AND p.project_id=m.project_id ".
            "GROUP BY p.project_type");
        return $res->fetchAll();
    }

    /**
     * Renvoi un tableau d'objet Member appartenant au club avec seulement login et clubId
     */
    public function getMembers()
    {
        $members = [];
        $req = Database::Select("SELECT * FROM member WHERE club_id='" . $this->club_id . "' AND main_club=1");
        foreach ($req as $member) {
            array_push($members, new \Models\Member( $this->club_id, $member->login ) );
        }

        return $members;
    }

    /**
     * Note Club
     */
    public static function giveClubMark($club_id, $note)
    {
        $year = $_SESSION['year'];
        $res = Database::Select(
            "SELECT count(*) AS Nb FROM note_club WHERE club_id='".
            $club_id ."' AND school_year='".$year."'");

        $preMark = Database::Select("SELECT note_club FROM note_club WHERE club_id='".
            $club_id ."' AND school_year='".$year."'");

        if(isset($preMark[0]))$preMark = $preMark[0]->note_club;
        else $preMark = "";

        if($preMark != $note){


            if($res[0]->Nb != 0){
                /*var_dump("update");*/
                $req = Database::getInstance()->PDOInstance->exec("UPDATE note_club SET note_club='".$note."' WHERE club_id = '".$club_id."' AND school_year='".$year."'");
                return $req;
            }
            else{

                $values['club_id'] = $club_id ;
                $values['school_year'] = $year ;
                $values['note_club'] = $note ;


                $req = Database::getInstance()->PDOInstance->prepare(
                        "INSERT INTO `note_club`(`club_id`, `school_year`, `note_club`)"
                        ."VALUES (:club_id, :school_year, :note_club)"
                    );

                return  $req->execute($values);

            }
        }else return 1;
    }


    /**
     * Récupère la note_club d'un Note Club
     */
    public static function markClub($club_id)
    {
        $year = $_SESSION['year'];
        $res = Database::Select(
            "SELECT note_club FROM note_club WHERE club_id='".
            $club_id ."' AND school_year='".$year."'");
        if(isset($res[0]))$res = $res[0];
        else $res = [
            'err' => null
        ];
        return $res;
    }



    /**
     * Charge toutes les données du club portant l'ID de l'objet courant
     */
    public function load() {

        // Récupère toutes les infos d'un club pour l'uid du this
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM club WHERE club_id='". $this->club_id ."'")
            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }

    }


    public static function juniorEntrepriseID() {

        $res = Database::getInstance()->PDOInstance->query("SELECT club_id FROM club WHERE club_name='". $_SESSION['Capisen'] ."'")
            ->fetchAll( \PDO::FETCH_ASSOC );
        //var_dump($res);

        if(!empty($res)){
            return $res[0]["club_id"];
        }
        else return null;

    }

    /**
     * Fait un UPDATE ou un INSERT en fonction du numero de club pour sauvegarder les modifications d'un club
     * @return bool
     */
    public function save() {

        $values = array();

        // Récupère les attributs de classe
        $props = (new ReflectionObject($this))->getProperties();
        foreach ($props as $prop) {
            $k = $prop->name;
            $values[$prop->name] = $this->$k;
        }

        // Creation
        if( empty($this->club_id) ) {

            // need a new uid
            $values['club_id'] = Database::getUID();

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO club (club_id, login, club_name, club_description, club_mail, actif, blocknote) ".
                "VALUES (:club_id, :login, :club_name, :club_description, :club_mail, :actif, :blocknote)"
            );

            if( $req->execute($values) ){
                $this->club_id = $values['club_id'];
                return true;
            }
            return false;

        }
        // Mise à jour
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE club SET login=:login, club_name=:club_name, club_description=:club_description, ".
                "club_mail=:club_mail, actif=:actif, blocknote=:blocknote WHERE club_id=:club_id"
            );
            return $req->execute($values);
        }
    }

    /**
     * Supprime le club de l'objet courant dans la base de donnée
     * /!\ Possible uniquement s'il n'a plus aucun membre
     * @return bool
     */
    public function delete() {

        $req = Database::getInstance()->PDOInstance->prepare("DELETE FROM club WHERE club_id=:club_id");
        return $req->execute(array('club_id'=> $this->club_id));
    }

    /**
     * Toggle state of lock case
     * @param $id
     * @param $case
     *
     * @return int
     */
    public static function lock($id, $case) {
        $year = $_SESSION['year'];
        $res = Database::getInstance()->PDOInstance->query("SELECT ".$case." FROM note_club WHERE club_id='". $id ."' AND school_year='".$year."'");

        $values['club_id'] = $id;
        $values['year'] = $year;

        $insert = Database::getInstance()->PDOInstance->prepare("INSERT INTO `note_club`(`club_id`, `school_year`) VALUES (:club_id, :year)");

        $temp = "true";

        $result = $res->fetchAll( \PDO::FETCH_ASSOC );
        //var_dump($result);
        $bool = empty($result);
        //var_dump($bool);


        if($bool){
            $insert->execute($values);
            $temp = "false";
            if($case == "lock_member_mark") return 1;

        }

        elseif(!empty($result[0][$case])) $temp = "false";


        $req = Database::getInstance()->PDOInstance->exec("UPDATE note_club SET ". $case."=".$temp." WHERE club_id = '".$id."' AND school_year='".$year."'");
        //var_dump( empty($res[$case]));
        //var_dump( "UPDATE note_club SET ". $case."=".$temp." WHERE club_id = '".$id."' AND school_year='".$year."'");
        return $req;

       /* */
    }
}
?>
