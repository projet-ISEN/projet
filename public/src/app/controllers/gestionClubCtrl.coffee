angular.module 'app'
.controller 'gestionClubCtrl', [
    '$scope'
    '$mdToast'
    '$note'
    '$club'
    '$project'
    '$role'
    '$user'
    '$routeParams'
    ($scope, $mdToast, $note, $club, $project, $role, $user, $routeParams)->

        $scope.clubId           = $routeParams.club_id
        $scope.passationFiles   = []

        $scope.sendFile = ->

            formData = new FormData()
            formData.append 'file', ($scope.passationFiles[0]).lfFile

            $note.sendPassation $scope.clubId, formData, (res)->
                if res.err?
                    $mdToast.showSimple "Une erreur s'est produite : " + err
                    .position 'bottom right'
                else
                    $mdToast.showSimple "Votre fichier est enregistré !"
                    .position 'bottom right'

        $scope.sendLogo = ->

            formData = new FormData()
            formData.append 'file', ($scope.clubLogo[0]).lfFile

            $club.setLogo $scope.clubId, formData, (res)->
                unless res.err?
                    $mdToast.showSimple "Votre Logo est enregistré !"
                    .position 'bottom right'
                else
                    $mdToast.showSimple "Une erreur s'est produite : " + err
                    .position 'bottom right'

        $note.getPassations $scope.clubId , (res)->
            $scope.passations = res

        $role.getAll (roles)->
            $scope.roles = roles
            # You cannot set a president
            for role in $scope.roles
                if role.role == 'président'
                    role.display = false
                else
                    role.display = true

        $scope.updateRole = (member)->
            $role.setRoleOfMember member, (res)->
                if res.err?
                    $mdToast.showSimple "Une erreur s'est produite : " + err
                    .position 'bottom right'
                else
                    $mdToast.showSimple "Rôle enregistré !"
                    .position 'bottom right'

        $scope.updateDescription = ->
            console.log 'changed'
            $club.setDescription $scope.thisClub, (res)->
                if res.err?
                    $mdToast.showSimple "Une erreur s'est produite : " + err
                    .position 'bottom right'
                else
                    $mdToast.showSimple "Description enregistrée !"
                    .position 'bottom right'



        $club.getMembers $scope.clubId, (members)->
            $scope.members = members

            $role.whoPrez $scope.clubId, (pres)->
                presLogin =  (pres[0]).login
                angular.forEach $scope.members, (member, k)->

                    #console.log presLogin + '==' + member.login
                    if presLogin == member.login
                        member.isPres = true
                    else
                        member.isPres = false

                    $project.idToType member.project_id, (project)->
                        member.project = project

                        $user.login2name member.login, (user)->
                            member.user = user

                            $role.roleOfMember $scope.clubId, member.login, (roles)->
                                member.role = roles
                                console.log member
        $club.one $scope.clubId, (club)->
            $scope.thisClub = club




]
