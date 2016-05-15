#------------------------------------------------------------------------------
#               CONTROLLER DE LA BOTTOM SHEET POUR LES EFFECTIFS
#------------------------------------------------------------------------------

angular.module('app')
.controller 'effectifsBottomSheet', [
    '$scope'
    'clubId'
    ($scope, clubId)->
        console.log clubId
]
