package dominio

import procesos.ConsolaDeProcesos
import procesos.Proceso
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Administrador {
	ConsolaDeProcesos consola
	String mail
	
	new(String _mail, ConsolaDeProcesos _consola) {
		mail=_mail
		consola=_consola
	}
	
	def agregarProcesoAListaDeEjecucion(Proceso proceso) {
		consola.agregarProceso(proceso, this)
	}
	
	def ejecutarTodosLosProcesosPendientes() {
		consola.ejecutarProcesos
	}
}