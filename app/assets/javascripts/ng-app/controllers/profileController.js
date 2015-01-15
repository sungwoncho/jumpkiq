angular.module('sidekiq')
  .controller('profileController', ['$scope', 'Users', 'Addresses', 'flash', function ($scope, Users, Addresses, flash) {

    // Get information on the current user
    Users.get({}, function (user) {
      $scope.user = user;
    })

    Addresses.get({}, function(address) {
      $scope.address = address;
    })

    $scope.updateUser = function() {
      $scope.user.$update(function() {
        flash.success = "Successfully updated your Kiqs."
      })
    }

    $scope.processAddressForm = function () {
      if ($scope.address.exists) {
        $scope.updateAddress();
      } else {
        $scope.createAddress();
      }
    }

    $scope.updateAddress = function() {
      $scope.address.$update(function() {
        flash.success = "Successfully updated your address."
      })
    }

    $scope.createAddress = function() {
      $scope.address.$save(function() {
        flash.success = "Successfully created your address."
      })
    }
  }])
