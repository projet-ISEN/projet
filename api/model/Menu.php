<?php
/**
 * User: Vincent Riouallon
 * Date: 28/04/2016
 * Time: 15:37
 */

namespace Models;

use \API\Database;

/**
 * Class Menu
 * @package Models
 */
class Menu {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante




    /**
     * Menu constructor.
     */
    public function __construct( ) {
    }

    /**
     * @return array
     */
    public static function addMenuUserNonMember() {
        return [
                    'notMember' => [
                    'name' => '',
                    'expanded' => true,
                    'values' => [
                            [
                                "link" => '#/',
                                "title" => 'Informations globales',
                                "icon" => 'dashboard',
                                "title" => 'Informations Globales',
                                "icon" => 'home',
                                "active" => false
                            ]
                            ,

                            [
                                "link" => '#/candidature',
                                "title" => 'Candidature',
                                "icon" => 'filter_3',
                                "active" => false
                            ]
                            ,

                            [
                                "link" => '#/me',
                                "title" => 'Mes informations',
                                "icon" => 'person',
                                "active" => false
                            ]
                        ]
                    ]
                ];
    }

    /**
     * @param $club
     * @param $club_id
     *
     * @return array
     */
    public static function addMenuUserMember($club, $club_id) {
        return [
                    $club => [
                    'name' => $club,
                    'expanded' => false,
                    'values' => [
                            /*[
                                "link" => '',
                                "title" => 'Evénements',
                                "icon" => 'dashboard',
                                "active" => false
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Réunions',
                                "icon" => 'dashboard',
                                "active" => false
                            ]
                            ,*/

                            [
                                "link" => '#/clubs/'.$club_id.'/contact/',
                                "title" => 'Contact',
                                "icon" => 'contact_mail',
                                "active" => false
                            ]
                            ,

                            [
                                "link" => '#/passation/' . $club_id,
                                "title" => 'Informations du club',
                                "icon" => 'dashboard',
                                "icon" => 'weekend',
                                "active" => false
                            ]
                            /*,

                            [
                                "link" => '',
                                "title" => 'Mon/mes projet(s)',
                                "icon" => 'dashboard',
                                "active" => false
                            ]*/
                        ]
                    ]
                ];
    }

    /**
     * @param $club
     * @param $club_id
     *
     * @return array
     */
    public static function addMenuPresident($club, $club_id) {
        return [
                    'Pres'.$club => [
                    'name' => ' Administration de "' . $club.'"',//TODO add club name
                    'expanded' => false,
                    'values' => [
                            /*[
                                "link" => '',
                                "title" => 'Projets dans le club',
                                "icon" => 'dashboard',
                                "active" => false
                            ],

                            [
                                "link" => '',
                                "title" => 'Réunions de club',
                                "icon" => 'dashboard',
                                "active" => false
                            ],*/

                            [
                                "link" => '#/clubs/'. $club_id . '/notation',
                                "title" => 'Notation',
                                "icon" => 'school',
                                "active" => false
                            ],

                            [
                                "link" => '#/nextyear/'.$club_id ,
                                "title" => 'Année prospective',
                                "icon" => 'next_week',
                                "active" => false
                            ],

                            [
                                "link" => '#/gestion/'.$club_id,
                                "title" => 'Gestion du club',
                                "icon" => 'dashboard',
                                "active" => false
                            ]/*,

                            [
                                "link" => '',
                                "title" => 'Effectif',
                                "icon" => 'dashboard',
                                "active" => false
                            ]*/
                        ]
                    ]
                ];
    }

    /**
     * @return array
     */
    public static function addMenuCapisen() {
        return [
                    'Capisenadministration' => [
                    'name' => 'Capisen Recrutement',
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '#/recruCapisen',
                                "title" => 'Recrutement',
                                "icon" => 'dashboard',
                                "active" => false
                            ]
                        ]
                    ]
                ];
    }

    /**
     * @return array
     */
    public static function addMenuBDE() {
        return [
                    'BDEadministration' => [
                    'name' => 'Administration des Clubs',
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '#/manageBDE',
                                "title" => 'Gestion globale des clubs',
                                "icon" => 'school',
                                "active" => false
                            ]
                        ]
                    ]
                ];
    }

    /**
     * @return array
     */
    public static function addMenuEvaluator() {
        return [
                    'evaluator' => [
                    'name' => '',
                    'expanded' => true,
                    'values' => [
                            [
                                "link" => '#/',
                                "title" => 'Informations globales',
                                "icon" => 'dashboard',
                                "title" => 'Informations Globales',
                                "icon" => 'home',
                                "active" => false
                            ],

                            [
                                "link" => '#/me',
                                "title" => 'Mes informations',
                                "icon" => 'person',
                                "active" => false
                            ],
                            [
                                "link" => '#/manage',
                                "title" => 'Gestion des clubs',
                                "icon" => 'dashboard',
                                "title" => 'Gestions des clubs',
                                "icon" => 'school',
                                "active" => false
                            ]/*,
                            [
                                "link" => '',
                                "title" => 'Réunions',
                                "icon" => 'dashboard',
                                "active" => false
                            ],
                            [
                                "link" => '',
                                "title" => 'Activités des clubs',
                                "icon" => 'dashboard',
                                "active" => false
                            ]*/
                        ]
                    ]
                ];

    }

    /**
     * @return array
     */
    public static function addMenuAdministrator() {
        return [
                    'administrator' => [
                    'name' => 'Administration',
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '#/clubs/addclub',
                                "title" => 'Création de clubs',
                                "icon" => 'dashboard',
                                "title" => 'Création de club',
                                "icon" => 'plus_one',
                                "active" => false
                            ],
                            [
                                "link" => '#/adminUsers',
                                "title" => 'Gestion des utilisateurs',
                                "icon" => 'group',
                                "active" => false
                            ],
                            [
                                "link"      => '#/administration',
                                "title"     => 'Administration',
                                "icon"      => 'security',
                                "active"    => false
                            ],
                            [
                                "link"      => '#/evaluatorsOfClubs',
                                "title"     => 'Evaluateurs de clubs',
                                "icon"      => 'supervisor_account',
                                "active"    => false
                            ],
                            [
                                "link" => '#/adminAffectation',
                                "title" => 'Affectation automatique',
                                "icon" => 'autorenew',
                                "active" => false
                            ]
                        ]
                    ]
                ];
    }

    /**
     * @return array
     */
    public static function jsonMenu() {

        $menu = [];

        if($_SESSION['user']->isEvaluator()){//si l'utilisateur est un administrateur
            $menu = array_merge($menu, self::addMenuEvaluator());

            if($_SESSION["user"] -> is_administrator){
                 $menu = array_merge($menu, self::addMenuAdministrator());
            }
        }else{//If it is a member
            $menu = array_merge($menu, self::addMenuUserNonMember());

            $member = new Member();
            if($i = $member->isAMemberOf()){//user member menu
                $list = $member->ClubMembers();
                for($i; $i > 0 ; $i--){
                    $name = $list[$i -1] -> club_name;
                    $club_id = $list[$i -1] -> club_id;
                    $menu = array_merge($menu, self::addMenuUserMember($name, $club_id));
                }

                $club = new Club();
                $role = new Role();

                for($i = $member->isAMemberOf(); $i > 0 ; $i--){//on parcour ses clubs
                    //si bde ou capisen CAS SPE


                       $club_id = $list[$i -1] -> club_id;

                       $role_link = $role -> whichRoleID($_SESSION["year"], $club_id , $_SESSION["user"] -> login);
                        $prez = false;
                        $tres = false;

                        if(!empty($role_link)){
                            foreach($role_link as $value){
                                $prez = (role::ID2Role($value -> id_role) == $_SESSION["president"]);
                                $tres = (role::ID2Role($value -> id_role) == $_SESSION["tresorier"]);
                                //var_dump($prez);
                            }
                        }

                       if( $prez )$menu = array_merge($menu, self::addMenuPresident($list[$i -1] -> club_name, $club_id));//if president we add the menu


                   if($list[$i -1] -> club_name == $_SESSION["BDE"]){

                       if($tres || $prez)$menu = array_merge($menu, self::addMenuBDE());

                   }
                    if($list[$i -1] -> club_name == $_SESSION["Capisen"]){
                       if($prez)$menu = array_merge($menu, self::addMenuCapisen());
                   }
                }
            }
        }
        return $menu;
    }
}
?>
