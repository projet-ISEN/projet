angular.module 'app'
.controller 'gestionClubCtrl', [
    '$scope'
    '$note'
    '$routeParams'
    ($scope, $note, $routeParams)->

        $scope.clubId = $routeParams.club_id

        $note.getPassations $scope.clubId , (res)->
            $scope.passations = res
]
