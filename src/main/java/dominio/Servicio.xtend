package dominio

import org.joda.time.LocalTime
import org.joda.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Servicio {
	String nombreServicio
	List<Horarios> listaHorarios

	new(String _nombreServicio, List<Horarios> _listaHorarios) {
		nombreServicio = _nombreServicio
		listaHorarios = _listaHorarios
	}

	def boolean tipoServicio(String _tipo) {
		nombreServicio.contains(_tipo)
	}

	def boolean estoyDisponible(LocalDate fecha, LocalTime hora) {
	
		listaHorarios.exists[horarioAtencion | 
		horarioAtencion.diaDisponible(fecha) && 
		horarioAtencion.horaDisponible(hora)]
	}
}
