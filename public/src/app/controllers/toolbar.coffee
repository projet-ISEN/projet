angular.module "app"
.controller 'toolbarCtrl', [
  '$scope'
  '$mdSidenav'
  ($scope, $mdSidenav) ->
        
    $scope.toggleSidenav = (menuId) ->
      $mdSidenav(menuId).toggle()


        
]
