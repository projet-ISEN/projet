angular.module 'app'
.controller 'adminAffectationCtrl', [
    '$scope'
    '$mdDialog'
    '$mdToast'
    '$year'
    '$affectation'
    '$user'
    '$club'
    ($scope, $mdDialog, $mdToast, $year, $affectation, $user, $club)->

        $year.currentYear (year)->
            $scope.year = parseInt year
            $scope.choosedYear = $scope.year

        # Start automatic affectation
        $scope.lunch = ->

            $scope.waiting      = true
            $scope.lostMembers  = []
            $scope.choosedYear  = $scope.year + 1

            $affectation.start $scope.choosedYear, (members)->

                $scope.lostMembers = members

                angular.forEach $scope.lostMembers, ( member, k )->

                    $user.login2name member.login, (infos)->

                        member.user = infos

                        member.choices = []

                        angular.forEach member.choice, (choice, k)->

                            $club.one choice.club_id, (club)->

                                member.choices.push
                                    club_id: choice.club_id
                                    club :   club
                                    score:   choice.score
                $scope.waiting = false

        # Open dialog box for manual affectation for next year
        $scope.openDialog = ( user ) ->

            $mdDialog.show
                controller: 'adminUserDialogCtrl'
                templateUrl: 'directives/dialogAdminUser.html'
                parent: angular.element(document.body)
                #targetEvent: ev
                clickOutsideToClose:true
                locals:
                    user: user
                    specificYear: $scope.year + 1


        # Lock affectation for next year
        $scope.lock = ->

            $mdDialog.show( $mdDialog.confirm()
                .title "Voulez-vous vraiment vérouiller l'affectation ?"
                .textContent "Cette action sera irréversible, vérifier que " +\
                           "les compositions de clubs vous conviennent avant de valider"
                .ariaLabel 'lock? or not?'
                .clickOutsideToClose true
                .ok "Procéder à l'affectation"
                .cancel "Il me reste des changements à faire"
            ).then( ->
                    $affectation.lock $scope.year + 1, (res)->
                        if res.err?
                            $mdToast.showSimple "Une erreur c'est produite"
                        else
                            $mdToast.showSimple "Affectation terminée"
                            $scope.lostMembers = null
            , ->
                    $mdToast.showSimple 'Affectation annulée'
            )

]
