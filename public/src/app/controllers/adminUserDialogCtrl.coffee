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
    ($mdDialog, $mdToast, $scope, $club, $project, $member, user)->

        $scope.user = user

        $scope.closeDialog = ->

            $mdDialog.hide()

        $scope.addClub = ->

            $member.add user.login, $scope.chooseClub.club_id, $scope.chooseProject.project_id, (res)->
                if res.err?
                    $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                else
                    $mdToast.showSimple 'Membre enregistré!'

        $scope.switchActif = (index)->
            newActif = $scope.userMembers[index]
            console.log newActif
            
            

        $member.one user.login, (members)->
            $scope.userMembers = members
            
            $club.all (clubs)->
                $scope.allClubs = clubs

                angular.forEach $scope.allClubs, (club, key)->
                    for member in members
                        if club.club_id == member.club_id
                            member.club_name = club.club_name

            $project.all (projects)->
                $scope.allProjects = projects

                angular.forEach $scope.allProjects, (project, key)->
                    for member in members
                        if project.project_id == member.project_id
                            member.project_name = project.project_type
]
