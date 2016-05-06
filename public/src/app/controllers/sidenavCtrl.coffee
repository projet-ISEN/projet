angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  '$location'
  '$rootScope'
  ($scope, $mdSidenav, $menu, $location, $rootScope) ->
    
    $menu.myMenu().then (menu)->

        $scope.menu = menu
        $scope.$apply
        $scope.findActive()

    $scope.collapse = (underpart, $index)->
        i = 0

        underpart.expanded = !underpart.expanded
        angular.forEach $scope.menu, (value, key) ->
            activeInIt = false
            angular.forEach value.values, (item, key) ->
                activeInIt = true if item.active == true
            value.expanded = false if i!=$index and i!=0 and !activeInIt
            i++

        #console.log($location.path())



    $rootScope.$on '$routeChangeSuccess', (event, current) ->
        $scope.findActive()




     $scope.findActive = ->
        #console.log($location.path())
        angular.forEach $scope.menu, (value, key) ->
            angular.forEach value.values, (item, key) ->
                if item.link.indexOf($location.path()) isnt -1
                    item.active = true
                    value.expanded = true
                else
                    #console.log(item.title + " " + item.active)
                    item.active = false
]

