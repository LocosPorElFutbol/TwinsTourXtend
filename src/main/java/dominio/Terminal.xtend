package dominio

import java.util.List
import java.util.Set
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.Transient
import observer.Observer
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
@DiscriminatorValue("5")
class Terminal extends POI {

//	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	List<Observer> acciones

	new() {
//		acciones = new ArrayList<Observer>
//		Directorio.getInstancia().agregarTerminal(this)
	}

	def agregarAcciones(List<Observer> _acciones) {
		acciones.addAll(_acciones)
		var Set<Observer> accionesSinRepetidos = acciones.toSet
		acciones = accionesSinRepetidos.toList
	}

	def getAcciones() {
		return this.acciones
	}

	def sacarAcciones(List<Observer> _acciones) {
		_acciones.forEach[accion|acciones.remove(accion)] // hacer que tire excepcion cuando no esta la accion
	}

}
