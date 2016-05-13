angular.module 'app'
.controller 'presidentNotation', [
    '$scope'
    '$club'
    ($scope, $club)->


        $club.getMembers obj.club_id, (members)->
            $scope.changeClub.member = members
            console.log members

]