package controller

import dominio.Directorio
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Post
import exepciones.UsuarioRepetidoException
import juegoDeDatosParaTest.AlmacenUsuarios
import dominio.Usuario
import repositorio.RepoUsuarios

@Controller
class PoisController {

	extension JSONUtils = new JSONUtils

	def static void main(String[] args) {
		var datos = new AlmacenUsuarios
		datos.crearUsuarios

		XTRest.start(PoisController, 9000)
	}

	@Get("/pois")
	def Result pois() {
		val pois = Directorio.instancia.allInstances
		response.contentType = ContentType.APPLICATION_JSON
		ok(pois.toJson)
	}

	@Post('/pois/:poiId/:usuario/:comentario/:puntaje')
	def Result agregarComentario() {
		val poi = Directorio.repoPois.searchById(Long.parseLong(poiId))
		try {
			poi.agregarReview(usuario, comentario, Integer.parseInt(puntaje))
			Directorio.repoPois.update(poi)
			ok('{ "status" : "OK" }')
		} catch (UsuarioRepetidoException e) {
			internalServerError(e.message)
		}
	}

	@Post("/validarUsuario")
	def Result validaUsuario(@Body String body) {
		
		val usr = body.fromJson(Usuario)
		val usuario = new Usuario(usr.cuenta, usr.password)
		
		if (RepoUsuarios.instancia.validar(usuario)) {
			ok('{ "status" : "OK" }')
		} else {
			internalServerError('{ "error" : "El usuario o contraseña no existen." }')
		}
	}
	
}