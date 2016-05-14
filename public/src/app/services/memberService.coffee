#------------------------------------------------------------------------------
#           GET MEMBER INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$member', ['$http', ($http)->

    # Les clubs d'un user
    @one = (login, cb)->
        $http(
            method: 'GET'
            url: "../../api/members/" + login

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    # Ajoute un club à ce user avec ce projet
    @add = (login, club, projet, cb)->
        $http(
            method: 'PUT'
            url: "../../api/members/" + login
            data:
                club_id:    club
                project_id: projet

        ).then (res)->          # On success
            cb res
        , (err)->              # On error
            console.log err
            cb err

    # Ajoute un club à ce user avec ce projet
    @addNextYear = (login, club, projet, year, cb)->
        $http(
            method: 'PUT'
            url: "../../api/members/" + login + "/1/" + year
            data:
                club_id:    club
                project_id: projet
                year: year

        ).then (res)->          # On success
            cb res
        , (err)->              # On error
            console.log err
            cb err



    @juniorMember = (year, cb)->
        $http(
            method: 'GET'
            url: "../../api/clubs/junior/candidate/" + year

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err


    # Change le club principale d'un membre
    @setMain = (login, club, cb)->
        $http(
            method: 'PUT'
            url: "../../api/members/setMain/" + login
            data:
                club_id: club

        ).then (res)->          # On success
            cb res
        , (err)->              # On error
            console.log err
            cb err

    # Supprime un membre d'un club
    @delete = (login, club, cb)->
        $http(
            method: 'DELETE'
            url: "../../api/members/" + login
            data:
                club_id: club

        ).then (res)->          # On success
            cb res
        , (err)->              # On error
            console.log err
            cb err

    # Retourne un tableau d'objet user candidat à Capisen
    @candidateJunior = (cb)->
        $http(
            method: 'GET'
            url: "../../api/capisen/candidate"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    @recommendedMember = (club_id, cb)->
        $http(
            method: 'GET'
            url: "../../api/members/recommended/" + club_id

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    @recommend = (clubId, login, cb)->
        $http(
            method: 'POST'
            url: "../../api/members/recommend/" + login
            data:
                club_id: clubId

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    @unRecommend = (clubId, login, cb)->
        $http(
            method: 'PUT'
            url: "../../api/members/unRecommend/" + login
            data:
                club_id: clubId

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    @disgrace = (clubId, login, cb)->
        $http(
            method: 'POST'
            url: "../../api/members/disgrace/" + login
            data:
                club_id: clubId

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    @unDisgrace = (clubId, login, cb)->
        $http(
            method: 'PUT'
            url: "../../api/members/unDisgrace/" + login
            data:
                club_id: clubId

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb err

    return @
]
