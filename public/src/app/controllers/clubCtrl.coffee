angular.module 'app'
.controller 'clubCtrl', [
    '$scope'
    '$club'
    '$effectif'
    '$project'
    '$routeParams'
    ($scope, $club, $effectif, $project, $routeParams)->

        $scope.club = {}

        $club.getByName $routeParams.club_name, (club) ->
            $scope.club = club

            $club.stat club.club_id, (stat) ->
                $scope.club.stat = stat

            $effectif.one club.club_id, (effectifs)->
                $scope.club.effectifs = effectifs


                    #$project.idToType e.project_id, (project_type)=>
                    #    e.project_type = project_type
                    #    console.log(e)



]
