'use strict'

angular.module('jumpkiq')
  .factory('Users', ['$resource', function($resource) {
    return $resource('api/users/', {format: 'json'}, {
      update: {
        method: 'PUT'
      }
    })
  }]);
