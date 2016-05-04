#------------------------------------------------------------------------------
#               CONTROLLER DE DEPART
#------------------------------------------------------------------------------

angular.module('app')
.controller 'homeCtrl', [
    '$club'
    '$project'
    '$mdDialog'
    '$scope'
    ($club, $project, $mdDialog, $scope)->


        $project.all (projects)->
            $scope.projects = projects.reverse()


        $club.all (clubs)->
            $scope.clubs = clubs

        $scope.clearValue = ->
            $scope.search = undefined;

        $scope.openDialog = (project)->

            $mdDialog.show
                parent: angular.element document.body
                templateUrl: "directives/dialogProjectDescription.html"
                locals:
                    project : project
                clickOutsideToClose: true
                controller: ['$scope', '$mdDialog', 'project', ($scope, $mdDialog, project)->

                    $scope.project = project
                    if typeof $scope.project.project_description == 'string'
                        $scope.project.project_description = JSON.parse(project.project_description)
                    console.log $scope.project
                    $scope.close = ->
                        $mdDialog.hide()

                ]
]
