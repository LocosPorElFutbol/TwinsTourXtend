package procesos

import java.util.List
import java.util.ArrayList
import exepciones.ErrorAlEjecutarException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AccesoMultiple implements Proceso {

	List<Proceso> procesos = new ArrayList<Proceso>

	def agregarProceso(Proceso proceso) {
		procesos.add(proceso)
	}

	override ejecutar() {
		if(procesos.isEmpty) 
			throw new ErrorAlEjecutarException("no hay procesos para ejecutar")
		procesos.forEach[proceso|proceso.ejecutar()]
	}

}
