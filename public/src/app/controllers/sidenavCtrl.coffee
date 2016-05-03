angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  ($scope, $mdSidenav, $menu) ->
    
    $menu.myMenu().then (menu)->

        $scope.menu = menu
        $scope.$apply


]
