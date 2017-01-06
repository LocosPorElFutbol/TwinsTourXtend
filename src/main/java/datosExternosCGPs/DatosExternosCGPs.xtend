package datosExternosCGPs

import dominio.Cgp
import dominio.DatosExternos
import dominio.Horarios
import dominio.POI
import dominio.Servicio
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalTime
import org.uqbar.geodds.Point

@Accessors
class DatosExternosCGPs implements DatosExternos{
	BaseDeDatosCGPs datosExternos
	
	override buscar(String palabra) {
		var List<CentroDTO> resultadoDeLaBusqueda = datosExternos.buscar(palabra)
		
		transformarBusquedaAPOIs(resultadoDeLaBusqueda)
	}
	
	def transformarBusquedaAPOIs(List<CentroDTO> cgpsATransformar) {
		cgpsATransformar.map[ cgp | transformar(cgp)]
	}
	
	def POI transformar(CentroDTO cgpExterna) {
		var String nombre = cgpExterna.nombreCompleto
		var String direccion = cgpExterna.domicilioCompleto
		var String tipo = cgpExterna.tipo
		var Point coordenada = new Point(cgpExterna.x, cgpExterna.y)
		
		var List<Servicio> servicios = new ArrayList<Servicio>()
		servicios = cgpExterna.serviciosDTO.map[ servicio | transformarServicio(servicio)]
		
		new Cgp(nombre, direccion, tipo, coordenada, servicios, null, 1)
		
	}

	def transformarServicio(ServicioDTO servicioATransformar) {
		var List<Horarios> horarios = new ArrayList<Horarios>()
		horarios = servicioATransformar.rangosServicioDTO.map[ horario | transformarHorario(horario)]		
		
		new Servicio(servicioATransformar.nombreDelServicio, horarios)
	}
	
	def transformarHorario(RangoServicioDTO horarioATransformar) {
		var LocalTime horaDesde = new LocalTime(horarioATransformar.horarioDesde, horarioATransformar.minutoDesde, 0, 0)
		var LocalTime horaHasta = new LocalTime(horarioATransformar.horarioHasta, horarioATransformar.minutoHasta, 0, 0)
		
		new Horarios(horaDesde, horaHasta, #[horarioATransformar.numeroDia])
	}
	
}
