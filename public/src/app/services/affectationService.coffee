#------------------------------------------------------------------------------
#           SETUP AUTOMATIC AFFECTATION
#------------------------------------------------------------------------------
angular.module('app')
.service '$affectation', ['$http', ($http)->

    @start = (year, cb)->
        $http(
            method: 'GET'
            url: "../../api/repartition/" + year

        ).then (res)->
            cb res.data
        , (err)->
            console.log err if err?
            cb err

    @lock = (year, cb)->
        $http(
            method: 'DELETE'
            url: "../../api/repartition/" + year

        ).then (res)->
            cb res.data
        , (err)->
            console.log err if err?
            cb err


    return @
]
