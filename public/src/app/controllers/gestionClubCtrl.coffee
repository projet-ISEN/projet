angular.module 'app'
.controller 'gestionClubCtrl', [
    '$scope'
    '$mdToast'
    '$note'
    '$routeParams'
    ($scope, $mdToast, $note, $routeParams)->

        $scope.clubId           = $routeParams.club_id
        $scope.passationFiles   = []

        $note.getPassations $scope.clubId , (res)->
            $scope.passations = res

        $scope.send = ->

            formData = new FormData()

            console.log $scope.passationFiles

            formData.append 'file', ($scope.passationFiles[0]).lfFile

            $note.sendPassation $scope.clubId, formData, (res)->
                if res.err?
                    $mdToast.showSimple "Une erreur c'est produite : " + err
                else
                    $mdToast.showSimple "Votre fichier est enregistré !"
]
