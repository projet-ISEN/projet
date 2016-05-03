angular.module 'app'
.controller 'clubCtrl', [
    '$scope'
    '$routeParams'
    ($scope, $routeParams)->

        console.log $routeParams.club_name
]
