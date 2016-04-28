angular.module 'app'
.controller 'AppCtrl', ($scope) ->

  $scope.clearValue = ->
    $scope.myModel = undefined

  $scope.save = ->
    alert 'Form was valid!'
