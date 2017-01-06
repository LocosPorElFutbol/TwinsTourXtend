package observer

import dominio.Directorio
import dominio.Terminal
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import org.joda.time.LocalTime
import org.joda.time.Seconds

@Accessors
class Buscador {

	Directorio directorio

	def void buscador(String texto, Terminal _terminal) {
		var LocalTime comenzarProceso = new LocalTime
		var listaSalida = directorio.buscar(texto)
		var LocalTime finalizarProceso = new LocalTime

		var DatosParaObserver datosParaObserver = new DatosParaObserver
		datosParaObserver.tiempoDemoraBusqueda = Seconds.secondsBetween(comenzarProceso, finalizarProceso).getSeconds()
		datosParaObserver.fechaBusqueda = new LocalDate
		datosParaObserver.cantidadBusquedas = listaSalida.size
		datosParaObserver.fraseBuscada = texto
		datosParaObserver.terminal = _terminal
		notificarObserver(datosParaObserver)
	}

	def notificarObserver(DatosParaObserver _datosParaObserver) {
		_datosParaObserver.terminal.acciones.forEach [observer|
			observer.notificar(
				new DatosParaObserver(
					_datosParaObserver.terminal,
					_datosParaObserver.fraseBuscada,
					_datosParaObserver.cantidadBusquedas,
					_datosParaObserver.tiempoDemoraBusqueda,
					_datosParaObserver.fechaBusqueda
				)
			)
		]
	}
}
