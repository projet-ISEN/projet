<?php

/*================================================================
                        Global Variable
 ================================================================*/

    $_SESSION['president'] = "président";
    $_SESSION['vice-president'] = "vice-président";
    $_SESSION['tresorier'] = "trésorier";
    $_SESSION['secrétaire'] = "secrétaire";

    $_SESSION['BDE'] = "Bureau des élèves";
    $_SESSION['Capisen'] = "Capisen";//La junior entreprise






    // Données de l'ENT
    $userData["Login"]      = 'gbiann17'; // login
    $userData["Name"]       = 'prename name'; // prénom nom
    $userData["FirstName"]  = 'prename'; // prénom
    $userData["LastName"]   = 'name'; // nom
    $userData["Mail"]       = 'email'; // mail
    $userData["Telephone"]  = 'tel'; // telephone
    $userData["uidNumber"]  = 'number'; // numero d'identifiant (pas nécessaire pour vous)
    $userData["gidNumber"]  = '1000'; // numero de groupe (voir ci-dessous)


    // Permet de faire un require_once de tous les fichier php sauf index.php

    $objects = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('./'), RecursiveIteratorIterator::SELF_FIRST);
    foreach($objects as $name => $object){

        if(is_file($name) && $name != '.' && $name[2] != '.' && (strpos($name, 'index.php') == false) ) {
            require_once($name);
        }
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

    $router->get('/me', function() {
        echo json_encode( $_SESSION['user'] );
    });

    // Use controller user and method one



    $router->get(       '/users/:id',   'User.get');

    $router->get(       '/clubs/:id',   'Club.getOne');
    $router->get(       '/clubs',       'Club.getAll');
    $router->get(       '/clubs/:id/stat', 'Club.stat');
    $router->post(      '/clubs',       'Club.create');
    $router->put(       '/club/:id',    'Club.update');
    $router->delete(    '/club/:id',    'Club.delete');

    $router->get(       '/choices/:choice_number', 'Choice.getChoiceOne'    );
    $router->get(       '/choices',     'Choice.getChoiceAll'    );
    $router->post(      '/choices',     'Choice.create' );
    $router->put(       '/choices/',    'Choice.update' );
    $router->delete(    '/choices',     'Choice.deleteAll' );

    $router->get(       '/menu', 'Menu.jsonMenu'    );

/*    $router->get(       '/choice',   function(){
        $choice = new \Models\Choice();
        $choice -> alreadyChoose();
    });*/
    //Exemple de route particulière
    /*$router->get('club/:id-:nom', function($id, $nom) {

    })->with('id', '[0-9]+')->with('nom', '[A-z\-0-9]+');*/


    header('Content-Type: application/json');
    header('Content-Type: text/html; charset=utf-8');
    $router->run();
