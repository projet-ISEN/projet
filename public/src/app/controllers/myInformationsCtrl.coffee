angular.module 'app'
.controller 'myInformationsCtrl', [
    '$user'
    '$scope'
    ($user, $scope)->

        $user.me (me)->
            $scope.me = me

        $scope.save = ->
            $user.save $scope.me, (res)->
                console.log res
]
