package juegoDeDatosParaTest

import dominio.Usuario
import repositorio.RepoUsuarios

class AlmacenUsuarios {

	def crearUsuarios()
	{
		var napoleon = new Usuario("napo_bona69", "utn")
		var a = new Usuario("a", "a")
		var usuario1 = new Usuario("usuario1", "utn")
		
		RepoUsuarios.instancia.registrar(napoleon)
		RepoUsuarios.instancia.registrar(a)
		RepoUsuarios.instancia.registrar(usuario1)
	}	
}