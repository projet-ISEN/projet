#------------------------------------------------------------------------------
#           GET USER INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$year', ['$http', ($http)->


    @currentYear = (cb)->
        $http(
            method: 'GET'
            url: "../../api/year"

        ).then (res)->
            cb res.data
        , (err)->
            console.log err if err?
            cb null

    return @
]
