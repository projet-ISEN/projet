#------------------------------------------------------------------------------
#           GET ROLE INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$role', ['$http', ($http)->
    @getAll = (cb)->
        $http(
            method: 'GET'
            url: "../../api/role"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return
    return @
]
