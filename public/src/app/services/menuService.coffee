#------------------------------------------------------------------------------
#           GET Menu INFOS
#------------------------------------------------------------------------------
angular.module('app')
.factory '$menu', ['$http', ($http)->

    return {

        myMenu: ->
            $http(
                method: 'GET'
                url: "../../api/menu"

            ).then (res)->          # On success
                return res.data
            , (err)->              # On error
                console.log err if err?
                return null
    }
]
