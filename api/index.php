<?php
    session_start();

    // Permet de faire un require_once de tous les fichier php sauf index.php

    $objects = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('./'), RecursiveIteratorIterator::SELF_FIRST);
    foreach($objects as $name => $object){

        if(is_file($name) && $name != '.' && $name[2] != '.' && (strpos($name, 'index.php') == false) ) {
            require_once($name);
        }
    }

/*================================================================
                        Global Variable
 ================================================================*/

    $_SESSION['president'] = "président";
    $_SESSION['vice-president'] = "vice-président";
    $_SESSION['tresorier'] = "trésorier";
    $_SESSION['secrétaire'] = "secrétaire";

    $_SESSION['BDE'] = "Bureau des élèves";
    $_SESSION['Capisen'] = "Capisen";//La junior entreprise



    if(! \API\Conf::isDebug()) require_once ('/var/www/html/CAS/pluginCasBis.php');
    else {
        // Données de l'ENT

        //test variable

        $userData["Login"]      = 'rcolli17'; $userData["gidNumber"] = "1000";//Evaluator & administrator adn school staf
        // $userData["Login"]      = 'vrioua17';  $userData["gidNumber"] = "1000"; //Evaluator school_staff
        //$userData["Login"]      = 'pverba17'; //Prez BDE
        //$userData["Login"]      = 'fduboi17'; //trez BDE
        // $userData["Login"]      = 'mgoanv17'; //Capisen Prez
        //$userData["Login"]      = 'tcouss17'; //Prez club
        //$userData["Login"]      = 'gbiann17'; //Double PR main club moviezen secon Club Elec
        //$userData["Login"]      = 'ftoque17'; //PR+ Moviezen
        //$userData["Login"]      = 'qduche17'; //PA BDE
        //$userData["Login"]      = 'gymorv17'; //PA Capisen
        //$userData["Login"]      = 'gbiann17'; //Evaluator & administrator





        $userData["Name"]       = 'prename name'; // prénom nom
        $userData["FirstName"]  = 'prename'; // prénom
        $userData["LastName"]   = 'name'; // nom
        $userData["Mail"]       = 'email'; // mail
        $userData["Telephone"]  = 'tel'; // telephone
        $userData["uidNumber"]  = 'number'; // numero d'identifiant (pas nécessaire pour vous)
        $userData["gidNumber"]  = '1000'; // numero de groupe (voir ci-dessous)
    }

/*================================================================
                        WHICH DATE ARE WE
 ================================================================*/
date_default_timezone_set('UTC');

$myYear = date("Y");

if (date("n")>7) $myYear++;

 $_SESSION['year'] = $myYear;

/*================================================================
                            WHO IS THIS
 ================================================================*/


    // Identifie la personne et le stock en variable de session
    $_SESSION['user'] = new \Models\User($userData);
    if( $_SESSION['user']->exist() ){
        $_SESSION['user']->load();
    }
    else {
        $_SESSION['user']->save();
    }

/*    $router->get(       '/year',        function() {
         echo json_encode(array(
            'currentYear' => $_SESSION['year']
         ));
    });*/

/*================================================================
                            ROUTES
 ================================================================*/

    $router = new API\Router( $_GET['url'] );





    // Use controller user and method one

    if($_SESSION['user']->is_administrator){

        $router->get(       '/users/:id',   'User.get');
        $router->post(      '/clubs',       'Club.create');
        $router->get(       '/clubs/:id',   'Club.getOne');
        $router->put(       '/club/:id',    'Club.update');
        $router->delete(    '/club/:id',    'Club.delete');




        $router->post(      '/projects',       'Project.create');


        $router->get(       '/contact/:club_id', 'Member.membersIntelsInClub'    );

        $router->get(       '/effectifs',        'Effectif.getAll');
        $router->get(       '/effectifs/:id',    'Effectif.getOne');

        $router->get(       '/projects/:id',     'Project.getOne');

    }elseif(!$_SESSION['user']->is_administrator){
        $router->get(       '/choices/:choice_number', 'Choice.getChoiceOne'    );
        $router->get(       '/choices',     'Choice.getChoiceAll'    );
        $router->post(      '/choices',     'Choice.create' );
        $router->put(       '/choices',     'Choice.update' );
        $router->delete(    '/choices',     'Choice.deleteAll' );
    }

    $router->get(       '/menu', 'Menu.jsonMenu'    );
    $router->get(       '/me', 'User.getMe');
    $router->put(       '/me', 'User.updateMe');
    $router->get(       '/projects',         'Project.getAll');
    $router->get(       '/clubs',       'Club.getAll');
    $router->get(       '/clubs/:id/stat', 'Club.stat');


    $router->get(       '/log',                 'Logger.getLastLogs');
    $router->get(       '/log/:number',         'Logger.getLastLogs');
    $router->get(       '/log/:dateA/:dateB',   'Logger.getBetweenDate');


/*    $router->get(       '/choice',   function(){
        $choice = new \Models\Choice();
        $choice -> alreadyChoose();
    });*/
    //Exemple de route particulière
    /*$router->get('club/:id-:nom', function($id, $nom) {

    })->with('id', '[0-9]+')->with('nom', '[A-z\-0-9]+');*/

    //\Controllers\Logger::info( $_SESSION['user']->login . ' vient de se connecter ' );

    header('Content-Type: application/json; charset=utf-8');
    $router->run();
