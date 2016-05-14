#------------------------------------------------------------------------------
#               CONTROLLER DE L ANNEE PROSPECTIVE
#------------------------------------------------------------------------------

angular.module('app')
.controller 'nextYearCtrl', [
    '$scope'
    '$routeParams'
    '$user'
    '$member'
    ($scope, $routeParams, $user, $member)->


        clubId = $routeParams.clubId

        $user.all (users)->
            $scope.users = users
            #console.log users
            $member.recommendedMember clubId, (members)->
                $scope.members = members

                angular.forEach $scope.members, (member, k)->

                    console.log member
                    member.recommended = false
                    for user in $scope.users
                        if user.login == member.login
                            user.recommended = member.recommandation == '1'


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

]
