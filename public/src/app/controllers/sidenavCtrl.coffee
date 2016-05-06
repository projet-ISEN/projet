angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  '$location'
  ($scope, $mdSidenav, $menu, $location) ->
    
    $menu.myMenu().then (menu)->

        $scope.menu = menu
        $scope.$apply
        $scope.menuInit()

    $scope.collapse = (underpart, $index)->
        underpart.expanded = !underpart.expanded
        i = 0
        angular.forEach $scope.menu, (value, key) ->
            value.expanded = false if i!=$index and i!=0
            i++




     $scope.menuInit = ->
        #console.log("menuInit")
        console.log($scope.menu)
        angular.forEach $scope.menu, (value, key) ->
            angular.forEach value.values, (item, key) ->
                #console.log(value.link.indexOf($location.path()))
                if item.link.indexOf($location.path()) isnt -1
                    #console.log(item.link.indexOf($location.path()) + "   " + item.title)
                    console.log(item)
                    item.active = true
                    console.log(item)
                    value.expanded = true
]

