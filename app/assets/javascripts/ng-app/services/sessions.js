angular.module('sidekiq')
  .factory('Sessions', ['Auth', function(Auth) {

    var api = {};

    Auth.currentUser().then(function(user) {
      api.signed_in = true;
    }, function (error) {
      api.signed_in = false;
    });

    return api;

  }]);
