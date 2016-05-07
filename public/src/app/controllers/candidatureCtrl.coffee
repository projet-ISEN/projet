angular.module 'app'
.controller 'candidatureCtrl', [
    '$user'
    '$mdDialog'
    '$club'
    '$mdToast'
    '$scope'
    '$http'
    ($user, $mdDialog, $club, $mdToast, $scope, $http)->

        # Tableau de choix
        $scope.choices = [{}, {},{}]
        # Default action
        $scope.saveAction = 'post'

        # Delete all choices
        $scope.clearValue = ->
            $scope.choices = []

        # Send choices
        $scope.save = ->

            unless $scope.choices[0]? and $scope.choices[1]? and $scope.choices[2]?
                return $mdToast.show (
                    $mdToast.simple 'Vous devez séléctionner vos choix'
                    .position 'bottom right'
                )

            if $scope.saveAction == 'post'
                post()
            else
                put()

        # Send message to Capisen
        $scope.goCapisen = ->
            $mdDialog.show
                templateUrl: 'directives/dialogCapisen.html'
                clickOutsideToClose: true
                controller: 'capisenDialogCtrl'

        $scope.updateList = (number)->

            for club in $scope.clubs
                if $scope.choices[0]? and club.club_id == ($scope.choices[0]).club_id
                    club.disable = true
                else if $scope.choices[1]? and club.club_id == ($scope.choices[1]).club_id
                    club.disable = true
                else if $scope.choices[2]? and club.club_id == ($scope.choices[2]).club_id
                    club.disable = true
                else
                    club.disable = false



        # Load all clubs
        $club.all (clubs)->

            $scope.clubs = clubs

            # load choices of user
            $http.get '../../api/choices'
            .then (res)->
                # If our user already have choosed
                if res.data.length != 0
                    $scope.choices = []
                    $scope.saveAction = 'put'

                    for choice in res.data
                        for club in $scope.clubs
                            if choice.club_id == club.club_id
                                $scope.choices[choice.choice_number - 1 ] = club

        post = ->

            $http
                method: 'POST'
                url: "../../api/choices"
                headers:
                    'Content-Type': 'application/json'
                data:
                    choices:
                        "1": $scope.choices[0].club_id
                        "2": $scope.choices[1].club_id
                        "3": $scope.choices[2].club_id
            .then (res)->
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Vos choix ont été sauvegardés'
                        .position 'bottom right'
                    )
                    $scope.saveAction = "put"
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
        put = ->
            $http
                method: 'PUT'
                url: "../../api/choices"
                headers:
                    'Content-Type': 'application/json'
                data:
                    choices:
                        "1": $scope.choices[0].club_id
                        "2": $scope.choices[1].club_id
                        "3": $scope.choices[2].club_id
            .then (res)->
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Vos choix ont été modifiés'
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
