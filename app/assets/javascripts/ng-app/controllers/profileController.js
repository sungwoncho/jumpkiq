angular.module('sidekiq')
  .controller('profileController', ['$scope', 'Users', 'Addresses', 'Customers', 'flash', function ($scope, Users, Addresses, Customers, flash) {

    // Get information on the current user
    Users.get({}, function (user) {
      $scope.user = user;
    })

    Addresses.get({}, function(address) {
      $scope.address = address;
    })

    Customers.get().then(function (response) {
      $scope.customer = response.data;
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
        token = response.id;

        if ($scope.customer.exists) {
          // If already exists, make PUT call
          Customers.put(token).success(function (response) {
            // Bind the new customer to scoped variable
            $scope.customer = response;
          })
        } else {
          Customers.post(token).success(function (response) {
            $scope.customer = response;
          })
        }
      }
    };

    $scope.deleteCard = function () {
      Customers.delete().success(function(response) {
        $scope.customer = response;
      });
    };

  }])
