'use strict'

angular.module('jumpkiq')
  .factory('Kiqs', ['$resource', function ($resource) {
    return $resource('api/kiqs/:id', { id: '@id', format: 'json' });
  }]);
