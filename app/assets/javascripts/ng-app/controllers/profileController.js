angular.module('jumpkiq')
  .controller('profileController', ['$scope', 'Users', 'Addresses', 'Customers', 'Kiqs', 'flash', function ($scope, Users, Addresses, Customers, Kiqs, flash) {

    Users.get({}, function (user) {
      $scope.user = user;
    });

    $scope.updateUser = function() {
      $scope.user.$update(function() {
        flash.success = "Successfully updated your information."
      })
    }

  }])
