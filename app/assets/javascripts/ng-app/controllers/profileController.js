angular.module('sidekiq')
  .controller('profileController', ['$scope', 'Users', 'Addresses', 'Customers', 'flash', function ($scope, Users, Addresses, Customers, flash) {

    // Get information on the current user
    Users.get({}, function (user) {
      $scope.user = user;
    })

    Addresses.get({}, function(address) {
      $scope.address = address;
    })

    Customers.get({}, function (customer) {
      $scope.customer = customer;
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

    $scope.handleStripe = function (status, response) {
      if (response.error) {
        flash.error = response.error.message;
      } else {
        token = response.id
        console.log(token);
      }
    }

  }])
