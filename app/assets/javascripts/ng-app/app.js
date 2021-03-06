angular
  .module('jumpkiq', [
    'ngAnimate',
    'ngResource',
    'ui.router',
    'templates',
    'Devise',
    'angular-flash.service',
    'angular-flash.flash-alert-directive',
    'angularPayments',
    'angularSpinner'
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
        .state('signup.sizes', {
          url: '/sizes',
          templateUrl: 'signup_form/sizes.html'
        })
        .state('signup.needs', {
          url: '/needs',
          templateUrl: 'signup_form/needs.html'
        })
        .state('signup.styles', {
          url: '/styles',
          templateUrl: 'signup_form/styles.html'
        })
        .state('signup.profile', {
          url: '/profile',
          templateUrl: 'signup_form/profile.html'
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
          url: '',
          templateUrl: 'profile/edit.html'
        })

          .state('profile.edit.profile', {
            url: '/edit',
            templateUrl: 'profile/edit_profile.html'
          })

          .state('profile.edit.billing', {
            url: '/edit',
            templateUrl: 'profile/edit_billing.html',
            controller: 'customersController'
          })

          .state('profile.edit.shipping', {
            url: '/edit',
            templateUrl: 'profile/edit_shipping.html',
            controller: 'addressesController'
          })

          .state('profile.edit.size', {
            url: '/edit',
            templateUrl: 'profile/edit_size.html'
          })

        .state('profile.orders', {
          url: '/orders',
          templateUrl: 'profile/orders.html',
          controller: 'kiqsController'
        })

        .state('profile.conversations', {
          url: '/conversations',
          templateUrl: 'profile/conversations/index.html',
          controller: 'conversationsController'
        })

        .state('profile.newConversation', {
          url: '/conversations/new',
          templateUrl: 'profile/conversations/new.html',
        })

        .state('profile.viewConversation', {
          url: '/conversations/:id',
          templateUrl: 'profile/conversations/show.html',
          controller: 'conversationController'
        })


    $urlRouterProvider.otherwise('/')

    $locationProvider.html5Mode(true);

    // Read from meta tag and set the stripe public key
    // Comment this out to work offline
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  }]);
