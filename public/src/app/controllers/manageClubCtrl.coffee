angular.module 'app'
.controller 'manageClubCtrl', [
    '$mdToast'
    '$scope'
    '$club'
    '$http'
    '$routeParams'
    ($mdToast, $scope, $club, $http, $routeParams)->

        $scope.club = {}

        $club.one $routeParams.club_id, (club) ->
            $scope.club = club
            console.log club



]
