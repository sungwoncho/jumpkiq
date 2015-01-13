angular.module('sidekiq')
  .controller('signupController', ['$scope', 'Auth', '$location', 'flash', function($scope, Auth, $location, flash) {
    $scope.formData = {};

    var displayError = function(error) {
      var errors = error.data.errors;

      for (var key in errors) {
        flash.error = key + ' ' + errors[key];
      }
    }

    $scope.processForm = function() {
      var credentials = $scope.formData;

      Auth.register(credentials)
        .then(function(registeredUser) {
          $location.path('/profile')
        }, displayError);
    }
  }]);
