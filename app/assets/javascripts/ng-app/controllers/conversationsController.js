angular.module('jumpkiq')
  .controller('conversationsController', ['$scope', 'Conversations', function ($scope, Conversations) {
    $scope.loading = true;

    $scope.conversations = Conversations.query(function () {
      $scope.loading = false;
    });
  }]);
