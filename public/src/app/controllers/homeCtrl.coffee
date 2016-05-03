#------------------------------------------------------------------------------
#               CONTROLLER DE DEPART
#------------------------------------------------------------------------------

angular.module('app')
.controller 'homeCtrl', [
    '$club'
    '$scope'
    ($club, $scope)->

        $club.all (clubs)->

            $scope.clubs = clubs
]
