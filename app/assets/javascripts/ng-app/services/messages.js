'use strict';

angular.module('sidekiq')
  .factory('Messages', ['$resource', function ($resource) {
    return $resource('api/messages', { format: 'json' });
  }]);
