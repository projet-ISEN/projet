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


    # Récupère la note d'un club
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

    @noteStudent = (members, cb)->
        $http(
            method: 'POST'
            url: "../../api/noteStudent"
            data:
                member:members

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @validateProjectStudent = (member, cb)->
        $http(
            method: 'POST'
            url: "../../api/validateProjectStudent"
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
    @unLockMark = (id, cb)->
        $http(
            method: 'PUT'
            url: "../../api/ulockMark/"+ id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @unLockProject = (id, cb)->
        $http(
            method: 'PUT'
            url: "../../api/ulockProject/"+ id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    return @
]
