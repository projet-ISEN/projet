#------------------------------------------------------------------------------
#               CONTROLLER DE DEPART
#------------------------------------------------------------------------------

angular.module('app')
.controller 'homeCtrl', [
    '$club'
    '$scope'
    ($club, $scope)->

        $club.all().then (clubs)->

            $scope.clubs = clubs
            $scope.$apply
]
