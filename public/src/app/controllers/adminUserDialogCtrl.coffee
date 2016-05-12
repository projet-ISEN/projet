angular.module 'app'
.controller 'adminUserDialogCtrl', [
    '$mdDialog'
    '$scope'
    'user'
    '$http'
    ($mdDialog, $scope, user, $http)->

        $scope.user = user

        $scope.closeDialog = (answer)->
            $mdDialog.hide answer

        $http(
            method: 'GET'
            url: "../../api/members/" + user.login

        ).then (res)->          # On success
            $scope.userClubs = res.data
            console.log res.data
        , (err)->              # On error
            console.log err if err?

]
