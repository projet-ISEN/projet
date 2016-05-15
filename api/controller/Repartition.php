<?php
/**
 * User: vincent riouallon
 * Date: 29/04/2016
 * Time: 14:30
 */

namespace Controllers;

use API\Database;

/**
 * Class repartition
 * @package Controllers
 */
class repartition
{

    /**
     * repartition constructor.
     *
     * @param $params
     */


    public static function repartition( $year ){
        //$trace = "Définition des projets pour chaques utilisateurs: " .self::whichProject( $year );
        //var_dump($trace);

        $findAClubFor = [];

        $minMax_effectif = self::minMaxEffectif( );
        //var_dump($minMax_effectif);

        $loginChoice = self::user2Bplced();//renvoie une liste des demandeur de club ^^

        $recommanded =self::recommanded($year);

        $notWanted =self::notWanted($year);
        $ancient = Database::Select("SELECT * FROM `member` WHERE main_club = 1 AND school_year =".($year-1));
        //var_dump($ancient);
        //var_dump($notWanted);

        foreach($loginChoice as $value){
            //var_dump($value -> login);
            array_push($findAClubFor,self::precedent_project_Validate($value -> login, $year));
        }//toutes les infos user pour la répârtition
        //var_dump($findAClubFor[0]);



        $nbAsked = self::minMaxProject($findAClubFor );
        //var_dump($nbAsked);

        $ratio = self::ratio($minMax_effectif, $nbAsked);
        //var_dump($ratio);

        //var_dump($findAClubFor);
/*        for ($i = 1; $i <= 3; $i++) {
            self::score($findAClubFor, $i);
        }*/



            self::score($findAClubFor, $recommanded,$notWanted, $ancient);


        //$effectif = self::total_effectif( $effectif);




    }

    public static function recommanded($year){
        return Database::Select("SELECT login, club_id FROM `member` WHERE project_validation = 0 AND recommandation = 1 AND school_year = ". $year);
    }

    public static function notWanted($year){
        return Database::Select("SELECT login, club_id FROM `member` WHERE project_validation = 0 AND ex_member_not_wanted = 1 AND school_year = ". $year);
    }


    public static function mergeAObjectInArray($member, $choice){

        $merge = [];
        //var_dump($member[0]);
        //var_dump($choice[0]);
           foreach($member as $valueA){
               $temp = (object)[];
               $temp = clone $valueA;

               foreach($choice as $valueB){
                   $count = 0;
                   if($valueA -> login == $valueB -> login){
                       $temp -> choice[intVal($valueB->choice_number)]["club_id"] = $valueB -> club_id;
                       $count++;
                       if($count == 3)break;
                   }

               }
                array_push($merge, $temp);
           }
        return $merge;
    }



    public static function score($findAClubFor, $recommanded,$notWanted, $ancient){

            $choice = [];

            for ($i = 1; $i <= 3; $i++) {

            $temp = self::whatTheChoices($i);
            $choice = array_merge($choice,$temp);

            }
            //var_dump($choice);
            $completeINfo = self::mergeAObjectInArray($findAClubFor,$choice);

            var_dump($completeINfo[0]);

            //var_dump($choice[0]);


            self::moulinette($completeINfo, $recommanded,$notWanted, $ancient);

            //var_dump($completeINfo);


    }



    public static function moulinette($completeINfo, $recommanded,$notWanted, $ancient){


        foreach($completeINfo as $member){
            foreach($recommanded as $reco){

                break;
            }

            foreach($notWanted as $notYou){

                break;
            }

            foreach($notWanted as $notYou){

                break;
            }

        }
    }

    public static function calcScore($i, $reco, $no){

    }


    public static function whatTheChoices($i){
        return Database::Select("SELECT * FROM `choice` WHERE choice_number =".$i);
    }


    public static function user2Bplced(){
        return Database::Select("SELECT DISTINCT login FROM `choice`");
    }

    public static function ratio($minMax_effectif, $nbAsked){
        //var_dump($minMax_effectif);
        //var_dump($nbAsked);
        $ratio = [];

        foreach($minMax_effectif as $value){
            foreach($nbAsked as $member){
/*        var_dump($value);
        var_dump($member);*/
                if($value->id == $member->id){
                    if($value -> nbMin && $member -> nbasked){//vérif div / 0
                        $minratio = $member -> nbasked / $value -> nbMin ;
                        if($minratio > 1) $minratio = 1;
                    }else $minratio = 1;


                    $maxratio = $member -> nbasked / $value -> nbMax;
                    if($maxratio < 1) $maxratio = 1;

                        $temp = (object)[];
                        $temp -> name = $value->name;
                        $temp -> id = $value -> id;
                        $temp -> minratio = $minratio;
                        $temp -> maxratio = $maxratio;

                        array_push($ratio, $temp);

                }
            }
        }


        return $ratio;

    }



    public static function total_effectif($effectif ){



        $effectif = (object)[];
        $effectif -> nbMin = $req[0] -> nbMin;
        $effectif -> nbMax = $req[0] -> nbMax;
        return $effectif;

    }



    public static function arrayProject( ){

        self::loadProject();

        $project_type = [];
        array_push($project_type, ['name' =>"PI", "id" =>$_SESSION['PI']]);
        array_push($project_type, ['name' =>"PA", "id" =>$_SESSION['PA']]);
        array_push($project_type, ['name' =>"PR", "id" =>$_SESSION['PR']]);
        array_push($project_type, ['name' =>"PR+", "id" =>$_SESSION['PR+']]);

        return $project_type;

    }

    public static function minMaxProject($list ){



        $memberAsk_nb = [];
        $PI = $PA = $PR = $PRplus = 0;


        $project_type = self::arrayProject();

        foreach($project_type as $projet){
            $projet = (object)$projet;
            $projet->nbasked = 0;
            //var_dump($projet);
            array_push($memberAsk_nb,$projet);

        }
        //var_dump($memberAsk_nb);
        //var_dump($project_type);
        //var_dump($list);nbasked

        foreach($list as $value){
            foreach($memberAsk_nb as $projet){
                if($projet->name == "PA" && $value->project_id == $projet->id){
                    $projet->nbasked++;
                    break;
                }

                if($projet->name == "PR" && $value->project_id= $projet->id){
                    $projet->nbasked++;
                    break;
                }

                if($projet->name == "PR+" && $value->project_id == $projet->id){
                    $projet->nbasked++;
                    break;
                }
                if($projet->name == "PI" && $value->project_id == $projet->id){
                    $projet->nbasked++;
                    break;
                }
            }
        }


/*        var_dump($PI);
        var_dump($PA);
        var_dump($PR);
        var_dump($PRplus);*/


        return $memberAsk_nb;

    }

    public static function minMaxEffectif( ){



        $project_type_nb = [];

        $project_type = self::arrayProject();



        foreach($project_type as $value){
            $req = Database::Select("SELECT SUM(`nb_asked_min`) AS nbMin, SUM(`nb_asked_max`) AS nbMax FROM `effectif` WHERE project_id='".$value["id"]."'");

            $effectif = (object)[];
            $effectif -> name = $value["name"];
            $effectif -> id = $value["id"];
            $effectif -> nbMin = $req[0] -> nbMin;
            $effectif -> nbMax = $req[0] -> nbMax;

            array_push($project_type_nb, $effectif);

        }
        //var_dump($project_type_nb);

        //var_dump($project_type);


        return $project_type_nb;

    }

    public static function whichProject( $year ){

        self::loadProject();

        $noProject = Database::Select("SELECT * FROM member WHERE main_club = 1 AND project_id IS NULL AND school_year='".$year."'");

        $project = [];
        $success = true;

        //on donne un projet à chaque personne
        foreach($noProject as $value){
            $temp = self::precedent_project_Validate($value->login,$year);
            if(!self::updateProject($temp, $year)) $success = false;
        }


        return($success);
    }

    public static function updateProject($project, $year){
        $req = Database::getInstance()->PDOInstance->exec("UPDATE member SET project_id = '".$project -> project_id."' WHERE login = '".$project->login."' AND school_year= ".$year);
        return $req;

    }

    public static function loadProject(){
         $_SESSION['PA'] = Database::Select("SELECT `project_id` FROM `projet` WHERE `project_type` = 'PA'")[0]->project_id;
         $_SESSION['PI'] = Database::Select("SELECT `project_id` FROM `projet` WHERE `project_type` = 'PI'")[0]->project_id;
         $_SESSION['PR'] = Database::Select("SELECT `project_id` FROM `projet` WHERE `project_type` = 'PR'")[0]->project_id;
         $_SESSION['PR+'] = Database::Select("SELECT `project_id` FROM `projet` WHERE `project_type` = 'PR+'")[0]->project_id;

    }

    public static function nextProject($project){

        if($project -> project_id == null) $project -> project_id = $_SESSION['PA'];
        elseif($project -> project_id == $_SESSION['PA']) $project -> project_id = $_SESSION['PR'];
        elseif($project -> project_id == $_SESSION['PR']) $project -> project_id = $_SESSION['PR+'];
        else $project -> project_id = null;

        return $project;
       //var_dump($project);
    }

    public static function precedent_project_Validate($login, $year ){
        $precedent = Database::Select("SELECT login, project_id FROM member WHERE main_club = 1 AND project_validation = 1 AND school_year <".$year." AND login = '".$login."' ORDER BY school_year DESC");

        if(!empty($precedent)){
            return self::nextProject($precedent[0]);
        }
        else{
            $temp = (object)[];
            $temp -> login = $login;
            $temp -> project_id = null;
            return self::nextProject($temp);
        }

    }

}
