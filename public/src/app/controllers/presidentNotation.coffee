angular.module 'app'
.controller 'presidentNotation', [
    '$scope'
    '$club'
    '$routeParams'
    ($scope, $club, $routeParams)->

        $club.getMembers $routeParams.club_id, (members)->
            $scope.members = members
            console.log members



            for member in members
                console.log ''

]