angular.module('sidekiq')
  .controller('profileController', ['$scope', 'userFactory', function ($scope, userFactory) {
    userFactory.get({}, function (user) {
      $scope.user = user;
    })
  }])
