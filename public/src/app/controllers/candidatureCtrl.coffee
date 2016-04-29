angular.module 'app'
.controller 'candidatureCtrl', [ '$user'
    '$club'
    '$mdToast'
    '$scope'
    '$http'
    ($user, $club, $mdToast, $scope, $http)->

        $scope.choices = []

        # Delete all choices
        $scope.clearValue = ->
            $scope.choices = []

        # This club is already choose
        $scope.isDisabled = (club)->
            club.hide = ($scope.choices.indexOf(club) != -1)

        # Send choices
        $scope.save = ->

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
                unless res.err?
                    return $mdToast.showSimple 'Vos choix ont été sauvegardés'

                console.log res.err
                return $mdToast.showSimple "Une erreur est survenue"

            , (err)->
                    console.log err
                    return $mdToast.showSimple "impossible de contacter le serveur"

        # Send message to Capisen
        $scope.goCapisen = ->
            alert "Prévenons Capisen !"

        # Load select input with clubs
        $club.all().then (clubs)->

            $scope.clubs = clubs

            $scope.clubs = $scope.clubs.filter (elem, index)->
                return elem.club_name != 'Capisen'

            $scope.$apply
]
