package observer

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class BusquedaPorFecha {
	LocalDate fecha
	int cantidadDeResultados

	new(LocalDate _fecha, int _cantidadDeResultados) {
		fecha = _fecha
		cantidadDeResultados = _cantidadDeResultados
	}
}
