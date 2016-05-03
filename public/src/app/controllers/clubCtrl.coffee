angular.module 'app'
.controller 'clubCtrl', [
    '$scope'
    '$club'
    '$routeParams'
    ($scope, $club, $routeParams)->

        console.log $routeParams.club_name

        $club.getByName $routeParams.club_name, (club)->
            $scope.club = club
            console.log $scope.club


]
