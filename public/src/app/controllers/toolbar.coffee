angular.module "app"
.controller 'toolbarCtrl', [
  '$scope'
  '$mdSidenav'
  'breadcrumbsService'
  ($scope, $mdSidenav, breadcrumbsService) ->

    $scope.toggleSidenav = (menuId) ->
      $mdSidenav(menuId).toggle()

    $scope.crumbs = breadcrumbsService.getAll()

    breadcrumbsService.registerObserverCallback ->

        $scope.crumbs = breadcrumbsService.getAll()
        console.log breadcrumbsService.getAll()
]
