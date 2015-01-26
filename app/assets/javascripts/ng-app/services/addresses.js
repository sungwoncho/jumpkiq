'use strict'

angular.module('jumpkiq')
.factory('Addresses', ['$resource', function($resource) {
  return $resource('api/addresses/', {format: 'json'}, {
    update: {
      method: 'PUT'
    }
  })
}]);
