#------------------------------------------------------------------------------
#           GET CLUB INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$effectif', ['$http', ($http)->

    # Return all effectifs
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

    # Return effectifs of club
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

    # Set effectifs for a club
    @set = (club_id, effectifs, cb)->
        $http(
            method: 'PUT'
            url: "../../api/effectifs/" + club_id
            data:
                effectifs: effectifs

        ).then (res)->          # On success
            return cb res.data
        , (err)->              # On error
            console.log err if err?
            return cb null
        return

    @canSetEffectifs = (clubId, cb)->
        $http(
            method: 'GET'
            url: "../../api/effectifs/rights/" + clubId

        ).then (res)->          # On success
            return cb res.data
        , (err)->              # On error
            console.log err if err?
            return cb null
        return

    return this
]
