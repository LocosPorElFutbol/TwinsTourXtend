package observer

import dominio.POI
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedaPorTerminal {
	POI terminal
	int cantidadDeResultados
	
	new(POI _terminal, int _cantidadDeResultados){
		terminal = _terminal
		cantidadDeResultados = _cantidadDeResultados
	}
}