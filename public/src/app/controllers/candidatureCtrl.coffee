angular.module 'app'
.controller 'candidatureCtrl', ['$user', '$club', '$scope', ($user, $club, $scope)->

  $scope.clearValue = ->
    $scope.myModel = undefined

  ###TODO###
  $scope.save = ->
    alert 'Form was valid!'

  $club.all().then (clubs)->

        $scope.clubs = clubs
        $scope.$apply

]
