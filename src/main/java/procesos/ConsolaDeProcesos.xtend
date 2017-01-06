package procesos

import java.util.List
import dominio.Administrador
import org.eclipse.xtend.lib.annotations.Accessors
import politicasDeManejoDeError.PoliticaDeManejoDeError
import politicasDeManejoDeError.NoHacerNada
import java.util.ArrayList

@Accessors
class ConsolaDeProcesos {
	List<ResultadoDeEjecucion> procesosAEjecutar = new ArrayList<ResultadoDeEjecucion>
	List<ResultadoDeEjecucion> resultados = new ArrayList<ResultadoDeEjecucion>
	PoliticaDeManejoDeError manejoDeError = new NoHacerNada(this)
	
	def ejecutarProcesos(){
		procesosAEjecutar.forEach[unProceso |	unProceso.ejecutar ]
		procesosAEjecutar.clear
	}
	
	def termineDeEjecutar(ResultadoDeEjecucion resultado) {
		resultados.add(resultado)
	}
	
	def agregarProceso(Proceso _proceso, Administrador _usuario) {
		procesosAEjecutar.add(new ResultadoDeEjecucion(_proceso, _usuario, this))
	}
	
	def finaliceConError(ResultadoDeEjecucion _resultado){
		manejoDeError.tratar(_resultado)
	}
}
