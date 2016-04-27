angular.module("app").controller 'sidenavCtrl', [
  '$scope'
  '$mdSidenav'
  ($scope, $mdSidenav) ->

     $scope.menu = {
        withoutclub : {
            name : ''
      			values : [
              {
                  link: ''
                  title: 'Dashboard'
                  icon: 'face'
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
            name : ''
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
    }
]
