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


    $objects = new RecursiveIteratorIterator(new RecursiveDirectoryIterator("."), RecursiveIteratorIterator::SELF_FIRST);
    foreach($objects as $name => $object){
        if($name !="index.php") require_once ($name);
    }


/*    require( 'vendor/autoload.php' );// composer, on l'a enlevé*/

    $router = new API\Router( $_GET['url'] );

    $router->get('/users', function() {
        echo 'all users'; 
    });

    // Use controller user and method one
    $router->get('/users/:id', 'User.get');

    $router->get('/clubs', 'Club.all');

    //Exemple de route particulière
    /*$router->get('club/:id-:nom', function($id, $nom) {

    })->with('id', '[0-9]+')->with('nom', '[A-z\-0-9]+');*/



    $router->run();
?>