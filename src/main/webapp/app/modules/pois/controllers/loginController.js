function Sesion() {
	var self = this;
	self.usuarioActivo = "";

	self.login = function(usuario, $state)
	{
		self.usuarioActivo = usuario;
		$state.go("main.listado_pois");
	};

	self.logout = function($state)
	{
		self.usuarioActivo = "";
		$state.go("main.login");
	};
};

var sesionActiva = new Sesion();
//-------------------------------------------------------------------------------

function logincontroller(UsuarioService, $state) {
	var self = this;

	self.usuario = "";
	self.password = "";

	self.login = function()
	{
		UsuarioService.callValidar(self.usuario, self.password, function(response) {
				sesionActiva.login(self.usuario, $state);
		}, function(response) {
			alert(response.data.error);
		})	
	};
};

angular.module("pois-app")
.controller("logincontroller", logincontroller);

logincontroller.$inject = [ "UsuarioService", "$state" ];

//----------------------------------------------------------------------------------------

function UsuarioService($http) {
	var self = this;
	self.respuesta;

	self.callValidar = function(usuario, contrasenia, callback, errorCallback) {

		var usr = new UsuarioEntity();
		usr.cuenta = usuario;
		usr.password = contrasenia;

		$http.post('/validarUsuario', usr).then(callback).catch(errorCallback);
	};
};

angular.module("pois-app")
.factory("UsuarioService", function($http) {
	return new UsuarioService($http);
});