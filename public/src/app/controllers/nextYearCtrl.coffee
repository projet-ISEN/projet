#------------------------------------------------------------------------------
#               CONTROLLER DE L ANNEE PROSPECTIVE
#------------------------------------------------------------------------------

angular.module('app')
.controller 'nextYearCtrl', [
    '$scope'
    '$routeParams'
    '$mdToast'
    '$user'
    '$club'
    '$member'
    '$year'
    ($scope, $routeParams, $mdToast, $user, $club, $member, $year)->


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
                                break

                    # Partie membres que l'ont peut pénaliser
                    $club.getMembers clubId, (members)->
                        $scope.clubMembers = members

                        angular.forEach $scope.clubMembers, ( member, k )->
                            #console.log member

                            # Charge le nom + prenom du membre
                            $user.login2name member.login, (res)->
                                member.user = res

                        # Get all disgraced members for next year
                        $club.getMembersYear clubId, $scope.year + 1, (disgracedMembers)->

                            for disgracedMember in disgracedMembers
                                angular.forEach $scope.clubMembers, (member, k)->
                                    if disgracedMember.login == member.login

                                        if disgracedMember.ex_member_not_wanted == '1'

                                            console.log member
                                            member.bad = true
                                            console.log member


        refresh()

        $scope.recommend = (user)->
            if user.recommended
                $member.unRecommend clubId, user.login, (res)->
                    if res.err?
                        $mdToast.showSimple 'Une erreur est survenue...'
                    else
                        $mdToast.showSimple "Ce membre n'est plus recommandé !"
            else
                $member.recommend clubId, user.login, (res)->
                    if res.err?
                        $mdToast.showSimple 'Une erreur est survenue...'
                    else
                        $mdToast.showSimple "Ce membre est recommandé !"

        $scope.disgrace = (member)->
            if member.bad
                $member.unDisgrace clubId, member.login, (res)->
                    if res.err?
                        $mdToast.showSimple 'Une erreur est survenue...'
                    else
                        $mdToast.showSimple "Ce membre est grâcié !"
            else
                $member.disgrace clubId, member.login, (res)->
                    if res.err?
                        $mdToast.showSimple 'Une erreur est survenue...'
                    else
                        $mdToast.showSimple "Ce membre tombe en disgrâce !"

        $year.currentYear (year)->
            $scope.year = parseInt(year)
]
