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
          templateUrl: 'profile/main.html'
        })

        .state('profile.kiqs', {
          url: '/kiqs',
          templateUrl: 'profile/kiqs.html'
        })

        .state('profile.edit', {
          url: '/edit',
          templateUrl: 'profile/edit.html'
        })

          .state('profile.edit.profile', {
            url: '',
            templateUrl: 'profile/edit_profile.html'
          })

          .state('profile.edit.billing', {
            url: '',
            templateUrl: 'profile/edit_billing.html'
          })

          .state('profile.edit.shipping', {
            url: '',
            templateUrl: 'profile/edit_shipping.html'
          })

          .state('profile.edit.size', {
            url: '',
            templateUrl: 'profile/edit_size.html'
          })


    $urlRouterProvider.otherwise('/')

    $locationProvider.html5Mode(true);
  }]);
