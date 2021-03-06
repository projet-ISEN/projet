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
            templateUrl:    'views/home.html'
            controller:     'homeCtrl'
            label:          ''

        .when '/clubs',
            templateUrl:    'views/home.html'
            controller:     'homeCtrl'
            label:          'Liste des clubs'

        .when '/clubs/addclub',
            templateUrl:    'views/addClub.html'
            controller:     'addClubCtrl'
            label:          'Ajout de clubs'

        .when '/clubs/:club_id',
            templateUrl:    'views/club.html'
            controller:     'clubCtrl'
            label:          'Ce club'

        .when '/clubs/:club_id/contact',
            templateUrl:    'views/contactInClub.html'
            controller:     'contactInClubCtrl'
            label:          'Contacts'

        .when '/clubs/:club_id/notation',
            templateUrl:    'views/presidentNotation.html'
            controller:     'presidentNotation'
            label:          'Evaluation'

        .when '/candidature',
            templateUrl:    'views/candidature.html'
            controller:     'candidatureCtrl'
            label:          'Candidature'

        .when '/passation/:club_id',
            templateUrl:    'views/passation.html'
            controller:     'passationCtrl'
            label:          'Dossiers de passation'

        .when '/nextyear/:club_id',
            templateUrl:    'views/nextYear.html'
            controller:     'nextYearCtrl'
            label:          'Année prospéctive'

        .when '/administration',
            templateUrl:    'views/administration.html'
            controller:     'administrationCtrl'
            label:          'Administration'

        .when '/evaluatorsOfClubs',
            templateUrl:    'views/evaluatorsOfClubs.html'
            controller:     'evaluatorsOfClubsCtrl'
            label:          'Gestion des évaluateurs de club'

        .when '/adminAffectation',
            templateUrl:    'views/adminAffectation.html'
            controller:     'adminAffectationCtrl'
            label:          'Affectation automatique'

        .when '/adminUsers',
            templateUrl:    'views/administrationUsers.html'
            controller:     'administrationUsersCtrl'
            label:          'Administration des utilisateurs'

        .when '/me',
            templateUrl:    'views/myInformations.html'
            controller:     'myInformationsCtrl'
            label:          'Mes informations'

        .when '/manage',
            templateUrl:    'views/evaluatorManageClubs.html'
            controller:     'evaluatorManageClubsCtrl'
            label:          'Gestion des clubs'

        .when '/manageBDE',
            templateUrl:    'views/manageBDE.html'
            controller:     'manageBDECtrl'
            label:          'Gestion des clubs'

        .when '/manage/:club_id',
            templateUrl:    'views/manageClub.html'
            controller:     'manageClubCtrl'
            label:          'Gestion du club'

        .when '/gestion/:club_id',
            templateUrl:    'views/gestionClub.html'
            controller:     'gestionClubCtrl'
            label:          'Gestion du club'


        .when '/recruCapisen',
            templateUrl:    'views/recruCapisen.html'
            controller:     'recruCapisenCtrl'
            label:          'Recrutement'

        .otherwise
            redirectTo:'/'


        customTheme = $mdThemingProvider.extendPalette 'blue-grey',
            '500': '#2d323e'

        $mdThemingProvider.definePalette 'custom', customTheme

        $mdThemingProvider.theme 'default'
                .primaryPalette 'custom'
                .accentPalette  'green'
                .warnPalette    'red'


]

.controller 'footerCtrl', [
    '$scope'
    '$mdDialog'
    ($scope, $mdDialog)->


        $scope.openDialog = ->
            $mdDialog.show(
                $mdDialog.alert()
                .title 'Informations sur vos données privées'
                .textContent "Les données ne seront traitées que dans le but de vous permettre d'utiliser divers outils à vocation informative, d'effectuer les démarches administratives demandées et de recevoir de l'information sur les outils et services proposés"
                .ok "OK"

            )
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

