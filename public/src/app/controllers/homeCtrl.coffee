#------------------------------------------------------------------------------
#               CONTROLLER DE DEPART
#------------------------------------------------------------------------------

angular.module('app')
.controller 'homeCtrl', ['$user', '$club', '$scope', ($user, $club, $scope)->

    $user.getInfos().then (infos)->
        
        $scope.user = infos
        $scope.$apply
        
    $club.all().then (clubs)->
        
        $scope.clubs = clubs
        $scope.$apply
]