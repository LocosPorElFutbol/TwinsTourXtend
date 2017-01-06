package procesos

import org.joda.time.LocalDate

class ResultadoRestBaja {
	
	public String valorBusqueda
	public LocalDate fechaBaja
	
	new(String _valorBusqueda, LocalDate _fechaBaja){
		valorBusqueda = _valorBusqueda
		fechaBaja = _fechaBaja
	}	
}