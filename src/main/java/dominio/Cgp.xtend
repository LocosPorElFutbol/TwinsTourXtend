package dominio

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Collection
import java.util.List
import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.joda.time.LocalTime
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon

@Entity
@Accessors
@DiscriminatorValue("1")
class Cgp extends POI {
	@JsonIgnore 
	@Transient
	Polygon comuna
	
	//@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	Collection<Servicio> servicios
	
	@Column
	int numeroDeComuna

	new(){}

	new(String _nombre, String _direccion, String _tipo, Point _coordenadas, Collection<Servicio> _servicios, List<Review> _reviews, int _numeroDeComuna) {
		super(_nombre, _direccion, "cgp", _coordenadas, _reviews,"cgp.png")
		comuna = Directorio.getInstancia().miComuna(_coordenadas)
		numeroDeComuna = _numeroDeComuna
		servicios = _servicios
	}

	override calculoDeCercania(Point otroPunto) {
		comuna.isInside(otroPunto)
	}
	
	override disponibilidad(LocalDate fecha, LocalTime hora) {
		servicios.exists[servicio | servicio.estoyDisponible(fecha, hora)]
	}

	override disponibilidad(String _nombreServicio, LocalDate fecha, LocalTime hora) {
		servicios.exists[servicio | servicio.tipoServicio(_nombreServicio) && servicio.estoyDisponible(fecha, hora)]
	}

	override sos(String unNombre) {
		super.sos(unNombre) || contieneServicio(unNombre)
	}
	
	def boolean contieneServicio(String unNombre) {
		servicios.exists[servicio|servicio.tipoServicio(unNombre)]
	}
}
