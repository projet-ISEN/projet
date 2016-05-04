angular.module('app')
.filter 'club', ->

    return (input, patern)->

        unless patern?
            return input
        if patern == ''
            return input

        filtered = []

        for club in input
            if club.club_name.toLowerCase().indexOf(patern.toLowerCase()) > -1
                filtered.push club
        return filtered
.
filter 'firstLetterUppercase', ->
  (input, all) ->
    reg = if all then /([^\W_]+[^\s-]*) */g else /([^\W_]+[^\s-]*)/
    if ! !input then input.replace(reg, ((txt) ->
      txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    )) else ''
