angular.module 'app'
.controller 'candidatureCtrl', ['$user', '$club', '$scope', ($user, $club, $scope)->

  $scope.clearValue = ->
    $scope.myModel = undefined

  ###TODO###
  $scope.save = ->
    alert 'Form was valid!'


  $scope.choosing = ->
    #for club in clubs
    #if club.club_id == true

  $club.all().then (clubs)->

        $scope.clubs = clubs
        $scope.$apply

]
