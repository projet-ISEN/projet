angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  '$location'
  '$rootScope'
  ($scope, $mdSidenav, $menu, $location, $rootScope) ->
    

    $scope.pageNumber = 0;
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

    $rootScope.$on '$routeChangeSuccess', (event, current) ->
        $scope.findActive()

     $scope.findActive = ->
        i = 0
        angular.forEach $scope.menu, (value, key) ->
            value.expanded = false if i!=0
            i++
            angular.forEach value.values, (item, key) ->

                if item.link.indexOf($location.path()) isnt -1

                    console.log $location.path() + ' ' + item.link

                    item.active = true
                    value.expanded = true

                    # Exception for just / url
                    if $location.path() == '/' and item.link != '#/'
                        item.active = false
                else
                    item.active = false
]

