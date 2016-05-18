<?php
    
    namespace API;

    /**
     * Class Route
     * @package API
     */
    class Route {

        /**
         * Url regExp of route
         * @var string
         */
        private $path;          // URL de base générique
        /**
         * Function to call if it's this route
         * @var
         */
        private $callback;      // Fonction à appeller
        /**
         * Url Get variables
         * @var array
         */
        private $matches = [];  // Paramètre de l'URL réelle
        /**
         * Cutom params format
         * @var array
         */
        private $params  = [];  // paramètre particulers -> with

        /**
         * Route constructor.
         * En fonction d'une URI, appelle une fonction
         * @param $path
         * @param $callback
         */
        public function __construct( $path, $callback )
        {
            $this->path     = trim( $path, '/' );
            $this->callback = $callback;
        }

        /**
         * Check if the route have the good pattern
         * @param $url
         * @return bool
         */
        public function match( $url )
        {
            $url    = trim( $url, '/');
            $path   = preg_replace_callback('#:([\w]+)#', [$this, 'paramMatch'], $this->path);
            $path   = str_replace('/', '\/', $path);
            $regex  = "#^$path$#i";

            if( !preg_match($regex, $url, $this->matches) )
            {
                return false;
            }
            else {
                array_shift( $this->matches ); // enlève le premier élément (le path complet)
                return true;
            }
        }

        /**
         * use to take good regExp on params
         * @param $match
         * @return string
         */
        private function paramMatch( $match )
        {
            if( isset($this->params[$match[1]])) {

                return '(' . $this->params[$match[1]] . ')';
            }
            else {

                return '([^/]+)';
            }
        }

        /**
         * Call the callback function of the route
         * avec comme parametre ceux de l'URL
         * @return mixed
         */
        public function call()
        {
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
         * use to specify a custom format for params
         * @param $param
         * @param $regexp
         * @return mixed
         */
        public function with( $param, $regexp )
        {
            $this->params[$param] =  str_replace( '(', '(?:', $regexp );
            return $this;
        }

        /**
         * Take a route and add matching params
         * @param $params
         * @return mixed|string
         */
        public function getUrl( $params )
        {
            $path = $this->path;
            foreach( $params as $k => $v ) {

                $path = str_replace( ':' . $k, $v, $path);
            }
            return $path;
        }
    }
?>