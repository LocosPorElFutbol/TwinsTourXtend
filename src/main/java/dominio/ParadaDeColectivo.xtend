package dominio

import java.util.List
import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.joda.time.LocalTime
import org.uqbar.geodds.Point

@Entity
@Accessors
@DiscriminatorValue("3")
class ParadaDeColectivo extends POI {

	@Column
	int cantidadParadas

	new() {
	}

	new(String _nombre, String _direccion, Point _coordenadas, List<Review> _reviews, int _cantidadParadas) {
		super(_nombre, _direccion, "parada", _coordenadas, _reviews, "parada.png")
		nombre = _nombre
		this.setDistanciaCercana(0.1)
		cantidadParadas = _cantidadParadas
	}

	override disponibilidad() {
		true
	}

	override disponibilidad(LocalDate fecha, LocalTime hora) {
		true
	}
}
