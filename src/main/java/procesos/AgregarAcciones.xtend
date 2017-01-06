package procesos

import dominio.Directorio
import java.util.ArrayList
import java.util.List
import observer.Observer

class AgregarAcciones implements Proceso {
	List<Observer> accionesAgregar
	List<Observer> accionesSacar

	new() {
		accionesAgregar = new ArrayList<Observer>
		accionesSacar = new ArrayList<Observer>
	}
	
	def agregarAccion(Observer accion){
		accionesAgregar.add(accion)
	}
	
	def sacarAccion(Observer accion){
		accionesSacar.add(accion)
	}
	
	override ejecutar() {
		//guardar las terminales
		Directorio.getInstancia().terminales.forEach[ terminal | 
			terminal.agregarAcciones(accionesAgregar)
			terminal.sacarAcciones(accionesSacar)
		]
	}
	
	def undo(){
		Directorio.getInstancia().terminales.forEach[ terminal | 
			terminal.sacarAcciones(accionesAgregar)
			terminal.agregarAcciones(accionesSacar)
		]
	}
	
}
