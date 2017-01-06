function poiController(PoisService, poi, $state) {
  var self = this;
  self.mostrarError = false;
  self.mostrarErrorUsuario = false;
  self.poi = poi;
  self.comentario = '';
  self.puntuacion = '';
  self.errorUsuario = '';



  self.abrirTipoPoi = function () {
    console.log(self.poi);
    $state.go("main.mostrar_modal." + self.poi.tipo.toLowerCase());
  };



 self.enviarComentario = function() {
   if(self.comentario !== "" && self.puntuacion !== "" ) {
     self.mostrarError = false;
        PoisService.enviarComentario(self.poi.id , sesionActiva.usuarioActivo, self.comentario, self.puntuacion, function(){
      self.poi.reviews.push({
       usuario:sesionActiva.usuarioActivo,
       calificacion:self.puntuacion,
       comentario:self.comentario});
      self.calcularCalificacionGeneral();
      $state.reload()
    }, function(response) {self.mostrarErrorUsuario = true; self.errorUsuario = response.data}); 
  } else {
   self.mostrarError = true;
 }
}

 self.calcularCalificacionGeneral = function() {
    self.poi.calificacionGeneral = _.sumBy(self.poi.reviews, function(review) {
      return _.parseInt(review.calificacion) }) / self.poi.reviews.length
 }

};

angular.module("pois-app")
.controller("poiController", poiController);

poiController.$inject = [ "PoisService", "poi", "$state" ];