'use strict'

angular.module('sidekiq')
  .factory('Customers', ['$resource', function ($resource) {
    return $resource('api/customers/', {format: 'json'}, {
      update: {
        method: 'PUT'
      }
    })
  }]);
