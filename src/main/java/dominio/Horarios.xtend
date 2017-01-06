package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalTime
import org.joda.time.LocalDate

@Accessors
class Horarios {
	LocalTime horaDesde
	LocalTime horaHasta
	int[] listaDias = newIntArrayOfSize(7)

	new(LocalTime _horaDesde, LocalTime _horaHasta, int[] _listaDias) {
		horaDesde = _horaDesde
		horaHasta = _horaHasta
		listaDias = _listaDias
	}
	def boolean diaDisponible(LocalDate fecha){
	   listaDias.contains(fecha.getDayOfWeek) 
	}	
	def boolean horaDisponible(LocalTime fecha){
	   fecha.isAfter(horaDesde) && fecha.isBefore(horaHasta)
	}
	
}
