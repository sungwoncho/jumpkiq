angular.module('jumpkiq')
  .controller('profileController', ['$scope', 'Users', 'flash', function ($scope, Users, flash) {

    Users.get({}, function (user) {
      $scope.user = user;
    });

    $scope.updateUser = function() {
      $scope.user.$update(function() {
        flash.success = "Successfully updated your information."
      })
    }

  }])
