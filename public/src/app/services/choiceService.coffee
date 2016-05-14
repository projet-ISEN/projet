#------------------------------------------------------------------------------
#           GET CHOICES INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$choice', ['$http', ($http)->


    @set = (choices, cb)->
        $http(
            method: 'POST'
            url: "../../api/choices"
            headers:
                'Content-Type': 'application/json'
            data:
                choices:
                    "1": choices[0].club_id
                    "2": choices[1].club_id
                    "3": choices[2].club_id
        ).then (res)->
            cb res.data
        , (err)->
            console.log err if err?
            cb err


    @edit = (choices, cb)->

        $http
            method: 'PUT'
            url: "../../api/choices"
            headers:
                'Content-Type': 'application/json'
            data:
                choices:
                    "1": choices[0].club_id
                    "2": choices[1].club_id
                    "3": choices[2].club_id
        .then (res)->
            cb res.data
        , (err)->
            console.log err if err?
            cb err

    @delete = (login)->
        console.log login

    return @
]
