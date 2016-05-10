#------------------------------------------------------------------------------
#           ROUTE DISPATCHER
#------------------------------------------------------------------------------

angular.module('app')
.config [
    '$routeProvider'
    '$mdThemingProvider'
    ($routeProvider, $mdThemingProvider)->


        $routeProvider
        .when '/accueil',
            templateUrl: 'views/home.html'
            controller:  'homeCtrl'
            name: "Informations Globales"

        .when '/candidature',
            templateUrl: 'views/candidature.html'
            controller:  'candidatureCtrl'
            name: "Candidature"

        .when '/clubs/:club_name',
            templateUrl: 'views/club.html'
            controller: 'clubCtrl'
            name: "Liste des clubs"

        .when '/contact/:club_id',
            templateUrl: 'views/contactInClub.html'
            controller: 'contactInClubCtrl'
            name: "Contact ?????????"

        .when '/addclub',
            templateUrl: 'views/addClub.html'
            controller: 'addClubCtrl'
            name: "Ajout de clubs"

        .when '/administration',
            templateUrl: 'views/administration.html'
            controller: 'administrationCtrl'
            name: "Ajout de clubs"

        .when '/me',
            templateUrl: 'views/myInformations.html'
            controller: 'myInformationsCtrl'
            name: "Mes informations"

        .when '/manage',
            templateUrl: 'views/evaluator_manageClubs.html'
            controller: 'evaluator_manegeClubsCtrl'
            name: "Mes clubs"

        .otherwise
            redirectTo:'/accueil'


        customTheme = $mdThemingProvider.extendPalette 'blue-grey',
            '500': '#2d323e'

        $mdThemingProvider.definePalette('custom', customTheme);

        $mdThemingProvider.theme('default')
                .primaryPalette('custom')
                .accentPalette('blue-grey')
                .warnPalette('blue-grey')


]


.factory 'breadcrumbsService', [
    '$rootScope'
    '$location'
    ($rootScope, $location)->

        breadcrumbs         = []
        breadcrumbsService  = {}
        observerCallbacks   = []
        #we want to update breadcrumbs only when a route is actually changed
        #as $location.path() will get updated imediatelly (even if route change fails!)
        $rootScope.$on '$routeChangeSuccess', (event, current) ->
            pathElements = $location.path().split('/')
            result = []
            breadcrumbs = []

            breadcrumbPath = (index) ->
                return '/' + pathElements.slice(0, index + 1).join('/')

            pathElements.shift()

            i=0
            while i < pathElements.length
                result.push
                    name: current.name
                    path: breadcrumbPath(i)
                i++
            breadcrumbs = result
            breadcrumbsService.notifyObservers()
            return

        breadcrumbsService.getAll = ->
            return breadcrumbs

        breadcrumbsService.getFirst = ->
            return breadcrumbs[0] or {}

        breadcrumbsService.registerObserverCallback = (callback)->
            observerCallbacks.push callback

        breadcrumbsService.notifyObservers = ->
            angular.forEach observerCallbacks, (callback)->
                callback()

        return breadcrumbsService
]
