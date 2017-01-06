package observer

import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedaPorFechaObserver implements Observer {

	List<BusquedaPorFecha> listaBusquedaPorFecha = new ArrayList<BusquedaPorFecha>

	override notificar(DatosParaObserver _datosParaObserver) {
		listaBusquedaPorFecha.add(new BusquedaPorFecha(
			_datosParaObserver.fechaBusqueda,
			_datosParaObserver.cantidadBusquedas
		))
	}
	
}
