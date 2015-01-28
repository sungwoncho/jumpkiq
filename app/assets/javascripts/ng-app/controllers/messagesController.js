'use strict'

angular.module('jumpkiq')
  .controller('messagesController', ['$scope', 'Messages', 'Conversations', 'flash', function ($scope, Messages, Conversations, flash) {

    $scope.message = new Messages();

    $scope.sendMessage = function () {
      $scope.message.$save(function () {
        flash.success = 'Message sent!';

        $scope.$parent.conversations = Conversations.query();

        $scope.message = new Messages();
      });
    };

  }]);
