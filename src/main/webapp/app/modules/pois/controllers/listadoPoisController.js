function ListadoPoisController(pois, PoisService, $state) {
  var self = this;
  self.poisTotales = "";
  self.pois = pois;
  self.palabra = "";
  self.palabras = [];
  self.usuario = sesionActiva.usuarioActivo;

  self.delete = function (palabra) {
  	_.pull(self.palabras, palabra);
  };

  self.agregar = function () {
  	if (self.palabra !== "") {
	  self.palabras.push(self.palabra);
  	  self.palabra = "";
	}
  };

  self.limpiar = function () {
	   self.palabras = [];
	   self.pois = self.poisTotales;
  };

  self.buscar = function() {
    if (self.poisTotales === "")
    {
      self.poisTotales = PoisService.getAll();
      self.pois = self.poisTotales;
    }
    else
    {
     
    self.pois = _.filter(self.poisTotales, function(poi) {
      return _.some(self.palabras, function (palabra) {
          return _.includes(poi.nombre.toUpperCase(), palabra.toUpperCase())
      });
    });
    };
  };  	

    self.logout = function () {
    sesionActiva.logout($state);
  }; 
}

angular.module("pois-app")
.controller("ListadoPoisController", ListadoPoisController);

ListadoPoisController.$inject = [ "pois", "PoisService", "$state" ];
