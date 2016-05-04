angular.module('app')
.service '$contact', ['$http', ($http)->
    @all = (cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

]
