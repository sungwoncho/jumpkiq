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

    $scope.getKiqErrorMessage = function () {
      if (!$scope.user.order.has_style) {
        return 'Please specify your styles.'
      } else if (!$scope.user.order.has_need) {
        return 'Please specify your needs.'
      } else if (!$scope.user.order.has_shipping_address) {
        return 'Please add your shipping address before requesting a kiq.'
      } else if (!$scope.user.order.has_credit_card) {
        return 'Please add credit card before requesting a kiq.'
      } else if ($scope.user.order.has_requested_kiq) {
        return 'You already requested a kiq. Please see My Order page for more information.'
      }
    };

    $scope.requestKiq = function () {
      if ($scope.user.order.ready) {
        $scope.kiq = new Kiqs();
        $scope.kiq.$save(function () {
          $scope.user.order.has_requested_kiq = true;
          $scope.user.order.ready = false;

          flash.success = 'success.'
        })
      } else {
        flash.error = $scope.getKiqErrorMessage();
      }
    }



  }])
