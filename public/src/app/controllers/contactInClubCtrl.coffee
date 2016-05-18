angular.module 'app'
.controller 'contactInClubCtrl', [
    '$scope'
    '$contacts'
    '$year'
    '$routeParams'
    ($scope, $contacts, $year, $routeParams)->

        clubId = $routeParams.club_id

        $contacts.all clubId, (contacts)->
            $scope.contacts = contacts

        $scope.clearValue = ->
            $scope.search = undefined;

        $year.currentYear (year)->
            $scope.year = parseInt year
            $scope.currentYear = $scope.year


        $scope.updateContacts = ->
            $contacts.allForYear clubId, $scope.year, (contacts)->
                $scope.contacts = []
                $scope.contacts = contacts
]
