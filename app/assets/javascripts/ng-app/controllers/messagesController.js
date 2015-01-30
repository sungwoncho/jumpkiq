'use strict'

angular.module('jumpkiq')
  .controller('messagesController', ['$scope', 'Messages', 'flash', function ($scope, Messages, flash) {

    $scope.message = new Messages();

    $scope.sendMessage = function () {
      $scope.message.$save(function (response) {
        flash.success = 'Message sent!';
        $scope.message = new Messages();
      });
    };

  }]);
