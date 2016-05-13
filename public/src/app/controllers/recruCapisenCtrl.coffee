angular.module 'app'
.controller 'recruCapisenCtrl', [
    '$mdToast'
    '$user'
    '$member'
    '$club'
    '$year'
    '$mdDialog'
    '$scope'
    ($mdToast, $user, $member, $club, $year, $mdDialog, $scope)->



        $club.junior (ret)->
            $scope.id = ret


        $scope.init = ->
            $year.currentYear (ret) ->
                $scope.year = parseInt(ret) + 1
                $member.juniorMember $scope.year, (ret)->
                    $scope.alreadyMembers = (parseInt(ret, 10) != 0)
                    if $scope.alreadyMembers
                        $club.getMembersYear $scope.id , $scope.year, (members)->
                            $scope.members = members
                            console.log members

        $scope.init()




        $member.candidateJunior (candidate) ->

            angular.forEach candidate, (value, key) ->
                value.select = 0
            $scope.candidates = candidate
            #console.log candidate


        $scope.choicecConfirm = ->
            confirm = $mdDialog.confirm()
                .title('Recrutement')
                .textContent('Ce choix ne pourra être modifier sans passer par un administrateur (équipe FHES)')
                .ok('Confirmer')
                .cancel('Annuler');
            $mdDialog.show(confirm).then ->
                $scope.juniorChoice()
                $scope.init()


        $scope.juniorChoice = ->
            $scope.selectMember = $scope.candidates.filter (e) ->
                    e.select == true
            angular.forEach $scope.selectMember, (value, key) ->
                $member.addNextYear value.login, $scope.id, null, $scope.year, (ret) ->
                    console.log value

]
