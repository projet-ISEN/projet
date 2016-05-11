angular.module 'app'
.controller 'evaluatorManageClubsCtrl', [
    '$mdToast'
    '$scope'
    '$club'
    '$http'
    ($mdToast, $scope, $club, $http)->


        #répétition de code mais fonctionnel
        $club.evaluatorClub (clubs)->
            $scope.clubsActif = clubs.filter (e) ->
                e.actif == "1"

            $scope.clubsInactive = clubs.filter (e) ->
                e.actif == "0"

            angular.forEach $scope.clubsActif, (value, key) ->
                $club.stat $scope.clubsActif[key].club_id, (stats)->
                    $scope.clubsActif[key].stats = stats.members

            angular.forEach $scope.clubsInactive, (value, key) ->
                $club.stat $scope.clubsInactive[key].club_id, (stats)->
                    $scope.clubsInactive[key].stats = stats.members






]
