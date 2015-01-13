angular.module('sidekiq')
  .controller('signupController', ['$scope', 'Auth', '$window', function($scope, Auth, $window) {
    $scope.formData = {};

    $scope.processForm = function() {
      var credentials = $scope.formData;

      Auth.register(credentials)
        .then(function(registeredUser) {
          $window.location.path('user/' + registeredUser.id)
        }, function (error) {
          alert(error.errors);
        });
    }
  }]);
