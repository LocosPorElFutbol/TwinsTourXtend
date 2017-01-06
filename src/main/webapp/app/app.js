'use strict';

var app = angular.module('pois-app', ['ui.router'])
.config(function($urlRouterProvider, $locationProvider) {
  $urlRouterProvider.otherwise('/login');
  return $locationProvider.html5Mode(true);
})
.constant('_', window._)
.config(function($stateProvider) {
  return $stateProvider
  .state('main', {
    abstract: true,
    views: {
      'layout': {
        templateUrl: "app/layout/layout.html"
      },
      'container@main': {
        template: "<ui-view>"
      }
    }
  });
});
  
