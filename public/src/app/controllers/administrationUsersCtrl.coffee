angular.module 'app'
.controller 'administrationUsersCtrl', [
    '$mdDialog'
    '$scope'
    '$user'
    '$year'
    ($mdDialog, $scope, $user, $year)->

        $user.all (users) ->
            $scope.users = users


        $year.currentYear (year)->

            # fix, this year
            $scope.currentYear = parseInt year
            # possibles years
            $scope.years = [ $scope.currentYear , $scope.currentYear + 1 ]
            # choosing year
            $scope.year = $scope.currentYear

        $scope.showDialog = ( user, year ) ->

            $mdDialog.show
                controller: 'adminUserDialogCtrl'
                templateUrl: 'directives/dialogAdminUser.html'
                parent: angular.element(document.body)
                #targetEvent: ev
                clickOutsideToClose:true
                locals:
                    user: user
                    specificYear: year

            .then (answer)->
                $scope.status = 'Vous avez donné comme réponse: "' + answer + '".';
            , ->
                $scope.status = 'You cancelled the dialog';
]
