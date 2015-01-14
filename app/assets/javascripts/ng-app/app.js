angular
  .module('sidekiq', [
    'ngAnimate',
    'ngResource',
    'ui.router',
    'templates',
    'Devise',
    'angular-flash.service',
    'angular-flash.flash-alert-directive'
  ])
  .config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 'flashProvider', function($stateProvider, $urlRouterProvider, $locationProvider, flashProvider) {

    flashProvider.errorClassnames.push("alert-danger");
    flashProvider.warnClassnames.push("alert-warning");
    flashProvider.infoClassnames.push("alert-info");
    flashProvider.successClassnames.push("alert-success");

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
        .state('signup.needs', {
          url: '/needs',
          templateUrl: 'signup_form/needs.html'
        })
        .state('signup.kiqs', {
          url: '/kiqs',
          templateUrl: 'signup_form/kiqs.html'
        })
        .state('signup.account', {
          url: '/account',
          templateUrl: 'signup_form/account.html'
        })

      .state('profile', {
        url: '/profile',
        templateUrl: 'profile/profile.html',
        controller: 'profileController'
      })

        .state('profile.main', {
          url: '/main',
          views: {
            'aside': { templateUrl: 'profile/stylist.html' },
            'body': { templateUrl: 'profile/main.html' }
          }
        })

        .state('profile.kiqs', {
          url: '/kiqs',
          views: {
            'aside': { templateUrl: 'profile/stylist.html' },
            'body': { templateUrl: 'profile/kiqs.html' }
          }
        })


    $urlRouterProvider.otherwise('/')

    $locationProvider.html5Mode(true);
  }]);
