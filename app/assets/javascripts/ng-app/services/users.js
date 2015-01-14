'use strict'

angular.module('sidekiq')
  .factory('Users', ['$resource', function($resource) {
    return $resource('api/users/', {format: 'json'}, {
      update: {
        method: 'PUT'
      }
    })
  }]);
