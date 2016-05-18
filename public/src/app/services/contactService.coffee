angular.module('app')
.service '$contacts', ['$http', ($http)->
    @all = (id,cb)->
        $http(
            method: 'GET'
            url: "../../api/contact/"+id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null


    @allForYear = (clubId, year, cb)->
        $http(
            method: 'GET'
            url: "../../api/contact/" + clubId + '/' + year

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    return @

]
