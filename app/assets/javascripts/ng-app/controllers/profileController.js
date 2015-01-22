angular.module('sidekiq')
  .controller('profileController', ['$scope', 'Users', 'Addresses', 'Customers', 'Kiqs', 'flash', function ($scope, Users, Addresses, Customers, Kiqs, flash) {

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

    $scope.kiqs = Kiqs.query();

    // Kiqs.query({}, function (kiqs) {
    //   $scope.kiqs = kiqs;
    // })

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
        flash.success = "Successfully updated your address.";
      })
    }

    $scope.createAddress = function() {
      $scope.address.$save(function() {
        flash.success = "Successfully created your address.";
        $scope.address.exists = true;
        $scope.user.order.has_shipping_address = true;
      })
    };

    $scope.deleteAddress = function () {
      $scope.address.$delete(function () {
        flash.success = 'Successfully removed the address.';

        Addresses.get({}, function(address) {
          $scope.address = address;
        })

      }, function () {
        flash.error = 'You cannot remove the address while a Kiq is in progress.';
      });
    };

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
            $scope.user.order.has_credit_card = true;
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

    $scope.getKiqErrorMessage = function () {
      if (!$scope.user.order.has_style) {
        return 'Please specify your styles.';
      } else if (!$scope.user.order.has_need) {
        return 'Please specify your needs.';
      } else if (!$scope.user.order.has_shipping_address) {
        return 'Please add your shipping address before requesting a kiq.';
      } else if (!$scope.user.order.has_credit_card) {
        return 'Please add credit card before requesting a kiq.';
      } else if ($scope.user.order.has_requested_kiq) {
        return 'You already requested a kiq. Please see My Order page for more information.';
      }
    };

    $scope.requestKiq = function () {
      if ($scope.user.order.ready) {
        $scope.kiq = new Kiqs();
        $scope.kiq.$save(function (response) {
          $scope.user.order.has_requested_kiq = true;
          $scope.user.order.ready = false;

          $scope.kiqs = Kiqs.query();
          flash.success = 'Successfully requested a kiq.'
        })
      } else {
        flash.error = $scope.getKiqErrorMessage();
      }
    }

    $scope.cancelKiq = function (kiq) {
      kiq.$delete(function () {
        $scope.user.order.has_requested_kiq = false;
        $scope.user.order.ready = true;

        flash.success = 'Successfully cancelled the kiq.'
      })
    }



  }])
