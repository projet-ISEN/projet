angular.module 'app'
.controller 'contactInClubCtrl', [
    '$scope'
    '$contacts'
    '$routeParams'
    ($scope, $contacts, $routeParams)->


        $club.getByName $routeParams.club_name, (contacts)->
            $scope.contacts = contacts


]
