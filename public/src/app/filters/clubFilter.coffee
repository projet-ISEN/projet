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
