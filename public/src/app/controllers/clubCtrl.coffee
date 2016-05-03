angular.module 'app'
.controller 'clubCtrl', [
    '$scope'
    '$club'
    '$routeParams'
    ($scope, $club, $routeParams)->

        $scope.club = {}

        $club.getByName $routeParams.club_name, (club) ->
            $scope.club = club
            console.log club

            $club.stat club.club_id, (stat) ->
                $scope.club.stat = stat
                console.log stat

]
