#------------------------------------------------------------------------------
#           ROUTE DISPATCHER
#------------------------------------------------------------------------------

angular.module('app')
.config ['$routeProvider', ($routeProvider)->


        $routeProvider
        .when '/', 
            templateUrl: 'views/home.html',
            controller:  'homeCtrl'
]