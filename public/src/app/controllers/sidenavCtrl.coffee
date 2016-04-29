angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  '$menu'
  ($scope, $mdSidenav, $menu) ->
    
    $menu.myMenu().then (menu)->

        $scope.menu = menu
        $scope.$apply


]
###    $scope.menu = {
        withoutclub : {
            name : ''
            expanded : true
      			values : [
              {
                  link: ''
                  title: 'Dashboard'
                  icon: 'dashboard'
              }
              {
                  link: ''
                  title: 'Friends'
                  icon: 'group'
              }
              {
                  link: ''
                  title: 'Friends'
                  icon: 'group'
              }
              {
                  link: ''
                  title: 'Friends'
                  icon: 'group'
              }
              {
                  link: ''
                  title: 'Messages'
                  icon: 'message'
              }
            ]
        }
    
        moviezen : {
            name : 'Moviezen'
            expanded : false
      			values : [
              {
                  link: ''
                  title: 'Dashboard'
                  icon: 'dashboard'
              }
              {
                  link: ''
                  title: 'Friends'
                  icon: 'group'
              }
              {
                  link: ''
                  title: 'Messages'
                  icon: 'message'
              }
        		]
        }

        evaluator : {
            name : 'Evaluateur'
            expanded : false
      			values : [
              {
                  link: ''
                  title: 'Dashboard'
                  icon: 'dashboard'
              }
              {
                  link: ''
                  title: 'Friends'
                  icon: 'group'
              }
              {
                  link: ''
                  title: 'Messages'
                  icon: 'message'
              }
        		]
        }
    }###
