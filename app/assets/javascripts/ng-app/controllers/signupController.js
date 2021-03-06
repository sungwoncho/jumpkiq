angular.module('jumpkiq')
  .controller('signupController', ['$scope', '$window', '$timeout', 'Auth', '$location', 'flash', function($scope, $window, $timeout, Auth, $location, flash) {
    $scope.formData = {};


    $scope.processForm = function() {
      var credentials = $scope.formData;

      Auth.register(credentials)
        .then(function(registeredUser) {
          $scope.registrationComplete = true;

          $timeout(function () {
            $window.location.href='/profile/main'
          }, 500)
        }, function(error) {
          var errors = error.data.errors;

          for (var key in errors) {
            flash.error = key + ' ' + errors[key];
          }
        });
    }

    $scope.checkInput1 = function($event) {
      if ('height' in $scope.formData && 'weight' in $scope.formData && 'casual_shirt_size' in $scope.formData) {

      } else {
        $event.preventDefault();
        flash.error = 'Please fill in required field';
        return;
      }
    }

    $scope.checkInput2 = function($event) {
      if ('longsleeve' in $scope.formData || 'shortsleeve' in $scope.formData || 'polo_shirt' in $scope.formData || 'pants' in $scope.formData || 'shorts' in $scope.formData) {

      } else {
        $event.preventDefault();
        flash.error = 'Please select at least one item.';
      }
    }


  }]);
