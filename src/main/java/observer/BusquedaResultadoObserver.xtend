package observer

import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedaResultadoObserver implements Observer {

	List<BusquedaResultado> listaBusquedaResultado = new ArrayList<BusquedaResultado>
	

	override notificar(DatosParaObserver _datosParaObserver) {
		listaBusquedaResultado.add(new BusquedaResultado(
			_datosParaObserver.fraseBuscada,
			_datosParaObserver.cantidadBusquedas,
			_datosParaObserver.tiempoDemoraBusqueda
		))
	}
	
}
