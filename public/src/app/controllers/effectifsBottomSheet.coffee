#------------------------------------------------------------------------------
#               CONTROLLER DE LA BOTTOM SHEET POUR LES EFFECTIFS
#------------------------------------------------------------------------------

angular.module('app')
.controller 'effectifsBottomSheet', [
    '$scope'
    '$mdToast'
    'clubId'
    '$project'
    '$effectif'
    '$year'
    ($scope, $mdToast, clubId, $project, $effectif, $year)->

        $project.all (projects)->

            $scope.projects = projects
            angular.forEach $scope.projects, (project, k)->
                project.min = 0
                project.max = 0

        $effectif.one clubId, (effectifs)->
            #console.log effectifs
            $scope.effectifs = effectifs

            angular.forEach $scope.projects, (project, k)->

                for effectif in effectifs
                    if effectif.project_id == project.project_id
                        project.min = parseInt effectif.nb_asked_min
                        project.max = parseInt effectif.nb_asked_max
                        break

        $year.currentYear (year)->
            $scope.year = parseInt(year)


        $scope.testValue = ->

            $scope.error = false
            angular.forEach $scope.projects, (project, k)->
                if project.min > project.max
                    $scope.error = true
                    return


        $scope.save = ->
            console.log $scope.projects

            effectifs = []

            angular.forEach $scope.projects, (project, k)->

                if project.min > project.max
                    return $mdToast.showSimple "Corrigez d'abord les valeurs"
                    .position 'bottom right'

                effectifs.push
                    nb_asked_min: project.min
                    nb_asked_max: project.max
                    project_id:   project.project_id

                ###for effectif in $scope.effectifs
                    if effectif.project_id == project.project_id
                        effectif.nb_asked_min = project.min
                        effectif.nb_asked_max = project.max
                        break
                ###
            #console.log $scope.effectifs

            $effectif.set clubId, effectifs, (res)->
                #console.log res
                if res.err?
                    $mdToast.showSimple 'Une erreur est survenue'
                    .position 'bottom right'
                else
                    $mdToast.showSimple 'Modifications prises en compte'
                    .position 'bottom right'
]
