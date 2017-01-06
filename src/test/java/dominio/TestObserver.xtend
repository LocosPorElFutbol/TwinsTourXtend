package dominio

import java.util.ArrayList
import java.util.List
import juegoDeDatosParaTest.AlmacenDeDatos
import observer.Buscador
import observer.BusquedaResultadoObserver
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestObserver {
	
	AlmacenDeDatos datos
	Directorio directorio
	Buscador buscador
	BusquedaResultadoObserver busquedaResultadoObserver
	Terminal terminal
	
	@Before
	def void init(){
		
	datos = new AlmacenDeDatos
	busquedaResultadoObserver = new BusquedaResultadoObserver()
	buscador = new Buscador()
	terminal = new Terminal()
	
	directorio=Directorio.getInstancia
	directorio.create(datos.sucursalBancoNacion)
	directorio.create(datos.parada114)
    directorio.create(datos.kioskoDoñaFlorinda)
    directorio.create(datos.cgp)
    directorio.create(datos.carrousel)
    directorio.create(datos.parada115)
    buscador.directorio = directorio
    
    var List<String> mailsAdministradores = new ArrayList<String>
        mailsAdministradores.add("mail1@est.frba.utn.edu.ar")
		mailsAdministradores.add("mail2@est.frba.utn.edu.ar")
		mailsAdministradores.add("mail3@est.frba.utn.edu.ar")
	}
		
	@Test
	def void EjecutarObserverBusquedaResultado(){
		var BusquedaResultadoObserver _busquedaResultadoObserver = new BusquedaResultadoObserver()
		terminal.acciones.addAll(_busquedaResultadoObserver)
		buscador.buscador("parada115", terminal)
		Assert.assertEquals(1, _busquedaResultadoObserver.listaBusquedaResultado.size)		
	}
		
	@After
    def void limpiarRepo() {
       Directorio.getInstancia.limpiar	
    }
}