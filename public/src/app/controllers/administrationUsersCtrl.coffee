angular.module 'app'
.controller 'administrationUsersCtrl', [
    '$mdDialog'
    '$scope'
    '$user',
    ($mdDialog, $scope, $user)->

        $user.all (users) ->
            $scope.users = users
    


        $scope.showDialog = ( user ) ->
            $mdDialog.show
                controller: 'adminUserDialogCtrl'
                templateUrl: 'directives/dialogAdminUser.html'
                parent: angular.element(document.body)
                #targetEvent: ev
                clickOutsideToClose:true
                locals:
                    user: user

            .then (answer)->
                $scope.status = 'You said the information was "' + answer + '".';
            , ->
                $scope.status = 'You cancelled the dialog.';
]