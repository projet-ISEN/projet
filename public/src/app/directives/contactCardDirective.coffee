angular.module('app')
.directive 'contactCard', ->
    return {
        restrict: 'E'
        scope:
            contact: '='
        templateUrl: "directives/contactCard.html"
    }

