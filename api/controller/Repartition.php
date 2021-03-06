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
        $start = microtime(true);
        $trace = "Définition des projets pour chaque utilisateur: " .self::whichProject( $year );
        //var_dump($trace);

        if( !self::preventBug() ) {
            echo json_encode([
               'err' => 'Aucun effectif demandé par les clubs'
            ]);
            return;
        }

        $findAClubFor = [];

        $minMax_effectif = self::minMaxEffectif( );

        //var_dump($minMax_effectif);

        $loginChoice = self::user2Bplced();//renvoie une liste des demandeurs de club ^^

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
        //var_dump($findAClubFor);
        $ratio = self::ratio($minMax_effectif, $nbAsked);
        //var_dump($ratio);

        //var_dump($findAClubFor);
/*        for ($i = 1; $i <= 3; $i++) {
            self::score($findAClubFor, $i);
        }*/

        $clubMinMaxEffectif = self::clubminmax($ratio);
         //if($val->login == "ftoque17")var_dump($val);
        //var_dump($findAClubFor);
         $score = self::score($findAClubFor, $recommanded,$notWanted, $ancient);

         $score = self::expception($score);

        $club = $clubMinMaxEffectif;
        $club = self::initiateClub($club);
                //var_dump(count($score));

        for ($i = 1; $i <= 3; $i++) {
            //var_dump($clubMinMaxEffectif);

            $temp = self::affectation($club,$score,$i);
            $club = $temp[0];
            $rest = $temp[1];
                        //var_dump($clubMinMaxEffectif);

            $temp = self::cutTheRest($club);

            $club = $temp[0];
                        //var_dump($club[14]);

            //var_dump($rest);
            $score = self::login2score($score, $temp[1]);

            //var_dump($rest);
            //var_dump($score);

            $score = array_merge($score,$rest);
                            //var_dump($howmanyplaced);


        }

        //var_dump($club);
        self::removeB4Choice($year);
        self::addWaitingConfirm($club,"waiting validation",$year);

/*        $howmanyplaced =0;
        foreach($club as $value){
            $howmanyplaced += count($value -> asked_people);
        }*/

        //var_dump($howmanyplaced);
        //var_dump(count($score));
        $time_elapsed_secs = microtime(true) - $start;
        //var_dump($time_elapsed_secs);
        echo(json_encode($score));

    }


    public static function preventBug() {

        $res = Database::Select("SELECT count(*) AS nb FROM effectif");
        return $res[0]->nb;
    }

    public static function validate($year){
        Database::getInstance()->PDOInstance->exec("DELETE FROM member WHERE main_club = 1  AND project_validation = 0 AND member_comment IS NULL AND school_year = ". $year);


        Database::getInstance()->PDOInstance->exec("UPDATE member SET member_comment = NULL, project_validation = 1 WHERE main_club = 1  AND project_validation = 0 AND school_year = ". $year);



        \Models\Choice::deleteAll();

        \Models\Effectif::deleteAll();

        echo json_encode([
            'err' => null
        ]);
        return;
    }

    public static function removeB4Choice($year){
        return Database::getInstance()->PDOInstance->exec("DELETE FROM member WHERE member_comment = 'waiting validation' AND school_year=".$year);
    }

    public static function addWaitingConfirm($club, $message, $year){
        $allGood =true;

        foreach($club as $val){
            foreach($val->asked_people as $value){
                $temp = Database::Select("SELECT COUNT(*) AS nb FROM `member` WHERE login ='".$value["login"]."' AND main_club = 1 AND club_id = '".$val -> club_id."' AND project_validation = 0 AND school_year = ". $year)[0] -> nb;
                if(!$temp){

                    $req = Database::getInstance()->PDOInstance->prepare(
                            "INSERT INTO `member`(`club_id`, `login`, `school_year`, `project_id`, `main_club`, `project_validation`, `member_comment`) VALUES (:club_id,:login,:school_year,:project_id,:main_club,:project_validation,:member_comment)");

                    $values["club_id"] = $val -> club_id;
                    $values["login"] = $value["login"];
                    $values["school_year"] = $year;
                    $values["project_id"] = $val -> project_id;
                    $values["main_club"] = 1;
                    $values["project_validation"] = 0;
                    $values["member_comment"] = $message;
                    if(!$req->execute($values))$allGood=false;
                }else{
                    Database::getInstance()->PDOInstance->exec("UPDATE member SET member_comment = 'waiting validation' WHERE login ='".$value["login"]."' AND main_club = 1 AND club_id = '".$val -> club_id."' AND project_validation = 0 AND school_year = ". $year);
                }
            }
        }
        return $allGood;
    }

    public static function login2score($score, $rest){
            //var_dump($rest);
            //var_dump($score);
            $noClubYet = [];
            foreach($score as $val){
                foreach($rest as $value){
                    if($val -> login == $value["login"] ){
                        array_push($noClubYet, $val);
                        break;
                    }
                }
            }
            //var_dump($noClubYet);
        return $noClubYet;
    }

    public static function cutTheRest($club){
        //var_dump($club);
        $rest = [];
        foreach($club as $value){
            $count = count($value->asked_people);
            if($count > $value -> nb_asked_max){
                $toCut = $value -> nb_asked_max - $count;
                //var_dump($toCut);
                $rest = array_merge($rest,array_splice($value->asked_people,$toCut));
            }

        }        //var_dump($club);

        return [$club,$rest];
    }


    public static function initiateClub($club){
        foreach($club as $value){
            $value->asked_people = [];
        }
        return $club;
    }

    public static function affectation($club,$effectif,$i){
        //var_dump($club[0]);
        //var_dump($effectif[0]);
                                //var_dump($club[14]);
        foreach($effectif as $value){
            $value-> notAttribuate = true;
        }

        $not_added = [];
        $test = true;
        foreach($club as $value){
            foreach($effectif as $val){

                if($value->club_id == $val->choice[$i]["club_id"] && $value->project_id == $val->project_id ){
                    array_push($value->asked_people,["login"=>$val->login,"score"=>$val->choice[$i]["score"]]);
                    $val->notAttribuate = false;
                }
            }
            //var_dump(count($value->asked_people));
            $value->asked_people = self::rearrange($value->asked_people);            //var_dump(count($value->asked_people));

        }

        foreach($effectif as $value){
            if($value-> notAttribuate) array_push($not_added,$value) ;
        }

                        //var_dump($club[14]);

        //asort($club[14]->asked_people[1]);
        //var_dump($club);
        //var_dump($club[14]->asked_people);
        return [$club,$not_added];
        //var_dump(asort($club[14]->asked_people));
    }

    public static function rearrange($array){

        $temp = array();
        foreach($array as $k => $value) {
            //var_dump($value);
          $temp[$k] = $value["score"];
        }

        //var_dump($array);
        array_multisort($temp, SORT_DESC, $array);
        return $array;

        //var_dump($array);


    }

    public static function clubminmax($ratio){
       $effectif = Database::Select("SELECT * FROM effectif");
        //var_dump($ratio);

        foreach($effectif as $value){
            foreach($ratio as $r){
                if($value -> project_id == $r -> id){
                    $value -> nb_asked_min = floor(intval($value -> nb_asked_min) * $r -> minratio);
                    $value -> nb_asked_max = ceil(intval($value -> nb_asked_max) * $r -> maxratio);

                    break;
                }
            }

        }
        return $effectif;
        //var_dump($ratio[0]);
    }

    public static function recommanded($year){
        $req = Database::getInstance()->PDOInstance->exec("UPDATE member SET member_comment = NULL WHERE project_validation = 0 AND member_comment='waiting validation' AND recommandation = 1 AND school_year=".$year);
        return Database::Select("SELECT login, club_id FROM `member` WHERE project_validation = 0 AND recommandation = 1 AND school_year = ". $year);
    }

    public static function notWanted($year){
        $req = Database::getInstance()->PDOInstance->exec("UPDATE member SET member_comment = NULL WHERE project_validation = 0 AND member_comment='waiting validation' AND ex_member_not_wanted = 1 AND school_year=".$year);
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
                       $number = intVal($valueB->choice_number);
                       $temp -> choice[$number]["score"] = self::choice_numberInPoint($number);
                       $count++;
                       if($count == 3)break;
                   }

               }
                array_push($merge, $temp);
           }
        return $merge;
    }



    public static function expception($score){

        foreach($score as $value){
            foreach($value->choice as $key=> $val){
                //var_dump($value->choice[$key]);
                if(self::CHECKexpception($val["club_id"] ))$value->choice[$key]["score"] = 0;
            }

        }
        return $score;
    }

        public static function CHECKexpception($val){
            return ($val == $_SESSION['Capisenid'] || $val == $_SESSION['BDEid'] || $val == $_SESSION['BDSid'] );
        }


    public static function score($findAClubFor, $recommanded,$notWanted, $ancient){

            $choice = [];

            for ($i = 1; $i <= 3; $i++) {

            $temp = self::whatTheChoices($i);
            $choice = array_merge($choice,$temp);

            }
            //var_dump($choice);
            $completeINfo = self::mergeAObjectInArray($findAClubFor,$choice);

            //var_dump($completeINfo[0]);

            //var_dump($choice[0]);


            return self::moulinette($completeINfo, $recommanded,$notWanted, $ancient);



            //var_dump($completeINfo);


    }

    //choix 1 return 5
    //choix 2 return 3
    //choix 3 return 1

    public static function choice_numberInPoint($i){
        return $i * (-2) +7;
    }


    public static function Changescore($member, $array,$point){

        $change = false;

        foreach($array as $current){
            if($member ->login == $current -> login){
                foreach($member -> choice as $key => $choice){
                    //var_dump($current);
                    //var_dump($choice);
                     if($choice["club_id"] == $current ->club_id){
                         //var_dump($member);
                         $member -> choice[$key]["score"] +=$point;
                         //var_dump($key);
                         $change = true;
                     }
                    //var_dump($choice);
                }

                //var_dump($current);
                //var_dump($member);

            }
        }
        return [$member,$change];
    }



    public static function moulinette($completeINfo, $recommanded,$notWanted, $ancient){

        //var_dump($recommanded);
        //var_dump($notWanted);
        //var_dump($ancient[0]);
        foreach($completeINfo as $member){

            $no = self::Changescore($member,$notWanted,-2);
            if($no[1]) $member = $no[0];
            else{
                $old = self::Changescore($member,$ancient,3);
                if($old[1]) $member = $old[0];
                else{
                    $reco = self::Changescore($member,$recommanded,2);
                    if($reco[1]) $member = $reco[0];
                }
            }


            //self::Changescore($member,$recommanded,2);
        }
        return $completeINfo;
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
                //var_dump($memberAsk_nb);

        foreach($list as $value){
            foreach($memberAsk_nb as $projet){
                if($projet->name == "PA" && $value->project_id == $projet->id){
                    $projet->nbasked++;
                    break;
                }

                if($projet->name == "PR" && $value->project_id== $projet->id){
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
        //var_dump($list);


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

            //var_dump($project);

        if($project -> project_id == null) $project -> project_id = $_SESSION['PA'];
        elseif($project -> project_id == $_SESSION['PA']) $project -> project_id = $_SESSION['PR'];
        elseif($project -> project_id == $_SESSION['PR']){
            $project -> project_id = $_SESSION['PR+'];

        }
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
