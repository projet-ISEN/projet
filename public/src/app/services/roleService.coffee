#------------------------------------------------------------------------------
#           GET ROLE INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$role', ['$http', ($http)->
    @getAll = (cb)->
        $http(
            method: 'GET'
            url: "../../api/role"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    ###@IDPrez = (cb)->
        $http(
            method: 'GET'
            url: "../../api/IDPrez"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return###

    @whoPrez = (clubId, cb)->
        $http(
            method: 'GET'
            url: "../../api/whoPrez/"+clubId

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return


    @pushPrez = (login, clubId, cb)->
        $http(
            method: 'POST'
            url: "../../api/pushPrez"
            headers:
                'Content-Type': 'application/json'
            data:
                login: login
                clubId: clubId

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @roleOfMember = (club, login, cb)->
        @pushPrez = (login, clubId, cb)->
        $http(
            method: 'GET'
            url: "../../api/roles/" + club + '/' + login
        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @setRoleOfMember = (member, cb)->
        $http(
            method: 'POST'
            url: "../../api/roles/" + member.club_id + '/' + member.login
            headers:
                'Content-Type': 'application/json'
            data:
                member: member
        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    return @
]
