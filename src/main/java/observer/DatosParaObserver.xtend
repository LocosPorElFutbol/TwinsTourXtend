package observer

import dominio.Terminal
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class DatosParaObserver {
	Terminal terminal
	String fraseBuscada
	int cantidadBusquedas
	int tiempoDemoraBusqueda
	LocalDate fechaBusqueda
	
	new(){}
	
	new(Terminal _terminal, String _fraseBuscada,int _cantidadBusquedas,
		int _tiempoDemoraBusqueda, LocalDate _fechaBusqueda){
			 terminal= _terminal
	         fraseBuscada = _fraseBuscada
	         cantidadBusquedas = _cantidadBusquedas
	         tiempoDemoraBusqueda = _tiempoDemoraBusqueda
	         fechaBusqueda = _fechaBusqueda
		}



}