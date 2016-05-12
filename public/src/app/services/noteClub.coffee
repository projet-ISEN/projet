angular.module('app')
.service '$note', ['$http', ($http)->
    @clubmark = (note, club_id, cb)->
        $http(
            method: 'POST'
            url: "../../api/noteClub"
            data:
                note: note
                club_id: club_id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return



    @note = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/noteClub/"+ id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @noteStudent = (member, cb)->
        $http(
            method: 'POST'
            url: "../../api/noteStudent"
            data:
                member:member

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @isLock = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/isLock/"+ id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @lockMark = (id, cb)->
        $http(
            method: 'PUT'
            url: "../../api/lockMark/"+ id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @lockProject = (id, cb)->
        $http(
            method: 'PUT'
            url: "../../api/lockProject/"+ id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    return @
]
