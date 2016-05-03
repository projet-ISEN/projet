

angular.module('app')
.directive 'clubCard', ->
    return {
        restrict: 'E'
        controller: 'clubCardCtrl'
        scope:
            club: '='
        templateUrl: "directives/clubCard.html"
    }


.controller 'clubCardCtrl', ['$club', '$scope', ($club, $scope)->

    # demande les infos d'un club

    $club.stat $scope.club.club_id, (stats)->
        $scope.club.stats = stats
]

