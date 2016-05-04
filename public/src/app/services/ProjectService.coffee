#------------------------------------------------------------------------------
#           GET CLUB INFOS
#------------------------------------------------------------------------------
angular.module('app')
.service '$project', ['$http', ($http)->
    @all = (cb)->
        $http(
            method: 'GET'
            url: "../../api/projects"

        ).then (res)->          # On success
            cb res.data
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    @idToType = (project_id, cb)->
        $http(
            method: 'GET'
            url: "../../api/projects/" + project_id

        ).then (res)->          # On success
            cb res.data.project_type
        , (err)->              # On error
            console.log err if err?
            cb null
        return

    return this
]
