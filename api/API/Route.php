<?php
    
    namespace API;

    /**
     * Class Route
     * @package API
     */
    class Route {
        
        private $path;          // URL de base générique
        private $callback;      // Fonction à appeller
        private $matches = [];  // Paramètre de l'URL réelle
        private $params  = [];  // paramètre particulers -> with

        /**
         * Route constructor.
         * En fonction d'une URI, appelle une fonction
         * @param $path
         * @param $callback
         */
        public function __construct( $path, $callback ) {
                
            $this->path     = trim( $path, '/' );
            $this->callback = $callback;
        }

        /**
         * Vérifie que le route en paramètre correspond au bon pattern
         * @param $url
         * @return bool
         */
        public function match( $url ) {
            
            $url    = trim( $url, '/');
            $path   = preg_replace_callback('#:([\w]+)#', [$this, 'paramMatch'], $this->path);
            $path   = str_replace('/', '\/', $path);
            $regex  = "#^$path$#i";


            if( !preg_match($regex, $url, $this->matches) ) {

                return false;
            }
            else {

                array_shift( $this->matches ); // enlève le premier élément (le path complet)
                return true;
            }
        }

        /**
         * Permet d'utiliser la bonne regexp sur un paramètre
         * @param $match
         * @return string
         */
        private function paramMatch( $match ) {

            if( isset($this->params[$match[1]])) {

                return '(' . $this->params[$match[1]] . ')';
            }
            else {

                return '([^/]+)';
            }
        }

        /**
         * Appelle la fonction de callback de la route en fonction de la route qui match
         * avec comme parametre ceux de l'URL
         * @return mixed
         */
        public function call() {

            if( is_string($this->callback) ) {

                $params     = explode( '.', $this->callback );
                $controller = "\\Controllers\\" . $params[0] ;
                $controller = new $controller( $this->matches );

                return call_user_func_array([$controller, $params[1]], $this->matches );

            } else {

                return call_user_func_array($this->callback, $this->matches);
            }
        }

        /**
         * Permet l'ajout de format de variable personnalisé dans l'URL
         * @param $param
         * @param $regexp
         * @return mixed
         */
        public function with( $param, $regexp ) {

            $this->params[$param] =  str_replace( '(', '(?:', $regexp );
            return $this;
        }

        /**
         * prend l'URL de la route et y ajoute les paramètres
         * @param $params
         * @return mixed|string
         */
        public function getUrl( $params ) {

            $path = $this->path;

            foreach( $params as $k => $v ) {

                $path = str_replace( ':' . $k, $v, $path);
            }
            return $path;
        }
    }
?>