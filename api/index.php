<?php

    $userData["Login"]      = 'rcolli17'; // login
    $userData["Name"]       = ''; // prénom nom
    $userData["FirstName"]  = ''; // prénom
    $userData["LastName"]   = ''; // nom
    $userData["Mail"]       = ''; // mail
    $userData["Telephone"]  = ''; // telephone
    $userData["uidNumber"]  = ''; // numero d'identifiant (pas nécessaire pour vous)
    $userData["gidNumber"]  = ''; // numero de groupe (voir ci-dessous)
    $groupeISEN             = ''; // 'M1'




/*   Permet de faire un require_once de tous les fichier php sauf index.php    */
    $objects = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('./'), RecursiveIteratorIterator::SELF_FIRST);
    foreach($objects as $name => $object){

        if(is_file($name) && $name != '.' && $name[2] != '.' && (strpos($name, 'index.php') == false) ) {
            require_once($name);
        }
    }


    $router = new API\Router( $_GET['url'] );

    $router->get('/users', function() {
        echo 'all users'; 
    });
 
    // Use controller user and method one
    $router->get('/user/:id', 'User.get');

    $router->get( '/club/:id', 'Club.getOne');
    $router->get( '/clubs',     'Club.getAll');
    $router->post('/club',     'Club.create');


    //Exemple de route particulière
    /*$router->get('club/:id-:nom', function($id, $nom) {

    })->with('id', '[0-9]+')->with('nom', '[A-z\-0-9]+');*/



    $router->run();
?>