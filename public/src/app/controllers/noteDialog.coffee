angular.module 'app'
.controller 'noteDialogCtrl', [
    '$scope'
    '$mdDialog'
    ( $scope, $mdDialog ) ->

        $scope.closeDialog = ->
            $mdDialog.hide()
]
