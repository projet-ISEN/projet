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
            templateUrl: 'views/home.html'
            controller:  'homeCtrl'
            label: "Informations Globales"

        .when '/candidature/',
            templateUrl: 'views/candidature.html'
            controller:  'candidatureCtrl'
            label: "Candidature"

        .when '/clubs',
            templateUrl: 'views/home.html'
            controller:  'homeCtrl'
            label: "Clubs"

        .when '/clubs/:club_id',
            templateUrl: 'views/club.html'
            controller: 'clubCtrl'
            label: "Club {{clubName}}"

        .when '/contact/:club_id',
            templateUrl: 'views/contactInClub.html'
            controller: 'contactInClubCtrl'
            label: "Contacts de {{club_name}}"

        .when '/addclub',
            templateUrl: 'views/addClub.html'
            controller: 'addClubCtrl'
            label: "Ajout de clubs"

        .when '/administration',
            templateUrl: 'views/administration.html'
            controller: 'administrationCtrl'
            label: "Ajout de clubs"

        .when '/me',
            templateUrl: 'views/myInformations.html'
            controller: 'myInformationsCtrl'
            label: "Moi"

        .when '/manage',
            templateUrl: 'views/evaluatorManageClubs.html'
            controller: 'evaluatorManageClubsCtrl'
            label: "Mes clubs"

        .when '/manage/:club_id',
            templateUrl: 'views/manageClub.html'
            controller: 'manageClubCtrl'
            label: "Gestion du club"

        .otherwise
            redirectTo:'/'


        customTheme = $mdThemingProvider.extendPalette 'blue-grey',
            '500': '#2d323e'

        $mdThemingProvider.definePalette('custom', customTheme);

        $mdThemingProvider.theme('default')
                .primaryPalette('custom')
                .accentPalette('blue-grey')
                .warnPalette('blue-grey')


]

#------------------------------------------------------------------------------
#           BREADCRUMBS SERVICE
#------------------------------------------------------------------------------
###.service 'breadcrumbsService', [
    '$rootScope'
    '$location'
    ($rootScope, $location)->

        breadcrumbs         = []
        breadcrumbsService  = {}
        observerCallbacks   = []

        @getAll = ->
            return breadcrumbs

        @getFirst = ->
            return breadcrumbs[0] or {}

        @registerObserverCallback = (callback)->
            observerCallbacks.push callback

        @notifyObservers = ->
            angular.forEach observerCallbacks, (callback)->
                callback()


        #we want to update breadcrumbs only when a route is actually changed
        #as $location.path() will get updated imediatelly (even if route change fails!)
        $rootScope.$on '$routeChangeSuccess', (event, current) =>
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
            @notifyObservers()
            return

        return @
]

###