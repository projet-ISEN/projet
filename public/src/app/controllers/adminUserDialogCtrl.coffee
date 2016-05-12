angular.module 'app'
.controller 'adminUserDialogCtrl', [
    '$mdDialog'
    '$mdToast'
    '$scope'
    '$club'
    '$project'
    'user'
    '$http'
    ($mdDialog, $mdToast, $scope, $club, $project, user, $http)->

        $scope.user = user

        $scope.closeDialog = ->

            $mdDialog.hide()

        $scope.addClub = ->

            $http(
                method: 'PUT'
                url: "../../api/users/" + user.login
                data:
                    club_id:    $scope.chooseClub.club_id
                    project_id: $scope.chooseProject.project_id

            ).then (res)->          # On success
                if res.data.err?
                    $mdToast.showSimple 'Une erreur est survenue : ' + res.data.err
                else
                    $mdToast.showSimple 'Membre enregistré!'

            , (err)->              # On error
                console.log err if err?


        $http(
            method: 'GET'
            url: "../../api/members/" + user.login

        ).then (res)->          # On success
            $scope.userClubs = res.data
            console.log res.data
        , (err)->              # On error
            console.log err if err?

        $club.all (clubs)->
            $scope.allClubs = clubs

        $project.all (projects)->
            $scope.allProjects = projects
            console.log projects
]
