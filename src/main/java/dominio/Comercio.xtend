package dominio

import java.util.ArrayList
import java.util.List
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.joda.time.LocalTime
import org.uqbar.geodds.Point

@Entity
@Accessors
@DiscriminatorValue("2")
class Comercio extends POI {
	
	//@Column
	@Transient
	Rubro rubro
	
	//@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	List<Horarios> listaHorarios
	
	//@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	List<String> palabrasClave

	new(){}

	new(String _nombre, String _direccion, Point _coordenadas, Rubro _rubro, List<Horarios> _listaHorarios, List<Review> _reviews) {
		super(_nombre, _direccion, "comercio", _coordenadas, _reviews, "comercio.png")
		rubro = _rubro
		listaHorarios = _listaHorarios
		palabrasClave = new ArrayList<String>
	}

	override boolean disponibilidad(LocalDate fecha, LocalTime hora) {
		listaHorarios.exists[horarioAtencion | 
		horarioAtencion.diaDisponible(fecha) && 
		horarioAtencion.horaDisponible(hora)]
	}


	override sos(String unNombre) {
		super.sos(unNombre) || rubro.es(unNombre)
	}
	
	override calculoDeCercania(Point otroPunto) {
		coordenadas.distance(otroPunto) < rubro.radioDeCercania
	}
	
	override actualizar(String nombre, String[] listaPalabras) {
		if (super.sos(nombre)) {
			if (listaPalabras.get(0).length == 0)
				palabrasClave.clear
			else
				palabrasClave = listaPalabras
		}	
	}
}
