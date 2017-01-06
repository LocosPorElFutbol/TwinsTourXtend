package procesos

import dominio.Terminal
import observer.BusquedaPorFechaObserver
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestAgregarAcciones {
	
	Terminal terminal
	AgregarAcciones procesoAgregar
	
	@Before
	def void setUp() {
		terminal = new Terminal()
		procesoAgregar = new AgregarAcciones()
	}
	
	@Test
	def void testAgregarAccion() {
		val busqueda = new BusquedaPorFechaObserver
		procesoAgregar.agregarAccion(busqueda)
		Assert.assertFalse(terminal.acciones.contains(busqueda))
		procesoAgregar.ejecutar()
		Assert.assertTrue(terminal.acciones.contains(busqueda))
	}
	
	@Test
	def void testUndo() {
		val busqueda = new BusquedaPorFechaObserver
		procesoAgregar.agregarAccion(busqueda)
		procesoAgregar.ejecutar()
		Assert.assertTrue(terminal.acciones.contains(busqueda))
		procesoAgregar.undo()
		Assert.assertFalse(terminal.acciones.contains(busqueda))
	}
	
	@Test
	def void testAgregoYSacoLaMismaAccion() {
		val BusquedaPorFechaObserver busqueda = new BusquedaPorFechaObserver()
		procesoAgregar.agregarAccion(busqueda)
		procesoAgregar.sacarAccion(busqueda)
		procesoAgregar.ejecutar()
		Assert.assertEquals(0, terminal.acciones.size)
	}
	
}