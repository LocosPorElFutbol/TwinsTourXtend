package dominio

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class Favorito {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=100)
	private String nombre
	
	@ManyToOne
	private Usuario usuario
	
	//@ManyToOne
	//private POI poi 
}