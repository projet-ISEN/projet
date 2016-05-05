angular.module 'app'
.filter 'firstLetterUppercase', ->
    (input, all) ->
        reg = if all then /([^\W_]+[^\s-]*) */g else /([^\W_]+[^\s-]*)/
        if ! !input then input.replace(reg, ((txt) ->
            txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
        )) else ''
