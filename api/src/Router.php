<?php

    namespace API;

    /**
     * Class Router
     * @package API
     */
    class Router {
        
        private $url;
        private $routes         = [];
        private $namedRoutes    = [];

        /**
         * Router constructor.
         * @param $url
         */
        public function __construct( $url ) {
            
            $this->url = $url;
        }

        /**
         * Cherche la fonction a appeller en fonction de l'URL
         * @return mixed
         */
        public function run() {


            if (empty($this->routes[$_SERVER['REQUEST_METHOD']])) {

                throw new RouterException('no HTTP method found');
            }

            $method = $_SERVER['REQUEST_METHOD'];

            foreach ($this->routes[$method] as $route) {

                if ($route->match($this->url)) {

                    return $route->call();
                }
            }

            throw new RouterException( 'No matching route with method: ' . $method . " and url: " . $this->url );
        }

        /**
         * Renvoi une URL chargée avec les paramètres donnés
         * @param       $name
         * @param array $params
         *
         * @return mixed
         * @throws RouterException
         */
        public function url( $name, $params = [] ) {

            if( !isset($this->namedRoutes[$name])) {

                throw new RouterException( 'No matching named route ' . $name );
            }
            return $this->namedRoutes[$name]->getUrl( $params );
        }

        /*#######################################################

        Permet la déclaration d'une route

        #######################################################*/


        /**
         * Add a route,
         * @param $path
         * @param $callback
         * @param $name
         * @param $method
         * @return Route
         */
        public function add( $path, $callback, $name, $method ) {

            $route                      = new Route( $path, $callback );
            $this->routes[$method][]    = $route;

            if( is_string($callback) && $name === null ) {

                $name = $callback;
            }

            if( $name ) {
                $this->namedRoutes[$name] = $route;
            }
            return $route;
        }

        /**
         * @param $path
         * @param $callback
         * @param null $name
         * @return Route
         */
        public function get($path, $callback, $name = null ) {

            return $this->add($path, $callback, $name, 'GET');
        }

        /**
         * @param $path
         * @param $callback
         * @param null $name
         * @return Route
         */
        public function post($path, $callback, $name = null ) {

            return $this->add($path, $callback, $name, 'POST');
        }

        /**
         * @param $path
         * @param $callback
         * @param null $name
         * @return Route
         */
        public function put($path, $callback, $name = null ) {

            return $this->add($path, $callback, $name, 'PUT');
        }

        /**
         * @param $path
         * @param $callback
         * @param null $name
         * @return Route
         */
        public function delete( string $path, callable $callback, string $name = null ):Route {

            return $this->add($path, $callback, $name, 'DELETE');
        }
    }
?>