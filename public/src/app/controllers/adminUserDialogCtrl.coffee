angular.module 'app'
.controller 'adminUserDialogCtrl', [
    '$mdDialog'
    '$mdToast'
    '$scope'
    '$club'
    '$project'
    '$member'
    'user'
    '$http'
    ($mdDialog, $mdToast, $scope, $club, $project, $member,user)->

        $scope.user = user

        $scope.closeDialog = ->

            $mdDialog.hide()

        $scope.addClub = ->

            $member.set user.login, $scope.chooseClub.club_id, $scope.chooseProject.project_id, (res)->
                if res.err?
                    $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                else
                    $mdToast.showSimple 'Membre enregistré!'


        $member.one user.login, (clubs)->
            $scope.userClubs = clubs

        $club.all (clubs)->
            $scope.allClubs = clubs

        $project.all (projects)->
            $scope.allProjects = projects
]
