angular.module('jumpkiq')
  .controller('customersController', ['$scope', 'Customers', 'flash', function ($scope, Customers, flash) {

    Customers.get().then(function (response) {
      $scope.customer = response.data;
    });

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

            flash.success = 'Succesfully updated the card.';
          });
        } else {
          Customers.post(token)
            .success(function (response) {
            $scope.customer = response;
            flash.success = 'Succesfully added the card.';
          });
        }
      }
    };

    $scope.deleteCard = function () {
      Customers.delete().success(function(response) {
        flash.success = 'Succesfully removed the card.';
        $scope.customer = response;
      });
    };

  }]);
