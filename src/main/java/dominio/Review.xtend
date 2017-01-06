package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.ManyToOne

@Entity
@Accessors
class Review {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=50)	
	private String usuario
	
	@Column(length=250)
	private String comentario
	
	@Column
	private int calificacion
	
	@ManyToOne
	private POI poi
	
	new(){
		
	}
	
	
	new (String _usuario, String _comentario, int _calificacion){
		usuario = _usuario
		comentario = _comentario
		calificacion = _calificacion
	}
}