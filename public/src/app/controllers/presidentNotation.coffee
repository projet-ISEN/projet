angular.module 'app'
.controller 'presidentNotation', [
    '$scope'
    '$club'
    '$project'
    '$user'
    '$routeParams'
    '$mdToast'
    '$note'
    ($scope, $club, $project, $user, $routeParams, $mdToast, $note)->

        $scope.locks = {}

        # Si la somme des points correspond à la note donnée
        $scope.testMark = ->
            totalMark = 0
            memberWithMark = 0

            for member in $scope.members
                if member.project != 'PR+'
                    if !(isNaN(member.member_mark))
                        totalMark += member.member_mark
                        memberWithMark++

            $scope.restPoint = memberWithMark * $scope.clubMark - totalMark
            $scope.errorMark = $scope.restPoint != 0

        # Récupère la liste des membres
        $club.getMembers $routeParams.club_id, (members)->

            $scope.members = members
            angular.forEach $scope.members, (member, k)->

                # Si il n'y a pas de note, on met 0
                if member.member_mark == null
                    member.member_mark = 0

                # Traduis le login en user et l'ajoute au membre
                $user.login2name member.login, (user)->
                    member.user = user

                # Trasuis le project_id en projet et le colle au membre
                $project.idToType member.project_id, (res)->
                    member.project = res

                    # Un PA statisfait toujours @Delaleau
                    if member.project == 'PA'
                        member.project_validation_bool = true

                    # Note min et Max pour un PR validé ou non
                    if member.project == 'PR'
                        if member.project_validation_bool
                            member.minMark = 10
                        else
                            member.maxMark = 9
                    else
                        member.minMark = 0
                        member.maxMark = 20

                member.member_mark              = parseInt member.member_mark
                member.project_validation_bool  = member.project_validation == '1' || member.project_validation == null

            # Récupère la note du club
            $note.note $routeParams.club_id, (ret) ->
                if ret.err != null && ret.note_club != null
                    $scope.clubMark = ret.note_club

            # Récupère les locks
            $note.isLock $routeParams.club_id, (ret) ->

                $scope.locks.lock_member_mark = (ret.lock_member_mark == '0')
                $scope.locks.lock_member_project_validation = (ret.lock_member_project_validation == '0')

                $scope.testMark()

        # Lors de la sauvegarde des notes
        $scope.send = ->
            # Si les projets sont pas locks
            if !$scope.locks.lock_member_project_validation
                # On balance les projets
                for member in $scope.members
                    if member.project_validation_bool
                        member.project_validation = '1'
                    else
                        member.project_validation = '0'
                # Envoi pour enregistrement
                $note.validateProjectStudent $scope.members, (res) ->
                    console.log res
                    if res == '1'
                        $mdToast.showSimple "Enregistré !"
                    else
                        $mdToast.showSimple "Un problème est survenu !"


            else
                # On balance les notes
                for member in $scope.members
                    if member.member_mark == null
                        return $mdToast.showSimple "Tous les membres n'ont pas de note"

                    console.log $scope.members
                $note.noteStudent $scope.members, (res) ->
                    if res == '1'
                        $mdToast.showSimple "Notes sauvegardées !"
                    else
                        $mdToast.showSimple "Un problème est survenu !"
]
