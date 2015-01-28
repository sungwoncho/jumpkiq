'use strict'

angular.module('jumpkiq')
  .factory('Conversations', ['$resource', function ($resource) {
    return $resource('api/conversations/:id', { id: '@id', format: 'json' });
  }]);
