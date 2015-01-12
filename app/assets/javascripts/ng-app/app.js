angular
  .module('sidekiq', [
    'ngAnimate',
    'ui.router',
    'templates'
  ])
  .config(['$stateProvider', '$urlRouterProvider', '$locationProvider', function($stateProvider, $urlRouterProvider, $locationProvider) {
    $stateProvider
      .state('signup', {
        url: '/signup',
        templateUrl: 'signup_form/form.html',
        controller: 'signupController'
      })

      // nested states
      // url will also be nested (i.e. /signup/measurements)
      .state('signup.measurements', {
        url: '/measurements',
        templateUrl: 'signup_form/measurements.html'
      })
      .state('signup.sizes', {
        url: '/sizes',
        templateUrl: 'signup_form/sizes.html'
      })
      .state('signup.needs', {
        url: '/needs',
        templateUrl: 'signup_form/needs.html'
      })
      .state('signup.account', {
        url: '/account',
        templateUrl: 'signup_form/account.html'
      });

    $urlRouterProvider.otherwise('signup/measurements')

    $locationProvider.html5Mode(true);
  }]);
