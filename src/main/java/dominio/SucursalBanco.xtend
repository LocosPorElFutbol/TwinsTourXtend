package dominio

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

@Entity
@Accessors
@DiscriminatorValue("4")
class SucursalBanco extends POI {
	/*Se hardcodea horario de atencion por enunciado 
	 * Idem dias en el constructor */
	static LocalTime horaDesde = new LocalTime(10, 0, 0, 0)
	static LocalTime horaHasta = new LocalTime(15, 0, 0, 0)

//	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	Collection<Servicio> servicios

//	@Column
	@Transient
	Horarios horarioAtencion

	@Transient
	int [] listaDias

	@Column(length=150)
	String barrio

	new() {
	}

	new(String _nombre, String _direccion, Point _coordenadas, List<Review> _reviews, String _barrio,
		Collection<Servicio> _servicios) {
		super(_nombre, _direccion, "banco", _coordenadas, _reviews, "banco.png")
		nombre = _nombre
		listaDias = #[1, 2, 3, 4, 5]
		horarioAtencion = new Horarios(horaDesde, horaHasta, listaDias)
		barrio = _barrio
		servicios = _servicios
	}

	override boolean disponibilidad(LocalDate fecha, LocalTime hora) {
		horarioAtencion.diaDisponible(fecha) && horarioAtencion.horaDisponible(hora)
	}
}
