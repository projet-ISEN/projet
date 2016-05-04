#------------------------------------------------------------------------------
#           GET CLUB INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$effectif', ['$http', ($http)->
    @all = (cb)->
        $http(
            method: 'GET'
            url: "../../api/effectifs"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @one = (club_id, cb)->
        $http(
            method: 'GET'
            url: "../../api/effectifs/" + club_id

        ).then (res)->          # On success
            return cb res.data
        , (err)->              # On error
            console.log err if err?
            return cb null
        return

    return this
]