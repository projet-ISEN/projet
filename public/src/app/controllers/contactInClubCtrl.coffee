angular.module 'app'
.controller 'contactInClubCtrl', [
    '$scope'
    '$contacts'
    '$routeParams'
    ($scope, $contacts, $routeParams)->


        $contacts.all $routeParams.club_id, (contacts)->
            $scope.contacts = contacts

        $scope.clearValue = ->
            $scope.search = undefined;
]
