angular.module 'app'
.controller 'candidatureCtrl', ['$user'
    '$club'
    '$scope'
    '$http'
    ($user, $club, $scope, $http)->

        $scope.choices = []

        # Delete all choices
        $scope.clearValue = ->

            $scope.choices = []

        # This club is already choose
        $scope.isDisabled = (club)->

            club.hide = ($scope.choices.indexOf(club) != -1)

            if club.club_name == 'Capisen'
                club.hide = true

        # Send choices
        $scope.save = ->

            data =
                "1": $scope.choices[0]
                "2": $scope.choices[1]
                "3": $scope.choices[2]

            $http
                url: "../../api/choices"
                data: data
                headers:
                    'Content-Type': 'application/json'

            .then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null

        # Send message to Capisen
        $scope.goCapisen = ->
            alert "Prévenons Capisen !"

        # Load select input with clubs
        $club.all().then (clubs)->

            $scope.clubs = clubs

            $scope.$apply
]
