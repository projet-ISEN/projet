angular.module 'app'
.controller 'capisenDialogCtrl', [
    '$scope'
    '$mdDialog'
    ( $scope, $mdDialog ) ->

        $scope.closeDialog = ->
            $mdDialog.hide()
]
