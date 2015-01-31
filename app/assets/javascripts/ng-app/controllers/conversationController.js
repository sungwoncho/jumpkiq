angular.module('jumpkiq')
  .controller('conversationController', ['$scope', '$http', '$stateParams', 'Conversations', 'Messages', 'flash', function ($scope, $http, $stateParams, Conversations, Messages, flash) {
    $scope.loading = true;

    $scope.conversation = Conversations.get({id: $stateParams.id}, function () {
      $scope.loading = false;
    });

    $scope.replyBody = '';

    $scope.reply = function () {
      $http.put('api/conversations/'+ $scope.conversation.id + '/?reply=' + true + '&body=' + $scope.replyBody)
        .success(function (response) {
          flash.success = 'Successfully sent a message.';
          $scope.conversation.messages.push(response.messages[0]);
          $scope.replyBody = '';
        })
        .error(function () {
          flash.error= 'Something went wrong. Please try again.';
        })
    };

  }])
