angular.module('sidekiq')
  .directive('header', function() {
    return {
      restrict: 'A',
      replace: true,
      templateUrl: 'layouts/header.html',
      controller: ['$scope', 'Auth', function($scope, Auth) {

        $scope.$watch('Auth.currentUser()', function(newVal) {
          if (newVal) {
            console.log(newVal);
            $scope.signed_in = true;
          } else {
            $scope.signed_in = false;
          }
        })

        // Auth.currentUser().then(function(user) {
        //   $scope.signed_in = true;
        // }, function (error) {
        //   $scope.signed_in = false;
        // });

        $scope.logout = function() {
          Auth.logout().then(function(oldUser) {
            console.log('signed out');
            $scope.signed_in = false;
          }, function(error) {
            console.log(error);
          });
        }

      }]
    }
  });
