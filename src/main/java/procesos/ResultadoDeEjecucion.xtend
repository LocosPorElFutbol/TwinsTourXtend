package procesos

import dominio.Administrador
import exepciones.ErrorAlEjecutarException
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

@Accessors
class ResultadoDeEjecucion {
	ConsolaDeProcesos consola
	DateTime horaInicio
	DateTime horaFinalizacion
	Proceso procesoEjecutado
	Administrador usuario
	String resultado
	String mensajeDeError
	int intentosDeEjecucion = 0
	
	new(Proceso _proceso, Administrador _usuario, ConsolaDeProcesos _consola){
		procesoEjecutado = _proceso
		usuario = _usuario
		consola = _consola
	}
	
	def inicioEjecucionDeProceso() {
		horaInicio = DateTime.now
	}
	
	def finalizoEjecucionDelProceso() {
		horaFinalizacion = DateTime.now
	}
	
	def void ejecutar() {
		inicioEjecucionDeProceso
		try{
			lanzarProceso()
		}
		catch(ErrorAlEjecutarException exception) {
			resultado = "error"
			mensajeDeError = exception.message
			consola.finaliceConError(this)
		}
		finalizoEjecucionDelProceso
	}
	
	def void lanzarProceso() {
		intentosDeEjecucion++
		procesoEjecutado.ejecutar()
		resultado = "ok"
		consola.termineDeEjecutar(this)	
	}
}
