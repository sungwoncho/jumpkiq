angular.module('sidekiq')
  .controller('profileController', ['$scope', 'userFactory', 'flash', function ($scope, userFactory, flash) {

    // Get information on the current user
    userFactory.get({}, function (user) {
      $scope.user = user;
    })

    $scope.processKiqForm = function() {
      $scope.user.$update(function() {
        flash.success = "Successfully updated your Kiqs"
      })
    }
  }])
