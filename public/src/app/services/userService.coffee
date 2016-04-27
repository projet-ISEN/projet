#------------------------------------------------------------------------------
#           GET USER INFOS
#------------------------------------------------------------------------------
angular.module('app')
.factory '$user', ['$http', ($http)->
    
    return {
        
        getInfos: ->
            $http
                method: 'GET'
                url: "../../api/me"

            .then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null
    }       
]