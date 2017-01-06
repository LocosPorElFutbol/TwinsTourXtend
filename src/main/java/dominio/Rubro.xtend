package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Rubro {
	String nombre
	Double radioDeCercania
	
	new(String _nombre, Double _radioDeCercania) {
		nombre = _nombre
		radioDeCercania = _radioDeCercania
	}
	
	def es(String unNombre) {
		return nombre.equals(unNombre)
	}
	
}
