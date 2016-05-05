angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  ($scope, $mdSidenav, $menu) ->
    
    $menu.myMenu().then (menu)->

        $scope.menu = menu
        $scope.$apply

    $scope.collapse = (underpart, $index)->
        #console.log(underpart + " " + $index)
        underpart.expanded = !underpart.expanded

        #console.log($scope.menu)
        i = 0;
        angular.forEach $scope.menu, (value, key) ->
            #console.log(value) if i==$index
            value.expanded = false if i!=$index and i!=0
            i++
]

