#------------------------------------------------------------------------------
#           GET CLUB INFOS
#------------------------------------------------------------------------------
angular.module('app')
.factory '$club', ['$http', ($http)->
    
    return {
        
        all: ->
            $http(
                method: 'GET'
                url: "../../api/clubs"

            ).then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null
            
        one: (id)->
            $http(
                method: 'GET'
                url: "../../api/clubs/" + id

            ).then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null
            
        stat: (id)->
            $http(
                method: 'GET'
                url: "../../api/clubs/" + id + "/stat"

            ).then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null    
    }   
]