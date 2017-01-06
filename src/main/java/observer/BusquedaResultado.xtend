package observer

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedaResultado {
	String fraseBuscada
	int cantidadDeResultados
	int tiempo
	
	new(String _fraseBuscada, int _cantidadDeResultados, int _tiempo){
		fraseBuscada = _fraseBuscada
		cantidadDeResultados = _cantidadDeResultados
		tiempo = _tiempo
	}
}