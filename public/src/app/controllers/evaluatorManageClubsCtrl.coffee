angular.module 'app'
.controller 'evaluatorManageClubsCtrl', [
    '$mdToast'
    '$scope'
    '$note'
    '$club'
    '$user'
    '$role'
    '$project'
    '$http'
    '$mdSidenav'
    '$mdDialog'
    ($mdToast, $scope, $note, $club, $user, $role, $project, $http, $mdSidenav, $mdDialog)->


        $project.all (projects)->
            $scope.projects = projects

        $scope.tot = ->
            $scope.totalMb = 0
            angular.forEach $scope.changeClub.member, (value, key) ->
                $scope.totalMb += value.member_mark
            $scope.changeClub.totalClub = $scope.changeClub.member.length * $scope.changeClub.mark




        $scope.intelsClub = ->
            $club.evaluatorClub (clubs)->


                $scope.clubsActif = clubs.filter (e) ->
                    e.actif == "1"

                $scope.clubsInactive = clubs.filter (e) ->
                    e.actif == "0"

                angular.forEach $scope.clubsActif, (value, key) ->
                    $club.stat $scope.clubsActif[key].club_id, (stats)->
                        $scope.clubsActif[key].stats = stats.members

                angular.forEach $scope.clubsInactive, (value, key) ->
                    $club.stat $scope.clubsInactive[key].club_id, (stats)->
                        $scope.clubsInactive[key].nbMember = stats.members

        $scope.intelsClub()



        $scope.giveMark = ->
            #console.log $scope.changeClub.mark
            $note.clubmark $scope.changeClub.mark, $scope.changeClub.club_id, (bool)->

                $note.noteStudent $scope.changeClub.member, (ret) ->
                    if ret != "0" and bool != '0'
                        $mdToast.show(
                            $mdToast.simple 'Les notes ont bien été enregistrées'
                            .position 'bottom right'
                        )
                    else
                        $mdToast.show(
                            $mdToast.simple 'Un problème est survenue'
                            .position 'bottom right'
                        )

            #angular.forEach $scope.changeClub.member, (value, key) ->
                #console.log value.member_mark



        $scope.Club2student = ->
            angular.forEach $scope.changeClub.member, (value, key) ->
                value.member_mark = $scope.changeClub.mark
            $scope.tot()




        $scope.infoNote = ->
           $mdDialog.show
                templateUrl: 'directives/noteDialog.html'
                clickOutsideToClose: true
                controller: 'noteDialogCtrl'



        $scope.updatePrez = ->
            console.log $scope.updatePrezChoice
            $role.pushPrez $scope.updatePrezChoice.login, $scope.changeClub.club_id, (bool)->
                console.log "retour de la fonction de changement de président: " + bool
                if bool != "0"
                    $mdToast.show(
                        $mdToast.simple 'Le président a bien été enregistré'
                        .position 'bottom right'
                    )
                else
                    $mdToast.show(
                        $mdToast.simple 'Un problème est survenue'
                        .position 'bottom right'
                    )
            return


        $scope.toggleMenu = (obj) ->

            $scope.changeClub = obj

            $role.whoPrez obj.club_id, (val)->
                if val.length
                    $scope.prez = val[0].login
                else
                    $scope.prez = false
            $note.note obj.club_id, (ret) ->
                $scope.changeClub.mark = parseInt(ret.note_club, 10)


            $club.getMembers obj.club_id, (members)->
                $scope.changeClub.member = members
                angular.forEach $scope.changeClub.member, (value, key) ->
                    value.member_mark = parseInt(value.member_mark,10)
                    $user.login2name value.login, (info)->
                        value.user_firstname = info.user_firstname
                        value.user_name = info.user_name
                    angular.forEach $scope.projects, (item, key) ->
                        if item.project_id == value.project_id
                            value.project = item.project_type

                console.log $scope.changeClub


            $mdSidenav("changeClub").toggle()

]
