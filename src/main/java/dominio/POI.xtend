package dominio

import com.fasterxml.jackson.annotation.JsonIgnore
import exepciones.UsuarioRepetidoException
import java.util.ArrayList
import java.util.List
import java.util.Objects
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.joda.time.LocalTime
import org.uqbar.geodds.Point

@Entity
@Accessors
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoPoi", discriminatorType=DiscriminatorType.INTEGER)
class POI {
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=150)
	String nombre
	
	@Column(length=150)
	String direccion
	
	@Column(length=150)
	String tipo
	
	@JsonIgnore
	@Transient 
	Point coordenadas
	
	@Column
	double distanciaCercana = 0.5
	
	@Column
	boolean activo = true
	
	@Column
	double calificacionGeneral
	
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	//@Transient
	List<Review> reviews = new ArrayList<Review>
	
	@Column(length=150)
	String usuario
	
	@Column
	String comentario
	
	@Column
	int calificacion
	
	@Column
	String imagen
	new() {
	}

	new(String _nombre, String _direccion, String _tipo, Point _coordenadas, List<Review> _reviews, String _imagen) {
		nombre = _nombre
		direccion = _direccion
		tipo = _tipo
		coordenadas = _coordenadas
		reviews = _reviews
		calificacionGeneral = calificacionGeneral()
		imagen = "/app/modules/pois/views/images/" + _imagen
	}

	def calificacionGeneral() {
		if (reviews.size > 0) {
			calificacionGeneral = (this.reviews.fold(0)[resultado, unReview|resultado + unReview.calificacion]) / reviews.size
		} else{
			calificacionGeneral = 0
		}
	}

    def agregarReview(String usuarioNuevo, String comentario, int calificacion) {
    	if (!reviews.exists[review | review.usuario == usuarioNuevo]) {
			this.reviews.add(new Review(usuarioNuevo, comentario, calificacion))
			calificacionGeneral()
    	} else {
    		throw new UsuarioRepetidoException("Ya cargo un comentario con este usuario")
    	}
	}

	def boolean calculoDeCercania(Point otroPunto) {
		coordenadas.distance(otroPunto) < distanciaCercana
	}

	def disponibilidad() {
		false
	}

	def boolean disponibilidad(LocalDate fecha, LocalTime hora) {
		false
	}

	def disponibilidad(String _nombreServicio, LocalDate fecha, LocalTime hora) {
		false
	}

	def void actualizar(String nombre, String[] listaPalabras) {
	}

	def boolean sos(String _nombre) {
		nombre == _nombre && activo
	}

	def bajaLogica() {
		activo = false
	}

	override boolean equals(Object obj) {
		if (obj == null)
			return false

		if (!(obj instanceof POI))
			return false
		val POI poi = obj as POI
		if (nombre == null || nombre.equals(poi.nombre))
			return false
		if (coordenadas == null || coordenadas.equals(poi.coordenadas))
			return false
		Double.compare(distanciaCercana, poi.distanciaCercana) == 0
	}

	override int hashCode() {
		var int hash = 3
		hash = 59 * hash + Objects.hashCode(this.nombre)
		hash = 59 * hash + Objects.hashCode(this.coordenadas)
		hash = 59 * hash + Objects.hashCode(this.distanciaCercana)

		hash
	}
}
