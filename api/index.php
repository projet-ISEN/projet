<?php
    session_start();

    // Permet de faire un require_once de tous les fichier php sauf index.php
    $objects = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('./'), RecursiveIteratorIterator::SELF_FIRST);
    foreach($objects as $name => $object){

        if(is_file($name)
            && $name != '.'
            && $name[2] != '.'
            && (strpos($name, 'index.php') == false)
             ) {
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
        //$userData["Login"]      = 'vrioua17';  $userData["gidNumber"] = "1000"; //Evaluator school_staff
        //$userData["Login"]      = 'pverba17'; //Prez BDE
        //$userData["Login"]      = 'fduboi17'; //trez BDE
        //$userData["Login"]      = 'mgoanv17'; //Capisen Prez
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
        //$userData["gidNumber"]  = '1102'; // numero de groupe (voir ci-dessous)
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

/*================================================================
                            ROUTES
 ================================================================*/

    $router = new API\Router( $_GET['url'] );

    // ONLY ADMINISTRATEUR
    if($_SESSION['user']->is_administrator){


        $router->post(      '/clubs',       'Club.create');
        $router->put(       '/club/:id',    'Club.update');
        $router->delete(    '/club/:id',    'Club.delete');

        $router->get(       '/projects/:id',   'Project.getOne');
        $router->post(      '/projects',       'Project.create');
        $router->put(       '/projects',       'Project.update');
        $router->delete(    '/projects/:id',       'Project.delete');

        $router->post(      '/role',       'Role.add');
        $router->put(       '/role',       'Role.update');
        $router->delete(    '/role/:id',       'Role.delete');


        $router->get(       '/log',                 'Logger.getLastLogs');
        $router->get(       '/log/:number',         'Logger.getLastLogs');
        $router->get(       '/log/:dateA/:dateB',   'Logger.getBetweenDate');

        $router->put(      '/users/:user_login',       'User.setClub');

    // ONLY NOT ADMINISTRATEUR
    } elseif(!$_SESSION['user']->is_administrator)
    {
        $router->get(       '/choices/:choice_number', 'Choice.getChoiceOne'    );
        $router->get(       '/choices',     'Choice.getChoiceAll'    );
        $router->post(      '/choices',     'Choice.create' );
        $router->put(       '/choices',     'Choice.update' );
        $router->delete(    '/choices',     'Choice.deleteAll' );
    }

    // ONLY EVALUATOR
    if($_SESSION['user']->school_staff)
    {
        $router->get(       '/clubEvaluator',     'Club.ClubsIntelsEvaluator'    );

        $router->get(       '/clubs/:id',   'Club.getOne');

        $router->get(       '/members/:id',   'Member.getMembersOfClub');

        $router->get(       '/users/:id',   'User.get');

        $router->post(      '/pushPrez',   'Role.pushPrez');
        //$router->get(      '/IDPrez',   'Role.IDPrez');
<<<<<<< HEAD
        $router->get(      '/whoPrez/:clubId',   'Role.whoPrez');


        $router->post(      '/noteStudent',   'Member.noteStudent');



        $router->post( '/noteClub',   'Club.giveClubMark');



    }
    $router->get( '/noteClub/:id',   'Club.markClub');

    $router->get(       '/contact/:club_id', 'Member.membersIntelsInClub'    );
=======
        $router->get(       '/whoPrez/:clubId',   'Role.whoPrez');
    }
>>>>>>> origin/master

    $router->get(       '/contact/:club_id', 'Member.membersIntelsInClub'    );

    $router->get(       '/menu', 'Menu.jsonMenu'    );

    $router->get(       '/me', 'User.getMe');
    $router->put(       '/me', 'User.updateMe');

    $router->get(       '/projects',         'Project.getAll');

    $router->get(       '/clubs',       'Club.getAll');
    $router->get(       '/clubs/:id/stat', 'Club.stat');

    $router->get(       '/effectifs',        'Effectif.getAll');
    $router->get(       '/effectifs/:id',    'Effectif.getOne');

    $router->get(       '/notes',            'NotationProf.allNotes');
    $router->get(       '/notes/xlsx',       'NotationProf.toXlsx');
    $router->get(       '/notes/:id',        'NotationProf.allNotes');
    $router->post(      '/notes/:id',        'NotationProf.setNote');

    $router->get(       '/role',   'Role.getAll');



    /*    $router->get(       '/choice',   function(){
        $choice = new \Models\Choice();
        $choice -> alreadyChoose();
    });*/
    //Exemple de route particulière
    /*$router->get('club/:id-:nom', function($id, $nom) {

    })->with('id', '[0-9]+')->with('nom', '[A-z\-0-9]+');*/

    //header('Content-Type: application/json; charset=utf-8');
    $router->run();
