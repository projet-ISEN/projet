#------------------------------------------------------------------------------
#           GET CLUB INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$club', ['$http', ($http)->

    # List all clubs
    @all = (cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @evaluatorClub = ( cb)->
        $http(
            method: 'GET'
            url: "../../api/clubEvaluator"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    # Get one club with his uid
    @one = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs/" + id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    # Get one club with his name
    @getByName = (name, cb)=>
        @all (clubs)->
            for club in clubs
                if club.club_name == name
                    return cb club
            cb null

    # Get statistics of a club
    @stat = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs/" + id + "/stat"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    ###send back the member of a club of the current year###
    @getMembers = (id, cb)->
        $http(
            method: 'GET'
            url: "../../api/membersclub/" + id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    ###send back the member of a club of a specific year###
    @getMembersYear = (id, year, cb)->
        $http(
            method: 'GET'
            url: "../../api/membersclub/" + id + "/" +year

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @junior = (cb)->
        $http(
            method: 'GET'
            url: "../../api/clubsjunior"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @update = (club, cb)->
        $http(
            method: 'PUT'
            url: "../../api/clubs/" + club.club_id
            data:
                club: club

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @setDescription = (club, cb)->
        $http(
            method: 'PUT'
            url: "../../api/clubdescription/" + club.club_id
            data:
                club: club

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null

    @setLogo = (clubId, formData, cb)->
        $http.post '../../api/clublogo/' + clubId, formData,
            transformRequest: angular.identity,
            headers:
                'Content-Type': undefined
        .then (res)->
            cb res
        , (err)->
            console.log err
            cb err

    return @
]
