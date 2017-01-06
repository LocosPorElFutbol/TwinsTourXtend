package procesos

import dominio.Administrador
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import politicasDeManejoDeError.ReintentarEjecucion
import politicasDeManejoDeError.NotificarDeErrorEnEjecucion
import mocks.MailSenderMock

class TestEjecucionDeProcesos {
	ConsolaDeProcesos consola
	Administrador admin
	
	@Before
	def void setUp() {
		consola = new ConsolaDeProcesos
		admin = new Administrador("asd@ddsutn.com", consola)
	}
	
	@Test
	def void administradorPuedeAgregarProcesos(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizacion.txt"))
		Assert.assertEquals(1, consola.procesosAEjecutar.size)
	}
	
	@Test
	def void consolaSacaLosProcesosAlEjecutar(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizacion.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(0, consola.procesosAEjecutar.size)
	}
	
	@Test
	def void consolaAlmacenaLosResultadosOKDeEjecucion(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizacion.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(1, consola.resultados.size)
	}
	
	@Test
	def void consolaAlmacenaLosResultadosErrorDeEjecucion(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(1, consola.resultados.size)
	}
	
	@Test
	def void consolaAlmacenaLosResultadosOkyErrorDeEjecucion(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(2, consola.resultados.size)
	}
	
	@Test
	def void resultadoDeEjecucionAlmacenaEstadoError(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals("error", consola.resultados.get(0).resultado)
	}
	
	@Test
	def void resultadoDeEjecucionAlmacenaEstadoOK(){
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizacion.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals("ok", consola.resultados.get(0).resultado)
	}
	
	@Test
	def void NoHacerNadaNoVuelveAEjecutarAlProceso() {
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(1, consola.resultados.get(0).intentosDeEjecucion)
	}
	
	@Test
	def void ReintentarEjecucionReintentaHastaLlegarA0() {
		consola.manejoDeError = new ReintentarEjecucion(5, consola)
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(6, consola.resultados.get(0).intentosDeEjecucion)
	}
	
	@Test
	def void PoliticaDeNotificarErrorGuardaCorrectamenteResultadosEnConsola() {
		consola.manejoDeError = new NotificarDeErrorEnEjecucion(consola, new MailSenderMock)
		admin.agregarProcesoAListaDeEjecucion(new ActualizarLocales("C:\\actualizaciones.txt"))
		admin.ejecutarTodosLosProcesosPendientes
		
		Assert.assertEquals(1, consola.resultados.size)
	}	
}