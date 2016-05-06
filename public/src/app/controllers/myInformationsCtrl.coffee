angular.module 'app'
.controller 'myInformationsCtrl', [
    '$user'
    '$scope'
    ($user, $scope)->

        $user.me (me)->
            $scope.me = me


]