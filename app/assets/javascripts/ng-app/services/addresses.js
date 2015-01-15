'use strict'

angular.module('sidekiq')
.factory('Addresses', ['$resource', function($resource) {
  return $resource('api/addresses/', {format: 'json'}, {
    update: {
      method: 'PUT'
    }
  })
}]);
