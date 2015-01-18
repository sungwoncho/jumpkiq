'use strict'

angular.module('sidekiq')
  .factory('Kiqs', ['$resource', function ($resource) {
    return $resource('api/kiqs/:id', {id: '@id', format: 'json'}, { query: { method: 'GET', isArray: false} });
  }]);
