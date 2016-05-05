#------------------------------------------------------------------------------
#           GET USER INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$user', ['$http', ($http)->

        
    @me = (cb)->
        $http(
            method: 'GET'
            url: "../../api/me"

        ).then (res)->
            cb res.data
        , (err)->
            console.log err if err?
            cb null
    return @
]