angular.module 'app'
.controller 'addClubCtrl', [
    '$mdToast'
    '$scope'
    '$http'
    ($mdToast, $scope, $http)->

        $scope.clubName = ""
        $scope.login = ""
        $scope.description = ""
        $scope.email = ""

        $scope.clearValue = ->
            $scope.clubName = ""
            $scope.login = ""
            $scope.description = ""
            $scope.email = ""

        $scope.create = ->
            if $scope.clubName==""
                return $mdToast.show (
                    $mdToast.simple 'Vous devez renseigner le nom du club'
                    .position 'bottom right'
                )
            else
                post()


        post = ->

            $http
                method: 'POST'
                url: "../../api/clubs"
                headers:
                    'Content-Type': 'application/json'
                data:
                    club_name: $scope.clubName
                    login_evaluator: $scope.login
                    club_description: $scope.description
                    club_mail: $scope.email
            .then (res)->
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Le club a bien été créé'
                        .position 'bottom right'
                    )
                else
                    console.log res.data.err
                    $mdToast.show(
                        $mdToast.simple "Une erreur est survenue: #{res.data.err}"
                        .position 'bottom right'
                    )

            , (err)->
                    console.log err
                    $mdToast.show(
                        $mdToast.simple "Impossible de contacter le serveur"
                        .position 'bottom right'
                    )

]
