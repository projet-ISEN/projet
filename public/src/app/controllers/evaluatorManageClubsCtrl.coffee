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

        $scope.errorNote = true

        $project.all (projects)->
            $scope.projects = projects

        $scope.tot = ->
            $scope.totalMb = 0
            temp = true
            angular.forEach $scope.changeClub.member, (value, key) ->
                $scope.totalMb += value.member_mark
                if value.project == "PR"
                    if value.project_validation
                        if value.member_mark < 10
                            temp = false
                    if !value.project_validation
                        if value.member_mark >= 10
                            temp = false

            $scope.errorNote = temp
            #console.log "error on PR " + $scope.errorNote
            #console.log $scope.changeClub.member
            $scope.changeClub.totalClub = $scope.changeClub.member.length * $scope.changeClub.mark
            #console.log "total club " + $scope.changeClub.totalClub
            #console.log "total membre " + $scope.totalMb
            $scope.changeClub.totalClub == $scope.totalMb && temp




        ###inverse  = ($val)->
            if($val==0) then $val = 1
            else $val = 0###


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
            retourTot = $scope.tot()
            console.log "retour tot  " +retourTot
            if !retourTot then errorOnMark()
            #console.log $scope.changeClub.mark
            else
                $note.clubmark $scope.changeClub.mark, $scope.changeClub.club_id, (bool)->

                    $note.validateProjectStudent $scope.changeClub.member, (projet) ->

                        giveNote = $scope.changeClub.member.filter (e) ->
                            e.project != "PR+"

                        $note.noteStudent giveNote, (ret) ->
                            if ret != "0" and bool != '0' and projet != '0'
                                $mdToast.show(
                                    $mdToast.simple 'Les données ont bien été enregistrées'
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

        $scope.toggle_lockProject = ->
            console.log "lock du projet " + $scope.changeClub.lock_member_project_validation
            console.log "lock de la note " + $scope.changeClub.lock_member_mark

            if(!$scope.changeClub.lock_member_project_validation && $scope.changeClub.lock_member_mark)
                    console.log "inverse markLock"
                    $scope.toggle_lockMark()




            $note.lockProject $scope.changeClub.club_id, (ret)->
                if(!$scope.changeClub.lock_member_project_validation) then $scope.tot()
                if ret != "0"
                    $mdToast.show(
                        $mdToast.simple 'Le verrouillage de validation de projets a été modifié'
                        .position 'bottom right'
                    )
                    $scope.changeClub.lock_member_project_validation = !$scope.changeClub.lock_member_project_validation
                    console.log "lock du projet " + $scope.changeClub.lock_member_project_validation

                else
                    $mdToast.show(
                        $mdToast.simple 'Un problème est survenue'
                        .position 'bottom right'
                    )

        errorOnMark = ->
            console.log "dialog box"
            $mdDialog.show(
                $mdDialog.alert()
                .clickOutsideToClose true
                .title 'Attention Erreur'
                .textContent 'La notation ne semble pas bonne vous ne pouvez pas valider ainsi, veuillez répartir tous les points avant de verrouiller les notes.'
                .ariaLabel 'Alert Dialog'
                .ok 'OK'
            )



        $scope.toggle_lockMark = ->
            console.log "test tot " + $scope.tot()
            if($scope.tot() || $scope.changeClub.lock_member_mark)
                console.log "NOT dialog box"
                if(!$scope.changeClub.lock_member_mark) then $scope.giveMark()
                $note.lockMark $scope.changeClub.club_id, (ret)->
                    if ret != "0"
                        $mdToast.show(
                            $mdToast.simple 'Le verrouillage de notes a été modifié'
                            .position 'bottom right'
                        )
                        $scope.changeClub.lock_member_mark = !$scope.changeClub.lock_member_mark
                        console.log "lock de la note " + $scope.changeClub.lock_member_mark

                    else
                        $mdToast.show(
                            $mdToast.simple 'Un problème est survenue'
                            .position 'bottom right'
                        )
            else
                errorOnMark()




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



        $scope.toggleMenu = (obj) ->

            $scope.changeClub = obj

            $role.whoPrez obj.club_id, (val)->
                if val.length
                    $scope.prez = val[0].login
                else
                    $scope.prez = false
            $note.note obj.club_id, (ret) ->
                $scope.changeClub.mark = parseInt(ret.note_club, 10)

            $note.isLock obj.club_id, (ret) ->
                $scope.changeClub.lock_member_mark = (ret.lock_member_mark == "0"  || ret.lock_member_mark == false)
                $scope.changeClub.lock_member_project_validation = (ret.lock_member_project_validation == "0" || ret.lock_member_project_validation == false)

            $club.getMembers obj.club_id, (members)->
                $scope.changeClub.member = members


                angular.forEach $scope.changeClub.member, (value, key) ->
                    value.member_mark = parseInt(value.member_mark,10)
                    value.project_validation = (value.project_validation == null || value.project_validation == "1")
                    $user.login2name value.login, (info)->
                        value.user_firstname = info.user_firstname
                        value.user_name = info.user_name
                    angular.forEach $scope.projects, (item, key) ->
                        if item.project_id == value.project_id
                            value.project = item.project_type

                console.log $scope.changeClub


            $mdSidenav("changeClub").toggle()

]
