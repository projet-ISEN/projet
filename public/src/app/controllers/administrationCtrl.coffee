angular.module 'app'
.controller 'administrationCtrl', [
    '$mdToast'
    '$scope'
    '$http'
    ($mdToast, $scope, $http)->


        $scope.clearValue_addProject = ->
            $scope.addProject = ""


        $scope.saveProject = ->
            project_description =
                "title" : $scope.addProject.projectName
                "objectif" : $scope.addProject.objectif
                "exemple":  $scope.addProject.example
                "quota" : $scope.addProject.quota
                "eval" : $scope.addProject.example
            project_description = JSON.stringify(project_description, null, "\t")
            post_add(project_description)



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
