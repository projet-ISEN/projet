#------------------------------------------------------------------------------
#               CONTROLLER DE DEPART
#------------------------------------------------------------------------------

angular.module('app')
.controller 'homeCtrl', ['$user', '$scope', ($user, $scope)->

    $user.getInfos().then (infos)->
        
        console.log infos
        $scope.user = infos
        $scope.$apply
]