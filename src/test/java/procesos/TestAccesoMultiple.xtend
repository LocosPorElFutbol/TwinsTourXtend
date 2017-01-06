package procesos

import dominio.Administrador
import org.junit.Before
import org.junit.Test
import org.junit.After
import dominio.Directorio
import exepciones.ErrorAlEjecutarException
import org.junit.Assert

class TestAccesoMultiple {
	Administrador admin
	ConsolaDeProcesos consola
	
	@Before
	def void setUp() {
		consola = new ConsolaDeProcesos
		admin = new Administrador("asd@ddsutn.com", consola)
	
	}

    @Test(expected=ErrorAlEjecutarException)
    def void testSeQuiereEjecutarUnProcesoMultipleCuandoNoSeLeAsignoNingunProcesoParaEjecutar(){
    	new AccesoMultiple().ejecutar()
    }

	@Test
	def void testSeAgregaElProcesoDeEjecutarUnaActualizacionDeLocalesSimpleYDentroDelAccesoMultiple() {
		val accesoMultiple = new AccesoMultiple()
		accesoMultiple.agregarProceso(new ActualizarLocales("C:\\actualizaciones1.txt"))
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.agregarProcesoAListaDeEjecucion(accesoMultiple)
		admin.ejecutarTodosLosProcesosPendientes
		Assert.assertEquals(2, consola.resultados.size)
	}
    
	@Test(expected=ErrorAlEjecutarException)
	def void testAccesoMultipleDondeUnoFalla() {
		new AccesoMultiple() => [
			agregarProceso(new ActualizarLocales("C:\\actualizaciones.txt"))
			agregarProceso(new ActualizarLocales("T:\\jiufactualizaciones1.txt"))
			agregarProceso(new ActualizarLocales("C:\\actualizaciones.txt"))
			ejecutar			
		]
	}
	
	@After
	def void limpiarRepo() {
		Directorio.instancia.limpiar
	}
}
