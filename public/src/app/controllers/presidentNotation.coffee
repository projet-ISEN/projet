angular.module 'app'
.controller 'presidentNotation', [
    '$scope'
    '$club'
    '$project'
    '$user'
    '$routeParams'
    '$note'
    ($scope, $club, $project, $user, $routeParams, $note)->

        $scope.clubMark         = {}
        $scope.clubMark.locks   = {}

        # Si la somme des points correspond à la note donnée
        $scope.testMark = ->
            totalMark = 0
            for member in $scope.members
                totalMark += member.member_mark

            $scope.errorMark = totalMark != $scope.members.length * $scope.clubMark.note_club
            $scope.restPoint = $scope.members.length * $scope.clubMark.note_club - totalMark

        $scope.send = ->
            $note.validateProjectStudent $scope.members, (projet) ->
                console.log projet

        $club.getMembers $routeParams.club_id, (members)->

            $scope.members = members
            angular.forEach $scope.members, (member, k)->

                $user.login2name member.login, (user)->
                    member.user = user

                $project.idToType member.project_id, (res)->
                    member.project_type = res

                    if member.project_type == 'PA'
                        member.project_validation_bool = true
                    if member.project_type == 'PR'
                        if member.project_validation_bool
                            member.minMark = 10
                        else
                            member.maxMark = 9
                    else
                        member.minMark = 0
                        member.maxMark = 20

                member.member_mark              = parseInt member.member_mark
                member.project_validation_bool  = member.project_validation == '1' || member.project_validation == null

            $note.note $routeParams.club_id, (ret) ->
                if ret.err != null && ret.note_club != null
                    $scope.clubMark = ret

            $note.isLock $routeParams.club_id, (ret) ->
                console.log $scope.clubMark
                $scope.clubMark.locks.lock_member_mark = (ret.lock_member_mark == '1')
                $scope.clubMark.locks.lock_member_project_validation = (ret.lock_member_project_validation == '1')
                console.log $scope.clubMark.locks
                $scope.testMark()
]