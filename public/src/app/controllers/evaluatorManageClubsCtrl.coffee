angular.module 'app'
.controller 'evaluatorManageClubsCtrl', [
    '$mdToast'
    '$scope'
    '$club'
    '$user'
    '$role'
    '$http'
    '$mdSidenav'
    ($mdToast, $scope, $club, $user, $role, $http, $mdSidenav)->






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



        $scope.updatePrez = ->
            console.log $scope.updatePrezChoice
            $role.pushPrez $scope.updatePrezChoice.login, $scope.changeClub.club_id, (bool)->
                console.log "retour de la fonction de changement de président: " + bool
            return


        $scope.toggleMenu = (obj) ->

            $scope.changeClub = obj

            $role.whoPrez obj.club_id, (val)->
                if val.length
                    $scope.prez = val[0].login
                else
                    $scope.prez = false


            $club.getMembers obj.club_id, (members)->
                $scope.changeClub.member = members
                angular.forEach $scope.changeClub.member, (value, key) ->
                    $user.login2name value.login, (info)->
                        value.user_firstname = info.user_firstname
                        value.user_name = info.user_name

            console.log $scope.changeClub.member


            $mdSidenav("changeClub").toggle()

]
