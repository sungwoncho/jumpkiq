angular.module('sidekiq')
  .directive('header', function() {
    return {
      restrict: 'A',
      replace: true,
      templateUrl: 'layouts/header.html'
    };
  })
