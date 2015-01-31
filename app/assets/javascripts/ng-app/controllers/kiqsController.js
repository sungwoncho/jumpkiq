angular.module('jumpkiq')
  .controller('kiqsController', ['$scope', 'Kiqs', 'flash', function ($scope, Kiqs, flash) {

    $scope.loading = true;

    $scope.kiqs = Kiqs.query(function () {
      $scope.loading = false;
    });

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
    };

    $scope.cancelKiq = function (kiq) {
      kiq.$delete(function () {
        $scope.user.order.has_requested_kiq = false;
        $scope.user.order.ready = true;

        flash.success = 'Successfully cancelled the kiq.'
      })
    };


  }]);
