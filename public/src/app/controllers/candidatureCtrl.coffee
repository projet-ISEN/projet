angular.module 'app'
.controller 'candidatureCtrl', ['$user', '$club', '$scope', ($user, $club, $scope)->

  $scope.choices = []

  $scope.clearValue = ->
    $scope.myModel = undefined

  ###TODO###
  $scope.save = ->
    alert 'Form was valid!'


  $scope.choosing = ->
    console.log $scope.choices
    ###for club in $scope.clubs
        club.hide = false

    # Si le club fait partis des choix on l'enleve de la liste
    for choice in $scope.choices
        # Choice est un ID de CLUB

        indice = $scope.clubs.indexOf( choice )
        console.log indice
        $scope.clubs[indice].hide = true
    return###



  $scope.goCapisen = ->
        alert "Prévenons Capisen !"

  $club.all().then (clubs)->

        $scope.clubs = clubs
        $scope.$apply
]
