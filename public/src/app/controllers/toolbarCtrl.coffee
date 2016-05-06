angular.module "app"
.controller 'toolbarCtrl', [
    '$user'
    '$mdSidenav'
    'breadcrumbsService'
    '$scope'
    ($user, $mdSidenav, breadcrumbsService, $scope) ->

        $scope.toggleSidenav = (menuId) ->
            $mdSidenav(menuId).toggle()

        $scope.crumbs = breadcrumbsService.getAll()

        breadcrumbsService.registerObserverCallback ->

            $scope.crumbs = breadcrumbsService.getAll()

        $user.me (me)->

            $scope.me = me
]
