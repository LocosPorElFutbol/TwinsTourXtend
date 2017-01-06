package politicasDeManejoDeError

import exepciones.ErrorAlEjecutarException
import procesos.ResultadoDeEjecucion

class ReintentarEjecucion extends PoliticaDeManejoDeError {
	int reintentos

	new(int _reintentos, procesos.ConsolaDeProcesos _consola) {
		reintentos = _reintentos
		super.consola = _consola
	}
	
	override politiquiar(ResultadoDeEjecucion ejecucion) {
			var reintentosActuales = reintentos
		while (reintentosActuales > 0) {
			try {
				ejecucion.lanzarProceso()
				reintentosActuales = -1
			} catch (ErrorAlEjecutarException exception) {
				reintentosActuales--
			} finally{
				ejecucion.finalizoEjecucionDelProceso
			}
		}

		if (reintentosActuales == 0) {
			consola.termineDeEjecutar(ejecucion)
		}
	}
	
}
