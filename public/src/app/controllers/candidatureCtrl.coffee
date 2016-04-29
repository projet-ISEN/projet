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

        # Send choices
        $scope.save = ->

            $http.post "../../api/choices", $scope.choices

            .then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null

        # This club is already choose
        $scope.isDisabled = (club)->

            club.hide = ($scope.choices.indexOf(club) != -1)

            if club.club_name == 'Capisen'
                club.hide = true

        # Send message to Capisen
        $scope.goCapisen = ->
            alert "Prévenons Capisen !"

        # Load select input with clubs
        $club.all().then (clubs)->

            $scope.clubs = clubs

            $scope.$apply
]
