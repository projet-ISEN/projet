angular.module "app"
.controller 'toolbarCtrl', [
    '$user'
    '$mdSidenav'
    'breadcrumbsService'
    '$scope'
    '$location'
    ($user, $mdSidenav, breadcrumbsService, $scope, $location) ->

        $scope.toggleSidenav = (menuId) ->
            $mdSidenav(menuId).toggle()

        $scope.crumbs = breadcrumbsService.getAll()

        breadcrumbsService.registerObserverCallback ->

            $scope.crumbs = breadcrumbsService.getAll()

        $user.me (me)->

            $scope.me = me

        $scope.goToProfile = ->
            $location.url '/moi'
]
