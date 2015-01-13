angular.module('sidekiq')
  .controller('loginController', [
    '$scope',
    '$location',
    'Auth',
    'flash',
    function($scope, $location, Auth, flash) {
      $scope.loginCredential = {};

      $scope.login = function() {
        var credentials = $scope.loginCredential;

        Auth.login(credentials).then(function(user) {
          console.log(user);
        }, function(error) {
          flash.error = 'Invalid login';
        })
      };

      $scope.$on('devise:login', function(event, currentUser) {
        $location.path('profile');
      });
    }
  ])
