'use strict'

angular.module('sidekiq')
  .factory('userFactory', ['$resource', function($resource) {
    return $resource('api/users/', {format: 'json'})
  }]);
