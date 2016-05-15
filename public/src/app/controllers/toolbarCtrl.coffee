angular.module "app"
.controller 'toolbarCtrl', [
    '$user'
    '$mdSidenav'
    'crumble'
    '$scope'
    '$rootScope'
    ($user, $mdSidenav, crumble, $scope, $rootScope) ->

        $scope.toggleSidenav = (menuId) ->
            $mdSidenav(menuId).toggle()

        $user.me (me)->
            $scope.me = me

        $rootScope.$on '$routeChangeSuccess', ->
            crumble.update()
            $scope.crumbles = crumble.trail
]
