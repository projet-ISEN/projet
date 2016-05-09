angular.module 'app'
.controller 'administrationCtrl', [
    '$mdToast'
    '$scope'
    "$project"
    '$http'
    ($mdToast, $scope, $project, $http)->


        $scope.clearValue_addProject = ->
            $scope.addProject = ""


        $scope.loadValue = ()->
            project_description =  JSON.parse($scope.updateProject.projectChoice.project_description)
            $scope.updateProject.projectName = project_description.title
            $scope.updateProject.objectif = project_description.objectif
            $scope.updateProject.example = project_description.exemple
            $scope.updateProject.quota = parseInt(project_description.quota,10)
            $scope.updateProject.evaluation = project_description.eval

        $scope.saveProject = ->
            project_description =
                "title" : $scope.addProject.projectName
                "objectif" : $scope.addProject.objectif
                "exemple":  $scope.addProject.example
                "quota" : $scope.addProject.quota
                "eval" : $scope.addProject.example
            project_description = JSON.stringify(project_description, null, "\t")
            post_add(project_description)


        $scope.updateProject = ->
            console.log "maj"

        $project.all (projects)->
            $scope.projects = projects.reverse()


        post_add = (project_description)->

            $http
                method: 'POST'
                url: "../../api/projects"
                headers:
                    'Content-Type': 'application/json'
                data:
                    project_type: $scope.addProject.abrev
                    project_description: project_description
            .then (res)->
                console.log res
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Le projet a bien été créé'
                        .position 'bottom right'
                    )
                else
                    console.log res.data.err
                    $mdToast.show(
                        $mdToast.simple "Une erreur est survenue: #{res.data.err}"
                        .position 'bottom right'
                    )

            , (err)->
                    console.log err
                    $mdToast.show(
                        $mdToast.simple "Impossible de contacter le serveur"
                        .position 'bottom right'
                    )



]
