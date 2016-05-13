angular.module 'app'
.controller 'recruCapisenCtrl', [
    '$mdToast'
    '$user'
    '$year'
    '$scope'
    ($mdToast, $user, $year, $scope)->

        $year.currentYear (ret) ->
            $scope.year = parseInt(ret)


]
