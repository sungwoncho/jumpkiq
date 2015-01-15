angular.module('sidekiq')
  .controller('profileController', ['$scope', 'Users', 'flash', function ($scope, Users, flash) {

    // Get information on the current user
    Users.get({}, function (user) {
      $scope.user = user;
    })

    $scope.updateUser = function() {
      $scope.user.$update(function() {
        flash.success = "Successfully updated your Kiqs"
      })
    }
  }])
