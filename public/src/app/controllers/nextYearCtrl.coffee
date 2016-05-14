#------------------------------------------------------------------------------
#               CONTROLLER DE L ANNEE PROSPECTIVE
#------------------------------------------------------------------------------

angular.module('app')
.controller 'nextYearCtrl', [
    '$scope'
    '$routeParams'
    '$user'
    '$club'
    '$member'
    ($scope, $routeParams, $user, $club, $member)->


        clubId = $routeParams.clubId

        # Fonction qui charge tout
        refresh = ->
            # Partie  user que l'on peut recommander
            $user.all (users)->
                $scope.users = users
                #console.log users
                $member.recommendedMember clubId, (members)->
                    $scope.members = members

                    angular.forEach $scope.members, (member, k)->

                        member.recommended = false
                        for user in $scope.users
                            if user.login == member.login
                                user.recommended = member.recommandation == '1'

            # Partie membres que l'ont peut pénaliser
            $club.getMembers clubId, (members)->

                $scope.clubMembers = members

                angular.forEach $scope.clubMembers, ( member, k )->
                    console.log member
                    member.bad = member.ex_member_not_wanted == '1'
                    $user.login2name member.login, (res)->
                        console.log res
                        member.user = res

        refresh()

        $scope.recommend = (user)->
            if user.recommended
                console.log 'unrecommend'
                $member.unRecommend clubId, user.login, (res)->
                    if res.err?
                        console.log 'ko'
                    else
                        console.log 'ok'
            else
                console.log 'recommend'
                $member.recommend clubId, user.login, (res)->
                    if res.err?
                        console.log 'ko'
                    else
                        console.log 'ok'
            refresh()

        $scope.disgrace = (member)->
            if member.bad
]
