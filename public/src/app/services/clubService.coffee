#------------------------------------------------------------------------------
#           GET CLUB INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$club', ['$http', ($http)->
    @all = (cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @one = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs/" + id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @getByName = (name, cb)=>
        @all (clubs)->
            for club in clubs
                if club.club_name == name
                    cb club
            cb null


    @stat = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs/" + id + "/stat"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    return this
]
