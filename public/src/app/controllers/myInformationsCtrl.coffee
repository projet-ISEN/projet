angular.module 'app'
.controller 'myInformationsCtrl', [
    '$mdToast'
    '$user'
    '$scope'
    ($mdToast, $user, $scope)->

        $user.me (me)->
            $scope.me = me

        $scope.save = ->
            $user.save $scope.me, (res)->
                ######console.log res
                if res.err?
                    $mdToast.show(
                        $mdToast.simple()
                        .textContent 'Un problème est survenu'
                        .position 'bottom right'
                    )
                else
                    $mdToast.show(
                        $mdToast.simple()
                        .textContent 'Données sauvegardées !'
                        .position 'bottom right'
                    )

]
