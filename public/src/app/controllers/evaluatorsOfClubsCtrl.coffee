#------------------------------------------------------------------------------
#           SET EVALUATOR FOR CLUBS
#------------------------------------------------------------------------------
angular.module 'app'
.controller 'evaluatorsOfClubsCtrl', [
    '$scope'
    '$mdToast'
    '$club'
    '$user'
    ($scope, $mdToast, $club, $user)->

        $club.all (clubs)->
            $scope.clubs = clubs

        $user.allEvaluators (evals)->
            $scope.evaluators = evals

        $scope.changeEval = (club)->
            $club.update club, (res)->
                if res.err?
                    $mdToast.showSimple 'Une erreur est survenue : ' + res.err
                else
                    $mdToast.showSimple 'Modification prise en compte !'

]
