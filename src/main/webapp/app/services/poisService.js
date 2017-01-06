function transformarAPoi(jsonPoi) {
  return Poi.asPoi(jsonPoi);
};

function PoisService($http) {
	var self = this;
	var pois = [];

	self.get = function (id) {
		return _.find(self.pois, { id: id });
	};

	self.getAll = function() {
		return $http.get('http://localhost:9000/pois').then(function(response)
		 {self.pois = response.data; 
			return response.data});
	};


	self.enviarComentario = function(idPoi, usuario, comentario, puntuacion, callback, errorCallback) {
		$http.post('http://localhost:9000/pois/' + idPoi + '/' + usuario + '/' + comentario + '/' + puntuacion).then(callback).catch(errorCallback)
	}

}

angular.module("pois-app")
.factory("PoisService", function($http) {
	return new PoisService($http);
});