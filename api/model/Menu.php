<?php
/**
 * User: Vincent Riouallon
 * Date: 28/04/2016
 * Time: 15:37
 */

namespace Models;

use \API\Database;
use \ReflectionObject;

/**
 * Class Menu
 * @package Models
 */
class Menu {

    // Equivalent d'une collection JS, plus simple pour les modifier
    // Tout les attributs doivent correspondre à la table correspondante

    public $login;


    /**
     * Menu constructor.
     */
    public function __construct( ) {

        $this->login            =  $_SESSION["user"] -> login;


    }

    public static function addMenuUserNonMember() {
        return [
                    'BDE' => [
                    'name' => 'BDE',
                    'expanded' => false,
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

    public static function addMenuUserMember() {
        return [
                    'BDE' => [
                    'name' => 'BDE',
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

    public static function addMenuPresident() {
        return [
                    'Président de club' => [
                    'name' => 'Président de club',//TODO add club name
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
                    'Capisen' => [
                    'name' => 'Capisen',
                    'expanded' => true,
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
                    'BDE' => [
                    'name' => 'BDE',
                    'expanded' => true,
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
        }




        echo json_encode($menu);

    }

}
?>
