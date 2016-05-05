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

    $scope.collapse = (underpart)->
        underpart.expanded = !underpart.expanded
        angular.forEach underpart.values, (item, key) ->
            console.log(item)



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

