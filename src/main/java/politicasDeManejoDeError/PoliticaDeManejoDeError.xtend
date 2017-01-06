package politicasDeManejoDeError

import procesos.ResultadoDeEjecucion
import procesos.ConsolaDeProcesos
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class PoliticaDeManejoDeError {
	ConsolaDeProcesos consola
	
	def void tratar(ResultadoDeEjecucion ejecucion){
		consola.termineDeEjecutar(ejecucion)
		this.politiquiar(ejecucion)
	}
	
	def void politiquiar(ResultadoDeEjecucion ejecucion)
	
}