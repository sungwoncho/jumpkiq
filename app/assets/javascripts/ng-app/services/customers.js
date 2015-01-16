'use strict'

angular.module('sidekiq')
  .factory('Customers', ['$http', function ($http) {
    var api = {};

    api.get = function () {
      return $http.get('api/customers/');
    }

    api.post = function (token) {
      return $http.post('api/customers?stripeToken=' + token)
    }

    api.put = function (token) {
      return $http.put('api/customers?stripeToken=' + token)
    }

    return api;
  }]);
