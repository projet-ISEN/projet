angular.module 'app'
.controller 'clubCtrl', [
    '$scope'
    '$club'
    '$effectif'
    '$project'
    '$routeParams'
    'crumble'
    ($scope, $club, $effectif, $project, $routeParams, crumble)->

        $scope.club = {}


        $club.one $routeParams.club_id, (club) ->
            $scope.club = club

            crumble.update
                clubName: club.club_name



            $club.stat club.club_id, (stat) ->
                $scope.club.stat = stat

            $effectif.one club.club_id, (effectifs)->
                $scope.club.effectifs = effectifs

                $project.all (projects)=>

                    for effectif in effectifs
                        for project in projects
                            if effectif.project_id == project.project_id
                                effectif.project_type = project.project_type





]
