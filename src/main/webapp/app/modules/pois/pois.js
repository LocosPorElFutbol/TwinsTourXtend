angular.module('pois-app')
.config(function($stateProvider) {
  return $stateProvider
  .state('main.login', {
    url: "/login",
    templateUrl: "app/modules/pois/views/login.html",
    controller: "logincontroller",
    controllerAs: "logincontroller",
    })

  .state('main.listado_pois', {
    url: "/pois",
    templateUrl: "app/modules/pois/views/lista.html",
    controller: "ListadoPoisController",
    controllerAs: "listadoController",
    resolve: {
      pois: function (PoisService) {
         return PoisService.getAll();
      }
    }
  })

.state('main.mostrar_modal', {
    url: "/pois/detalle/:id",
    templateUrl: "app/modules/pois/views/modalPoi.html",
    controller: "poiController",
    controllerAs: "modalPoiController",
    resolve: {
      poi: function (PoisService, $stateParams) {
       return PoisService.get(parseInt($stateParams.id)); 
     }
    }
  })
  .state('main.mostrar_modal.cgp', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/cgp.html" } }
  })
  .state('main.mostrar_modal.comercio', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/comercio.html" } }
  })
  .state('main.mostrar_modal.banco', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/banco.html" } }
  })
  .state('main.mostrar_modal.parada', {
    views : { "tipo-poi": { templateUrl: "app/modules/pois/views/parada.html" } }
  })

  .state('main.parada', {
    url: "/pois/parada",
    templateUrl: "app/modules/pois/views/images/parada.png"
  })


});