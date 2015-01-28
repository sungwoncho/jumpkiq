angular.module('jumpkiq')
  .controller('conversationsController', ['$scope', 'Conversations', function ($scope, Conversations) {
    $scope.conversations = Conversations.query();
  }]);
