package politicasDeManejoDeError

import procesos.ConsolaDeProcesos
import procesos.ResultadoDeEjecucion

class NoHacerNada extends PoliticaDeManejoDeError{
	
	new(ConsolaDeProcesos _consola) {
		super.consola = _consola
	}
	
	override politiquiar(ResultadoDeEjecucion ejecucion) {
	}
	
}
