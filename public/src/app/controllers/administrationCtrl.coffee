angular.module 'app'
.controller 'administrationCtrl', [
    '$mdToast'
    '$scope'
    "$project"
    '$role'
    '$http'
    '$mdDialog'
    ($mdToast, $scope, $project, $role, $http, $mdDialog)->


        $scope.clearValue_addProject = ->
            $scope.addProject = {}

        $scope.clearValue_updateProject = ->
            $scope.project_description = {}
            $scope.updateProject = {}

        $scope.clearValue_addRole = ->
            $scope.addRole = {}

        $scope.clearValue_roleModifiedForm = ->
            $scope.updateRole = {}


        $scope.loadValue = ->
            project_description =  JSON.parse($scope.updateProject.projectChoice.project_description)
            $scope.updateProject.projectName = project_description.title
            $scope.updateProject.objectif = project_description.objectif
            $scope.updateProject.example = project_description.exemple
            $scope.updateProject.quota = parseInt(project_description.quota,10)
            $scope.updateProject.evaluation = project_description.eval
            $scope.updateProject.abrev = $scope.updateProject.projectChoice.project_type

        $scope.loadRole = ->
            $scope.updateRole = {}
            $scope.updateRole.name = $scope.roleModifiedForm.rolechoice.role

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
            temp =
                "title" : $scope.updateProject.projectName
                "objectif" : $scope.updateProject.objectif
                "exemple":  $scope.updateProject.example
                "quota" : $scope.updateProject.quota
                "eval" : $scope.updateProject.example
            $scope.project_description = JSON.stringify(temp, null, "\t")
            $scope.put_update()

        $project.all (projects)->
            $scope.projects = projects.reverse()



        $role.getAll (roles)->
            $scope.roles = roles


        $scope.suppressDiag = ->
            confirm = $mdDialog.confirm()
                .title('Confirmation de la suppression du projet')
                .textContent('Les données seront définitivement supprimées')
                .ok('Confirmer')
                .cancel('Annuler');
            $mdDialog.show(confirm).then ->
                $scope.delete()

        $scope.suppressRole = ->
            confirm = $mdDialog.confirm()
                .title('Confirmation de la suppression du poste')
                .textContent('Les données seront définitivement supprimées. Vous ne pouvez pas supprimer un poste qui a déjà été occupé')
                .ok('Confirmer')
                .cancel('Annuler');
            $mdDialog.show(confirm).then ->
                $scope.delete_role()




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
                    $project.all (projects)->
                        $scope.projects = projects.reverse()
                    $scope.clearValue_addProject()
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

        $scope.put_update = ->
            $http
                method: 'PUT'
                url: "../../api/projects"
                headers:
                    'Content-Type': 'application/json'
                data:
                    project_id: $scope.updateProject.projectChoice.project_id
                    project_type: $scope.updateProject.abrev
                    project_description: $scope.project_description
            .then (res)->
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Le projet a été mis à jour'
                        .position 'bottom right'
                    )
                    angular.forEach $scope.projects, (value, key) ->
                        if(value.project_id == $scope.updateProject.projectChoice.project_id)
                            $scope.projects[key].abrev = $scope.updateProject.abrev
                            $scope.projects[key].project_type = $scope.updateProject.abrev
                            $scope.projects[key].project_description = $scope.updateProject.project_description
                    console.log $scope.projects
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

        $scope.delete = ->
            $http
                method: 'DELETE'
                url: "../../api/projects/" + $scope.updateProject.projectChoice.project_id
                headers:
                    'Content-Type': 'application/json'

            .then (res)->
                if res.data
                    $mdToast.show(
                        $mdToast.simple 'Le projet a été supprimé'
                        .position 'bottom right'
                    )
                    $scope.projects = $scope.projects.filter (e) ->
                        e.project_id != $scope.updateProject.projectChoice.project_id

                    $scope.clearValue_updateProject()


                else
                    $mdToast.show(
                        $mdToast.simple "Une erreur est survenue, le projet n'a pas pu être suppimé"
                        .position 'bottom right'
                    )


            , (err)->
                    console.log err
                    $mdToast.show(
                        $mdToast.simple "Impossible de contacter le serveur"
                        .position 'bottom right'
                    )



                ###                   Les rôles                     ###


        $scope.post_add_role = ->

            $http
                method: 'POST'
                url: "../../api/role"
                headers:
                    'Content-Type': 'application/json'
                data:
                    role_name: $scope.addRole.name
            .then (res)->
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Le rôle a bien été créé'
                        .position 'bottom right'
                    )

                    $scope.clearValue_addRole()
                    $role.getAll (roles)->
                        $scope.roles = roles


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

        $scope.put_update_role = ->
            $http
                method: 'PUT'
                url: "../../api/role"
                headers:
                    'Content-Type': 'application/json'
                data:
                    role_id: $scope.roleModifiedForm.rolechoice.id_role
                    role_name: $scope.updateRole.name
            .then (res)->
                if res.data.err == null
                    $mdToast.show(
                        $mdToast.simple 'Le poste a été mis à jour'
                        .position 'bottom right'
                    )
                    angular.forEach $scope.roles, (value, key) ->
                        console.log value
                        if(value.id_role == $scope.roleModifiedForm.rolechoice.id_role)
                            $scope.roles[key].role = $scope.updateRole.name
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

        $scope.delete_role = ->
            $http
                method: 'DELETE'
                url: "../../api/role/" + $scope.roleModifiedForm.rolechoice.id_role
                headers:
                    'Content-Type': 'application/json'

            .then (res)->
                if res.data && !res.data.err
                    $mdToast.show(
                        $mdToast.simple 'Le rôle a été supprimé'
                        .position 'bottom right'
                    )
                    $scope.roles = $scope.roles.filter (e) ->
                        e.id_role != $scope.roleModifiedForm.rolechoice.id_role

                    $scope.clearValue_roleModifiedForm()

                else
                    if res.data.err
                        $mdToast.show(
                            $mdToast.simple "Le rôle n'a pas pu être supprimé car il a déjà été occupé"
                            .position 'bottom right'
                        )
                    else
                        $mdToast.show(
                            $mdToast.simple "Une erreur est survenue, le rôle n'a pas pu être suppimé"
                            .position 'bottom right'
                        )


            , (err)->
                    console.log err
                    $mdToast.show(
                        $mdToast.simple "Impossible de contacter le serveur"
                        .position 'bottom right'
                    )



]
