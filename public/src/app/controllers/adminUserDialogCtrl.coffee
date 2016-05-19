angular.module 'app'
.controller 'adminUserDialogCtrl', [
    '$mdDialog'
    '$mdToast'
    '$scope'
    '$year'
    '$club'
    '$project'
    '$member'
    '$choice'
    'user'
    'specificYear'
    ($mdDialog, $mdToast, $scope, $year, $club, $project, $member, $choice, user, specificYear)->

        $scope.user = user

        $year.currentYear (year)->
            # Année courante
            $scope.currentYear = parseInt year
            console.log 'current: ' + typeof $scope.currentYear
            console.log 'asked: '   + typeof specificYear
            # Es-ce cette année
            $scope.forThisYear = specificYear == $scope.currentYear
            console.log 'this year? ' + (specificYear == $scope.currentYear)

        $scope.closeDialog = ->
            $mdDialog.hide()


        $scope.addClub = ->

            unless $scope.chooseProject?
                    $scope.chooseProject.project_id = ''

            if $scope.forThisYear
                # Si pour l'annee courante

                $member.add user.login, $scope.chooseClub.club_id, $scope.chooseProject.project_id, (res)->
                    if res.err?
                        $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                        .position 'bottom right'
                    else
                        $mdToast.showSimple 'Membre enregistré !'
                        .position 'bottom right'
                        displayAll()
            else
                # Pour une autre année
                $member.addNextYear user.login, $scope.chooseClub.club_id, $scope.chooseProject.project_id, specificYear, (res)->
                    if res.err?
                        $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                        .position 'bottom right'
                    else
                        $mdToast.showSimple 'Membre enregistré !'
                        .position 'bottom right'

                        $choice.delete user.login, (res)->
                            if res.err?
                                $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                                .position 'bottom right'
                            else
                                $mdToast.showSimple 'Choix supprimés!'
                                .position 'bottom right'



                        displayAll()

        $scope.switchMain = (index)->
            newMain = $scope.userMembers[index]
            console.log newMain
            $member.setMain user.login, newMain.club_id, (res)->

                if res.err?
                    $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                    .position 'bottom right'
                else
                    $mdToast.showSimple 'Club principal changé !'
                    .position 'bottom right'
                    displayAll()

        $scope.delete = (member)->
            console.log member
            $member.delete member.login, member.club_id, specificYear, (res)->
                if res.err?
                    $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                    .position 'bottom right'
                else
                    $mdToast.showSimple "Le membre n'est plus dans le club"
                    .position 'bottom right'
                    displayAll()


        displayAll = ->

            $member.oneWithYear user.login, specificYear, (members)->
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
        displayAll()
]
