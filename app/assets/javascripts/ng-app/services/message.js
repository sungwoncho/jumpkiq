'use strict'

angular.module('jumpkiq')
  .factory('Messages', ['$resource', function ($resource) {
    return $resource('api/messages', { format: 'json' })
  }])
