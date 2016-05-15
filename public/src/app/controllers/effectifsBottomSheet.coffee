#------------------------------------------------------------------------------
#               CONTROLLER DE LA BOTTOM SHEET POUR LES EFFECTIFS
#------------------------------------------------------------------------------

angular.module('app')
.controller 'effectifsBottomSheet', [
    '$scope'
    'clubId'
    '$project'
    '$effectif'
    '$year'
    ($scope, clubId, $project, $effectif, $year)->

        $project.all (projects)->
            $scope.projects = projects

        $effectif.one clubId, (effectifs)->
            console.log effectifs
            $scope.effectifs = effectifs

            angular.forEach $scope.projects, (projet, k)->

                for effectif in effectifs
                    if effectif.project_id == projet.project_id
                        projet.min = parseInt effectif.nb_asked_min
                        projet.max = parseInt effectif.nb_asked_max
                        break


        $year.currentYear (year)->
            $scope.year = parseInt(year)

        $scope.save = ->

            angular.forEach $scope.projects, (projet, k)->

                for effectif in $scope.effectifs
                    if effectif.project_id == projet.project_id
                        effectif.nb_asked_min = projet.min
                        effectif.nb_asked_max = projet.max
                        break

            console.log $scope.effectifs

            $effectif.set clubId, $scope.effectifs, (res)->
                console.log res
]
