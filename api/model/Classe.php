<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 11/05/2016
 * Time: 08:47
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

class Classe
{
    public $school_year;
    public $login;
    public $classe_name;

    public function __construct( $login='', $year=null, $classe='' )
    {
        if( empty($year) )      $year   = $_SESSION['year'];
        if( is_int($classe) )   $classe = self::gidToClasse( $classe );

        $this->login = $login;
        $this->school_year = $year;
        $this->classe_name = $classe;
    }

    public static function gidToClasse( $gid )
    {
        switch( $gid ) {
            case "1000":
                return "Personnel";
                break;
            case "1001":
                return "CSI1";
                break;
            case "1101":
                return "CIR1";
                break;
            case "1201":
                return "BTS-INFO-1";
                break;
            case "1301":
                return "BTS-ELEC-1";
                break;
            case "1002":
                return "CSI2";
                break;
            case "1102":
                return "CIR2";
                break;
            case "1202":
                return "BTS-INFO-2";
                break;
            case "1302":
                return "BTS-ELEC-2";
                break;
            case "1003":
                return "CSI3";
                break;
            case "1103":
                return "CIR3";
                break;
            case "1303":
                return "CIPA3";
                break;
            case "1004":
                return "M1";
                break;
            case "1304":
                return "CIPA4";
                break;
            case "1005":
                return "M2";
                break;
            case "1305":
                return "CIPA5";
                break;
            case "1006":
                return "N6";
                break;
            case "1306":
                return "CIPA6";
                break;
            case "1010":
                return "Divers";
                break;
            case "1011":
                return "Vacataire";
                break;
            case "1012":
                return "Invite";
                break;
            case "1013":
                return "Thesard";
                break;
            case "1100":
                return "club";
                break;
            default:
                return null;
                break;
        }
    }

    public function haveClasse()
    {
        $req = Database::Select("SELECT classe_name FROM classe WHERE login='". $this->login .
            "' AND school_year='". $this->school_year ."'");
        return !empty($req[0]->classe_name);
    }

    public function load()
    {
        $res = Database::getInstance()->PDOInstance->query("SELECT * FROM classe WHERE login='" . $this->login .
            "' AND school_year='" . $this->school_year . "'" )
            ->fetchAll( \PDO::FETCH_ASSOC );
        if( !empty($res[0]) )
        {
            // complète le this avec les valeurs récupérées
            foreach( $res[0] as $key => $val ) {
                $this->$key = $val;
            }
        }
    }

    /**
     * Fait un UPDATE ou un INSERT
     * @return bool
     */
    public function save()
    {

        if( empty($this->login) || empty($this->school_year))
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

        $test = Database::Select("SELECT classe_name FROM classe WHERE login='". $this->login .
                                "' AND school_year='". $this->school_year ."'");

        // Création
        if( empty($test[0]['login']) ){

            $req = Database::getInstance()->PDOInstance->prepare(
                "INSERT INTO classe (school_year, login, classe_name) ".
                "VALUES (:school_year, :login, :classe_name)"
            );
            return $req->execute($values);
        }
        // Mise à jour
        else {
            $req = Database::getInstance()->PDOInstance->prepare(
                "UPDATE member SET classe_name=:classe_name WHERE login=:login AND school_year=:school_year"
            );
            return $req->execute($values);
        }
    }
}

/*
1000 : Personnel
1001 : CSI1
1101 : CIR1
1201 : BTS-INFO-1
1301 : BTS-ELEC-1
1002 : CSI2
1102 : CIR2
1202 : BTS-INFO-2
1302 : BTS-ELEC-2
1003 : CSI3
1103 : CIR3
1303 : CIPA3
1004 :  M1
1304 : CIPA4
1005 : M2
1305 : CIPA5
1006 : N6
1306 : CIPA6
1010 : Divers
1011 : Vacataire
1012 : Invite
1013 : Thesard
1100 : club
*/
