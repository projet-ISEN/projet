<?php
    
    namespace API;

    /**
     * Class RouterException
     * @package API
     */
    class RouterException extends \Exception {

        // Permet d'effectuer une action si aucune des routes n'a matché.
        // Parce que le Router throw une nouvelle exception
    }
?>