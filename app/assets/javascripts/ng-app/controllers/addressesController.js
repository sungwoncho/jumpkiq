angular.module('jumpkiq')
  .controller('addressesController', ['$scope', 'Addresses', 'flash', function ($scope, Addresses, flash) {

    $scope.loading = true;

    Addresses.get({}, function(address) {
      $scope.address = address;
      $scope.loading = false;
    });

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

  }])
