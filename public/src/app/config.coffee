#------------------------------------------------------------------------------
#           ROUTE DISPATCHER
#------------------------------------------------------------------------------

angular.module('app')
.config ['$routeProvider', ($routeProvider)->


        $routeProvider
        .when '/', 
            templateUrl: 'views/home.html',
            controller:  'homeCtrl'
        .when '/candidature',
            templateUrl: 'views/candidature.html',
            controller:  'candidatureCtrl'
        .otherwise({redirectTo:'/'})
]
