angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  '$location'
  ($scope, $mdSidenav, $menu, $location) ->
    
    $menu.myMenu().then (menu)->

        $scope.menu = menu
        $scope.$apply

    $scope.collapse = (underpart, $index)->
        #console.log(underpart + " " + $index)
        underpart.expanded = !underpart.expanded


     $scope.menuInit = ->
        console.log($scope.menu)
        angular.forEach $scope.menu, (value, key) ->
            angular.forEach value.values, (item, key) ->
                #console.log(value.link.indexOf($location.path()))

                if item.link.indexOf($location.path()) isnt -1
                    console.log(item.link.indexOf($location.path()) + "   " + item.title)
                    item.active = true
                    value.expanded = true
]

