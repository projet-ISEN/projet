#------------------------------------------------------------------------------
#           GET MEMBER INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$member', ['$http', ($http)->

    @one = (login, cb)->
        $http(
            method: 'GET'
            url: "../../api/members/" + login

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    @add = (login, club, projet, cb)->
        $http(
            method: 'PUT'
            url: "../../api/users/" + login
            data:
                club_id:    club
                project_id: projet

        ).then (res)->          # On success
            cb res
        , (err)->              # On error
            console.log err
            cb err

    @setActif = (login, club, cb)->
        $http(
            method: 'PUT'
            url: "../../api/members/setActive/" + login
            data:
                club_id: club

        ).then (res)->          # On success
            cb res
        , (err)->              # On error
            console.log err
            cb err

    return @
]
