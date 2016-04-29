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

    public static function addMenuUserNonMember() {
        return [
                    'notMember' => [
                    'name' => '',
                    'expanded' => true,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Informations Globales',
                                "icon" => 'dashboard'
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Candidature',
                                "icon" => 'dashboard'
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Mes informations',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];
    }

    public static function addMenuUserMember($club) {
        return [
                    $club => [
                    'name' => $club,
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Evénements',
                                "icon" => 'dashboard'
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Réunions',
                                "icon" => 'dashboard'
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Contact',
                                "icon" => 'dashboard'
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Informations du clubs',
                                "icon" => 'dashboard'
                            ]
                            ,

                            [
                                "link" => '',
                                "title" => 'Mon/mes projet(s)',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];
    }

    public static function addMenuPresident($club) {
        return [
                    'Pres'.$club => [
                    'name' => ' Administration de "' . $club.'"',//TODO add club name
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Projets dans le club',
                                "icon" => 'dashboard'
                            ],

                            [
                                "link" => '',
                                "title" => 'Réunions de club',
                                "icon" => 'dashboard'
                            ],

                            [
                                "link" => '',
                                "title" => 'Notation',
                                "icon" => 'dashboard'
                            ],

                            [
                                "link" => '',
                                "title" => 'Année prospective',
                                "icon" => 'dashboard'
                            ],

                            [
                                "link" => '',
                                "title" => 'Gestion du club',
                                "icon" => 'dashboard'
                            ],

                            [
                                "link" => '',
                                "title" => 'Effectif',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];
    }

    public static function addMenuCapisen() {
        return [
                    'Capisenadministration' => [
                    'name' => 'Capisen',
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Recrutement',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];
    }


    public static function addMenuBDE() {
        return [
                    'BDEadministration' => [
                    'name' => 'Administration des Clubs',
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Gestion globale des clubs',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];
    }


    public static function addMenuEvaluator() {
        return [
                    'evaluator' => [
                    'name' => '',
                    'expanded' => true,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Gestions des clubs',
                                "icon" => 'dashboard'
                            ],
                            [
                                "link" => '',
                                "title" => 'Réunions',
                                "icon" => 'dashboard'
                            ],
                            [
                                "link" => '',
                                "title" => 'Activités des clubs',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];

    }


    public static function addMenuAdministrator() {
        return [
                    'administrator' => [
                    'name' => 'Administrator',
                    'expanded' => false,
                    'values' => [
                            [
                                "link" => '',
                                "title" => 'Création de club',
                                "icon" => 'dashboard'
                            ],
                            [
                                "link" => '',
                                "title" => 'Gestion des utilisateurs',
                                "icon" => 'dashboard'
                            ],
                            [
                                "link" => '',
                                "title" => 'Administration',
                                "icon" => 'dashboard'
                            ]
                        ]
                    ]
                ];
    }




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
                    $menu = array_merge($menu, self::addMenuUserMember($name));
                }

                $club = new Club();
                $role = new Role();

                for($i = $member->isAMemberOf(); $i > 0 ; $i--){//si bde ou capisen CAS SPE


                       $club_id = $list[$i -1] -> club_id;

                       $role_id = $role -> whichRoleID($_SESSION["year"], $club_id , $_SESSION["user"] -> login);

                       if( $role -> ID2Role($role_id) == $_SESSION["president"])$menu = array_merge($menu, self::addMenuPresident($list[$i -1] -> club_name));//if president we add the menu


                   if($list[$i -1] -> club_name == $_SESSION["BDE"]){

                       if($role -> ID2Role($role_id) == $_SESSION["tresorier"] || $role -> ID2Role($role_id) == $_SESSION["president"])$menu = array_merge($menu, self::addMenuBDE());

                   }
                    if($list[$i -1] -> club_name == $_SESSION["Capisen"]){
                       if($role -> ID2Role($role_id) == $_SESSION["president"])$menu = array_merge($menu, self::addMenuCapisen());
                   }
                }

            }





        }
        return $menu;

    }

}
?>
