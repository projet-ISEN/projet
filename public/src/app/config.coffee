#------------------------------------------------------------------------------
#           ROUTE DISPATCHER
#------------------------------------------------------------------------------

angular.module('app')
.config [
    '$routeProvider'
    '$mdThemingProvider'
    ($routeProvider, $mdThemingProvider)->


        $routeProvider
        .when '/',
            templateUrl: 'views/home.html',
            controller:  'homeCtrl'
        .when '/candidature',
            templateUrl: 'views/candidature.html',
            controller:  'candidatureCtrl'
        .otherwise
            redirectTo:'/'



        $mdThemingProvider.theme('default')
        .primaryPalette('red')
        .accentPalette('blue')
        .warnPalette('red')
        #.backgroundPalette('red')
]
