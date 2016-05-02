angular.module 'app'
.controller 'candidatureCtrl', [
    '$user'
    '$mdDialog'
    '$club'
    '$mdToast'
    '$scope'
    '$http'
    ($user, $mdDialog, $club, $mdToast, $scope, $http)->

        $scope.choices = []
        #default action
        $scope.saveAction = 'post'

        # Delete all choices
        $scope.clearValue = ->
            $scope.choices = []

        # This club is already choose
        $scope.isDisabled = (club)->
            club.hide = ($scope.choices.indexOf(club) != -1)

        # Send choices
        $scope.save = ->
            if $scope.saveAction == 'post'
                post()
            else
                put()

        # Send message to Capisen
        $scope.goCapisen = ->
            $mdDialog.show( $mdDialog.alert()
                .htmlContent 'views/dialogCapisen.html'
                .ok('OK!')
            )


        # Load select input with clubs
        $club.all().then (clubs)->

            $scope.clubs = clubs
            $scope.clubs = $scope.clubs.filter (elem, index)->
                return elem.club_name != 'Capisen'
            $scope.$apply

            # load choices of user
            $http.get '../../api/choices'
            .then (res)->
                # If our user doesn't have choose
                if res.data.length != 0
                    $scope.choices = []
                    $scope.saveAction = 'put'

                    for choice in res.data
                        for club in $scope.clubs
                            if choice.club_id == club.club_id
                                $scope.choices[choice.choice_number - 1 ] = club


                    $scope.$apply




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
                    $mdToast.showSimple 'Vos choix ont été sauvegardés'
                    $scope.saveAction = "put"
                else
                    console.log res.data.err
                    $mdToast.showSimple "Une erreur est survenue: #{res.data.err}"

            , (err)->
                    console.log err
                    $mdToast.showSimple "impossible de contacter le serveur"
        put  = ->

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
                    $mdToast.showSimple 'Vos choix ont été modifiés'

                else
                    console.log res.data.err
                    $mdToast.showSimple "Une erreur est survenue: #{res.data.err}"

            , (err)->
                    console.log err
                    $mdToast.showSimple "impossible de contacter le serveur"
]
