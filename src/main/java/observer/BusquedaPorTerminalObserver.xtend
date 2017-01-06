package observer

import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedaPorTerminalObserver implements Observer {

	List<BusquedaPorTerminal> listaBusquedaPorTerminal = new ArrayList<BusquedaPorTerminal>

	override notificar(DatosParaObserver _datosParaObserver) {
		listaBusquedaPorTerminal.add(new BusquedaPorTerminal(
			_datosParaObserver.terminal,
			_datosParaObserver.cantidadBusquedas
		))
	}
	
}
