package procesos

import dominio.Directorio
import exepciones.ErrorAlEjecutarException
import juegoDeDatosParaTest.AlmacenDeDatos
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestActualizacionComercios {
	AlmacenDeDatos datos

	@Before
	def void setUp() {
		datos = new AlmacenDeDatos
		Directorio.instancia => [
			create(datos.parada114)
			create(datos.kioskoDoñaFlorinda)
			create(datos.libreriaEscolarElCuadernitoDeTito)
			create(datos.carrousel)
		]
	}

	@Test
	def TestDeActualizacionDePalabrasClave() {
		val actualizacion = new ActualizarLocales("actualizacion.txt")
		actualizacion.ejecutar
		Assert.assertEquals(datos.kioskoDoñaFlorinda.palabrasClave.size, 1)
		Assert.assertEquals(datos.libreriaEscolarElCuadernitoDeTito.palabrasClave.size, 0)
		Assert.assertEquals(datos.carrousel.palabrasClave.size, 4)
		Assert.assertTrue(datos.carrousel.palabrasClave.contains("modas"))
		Assert.assertFalse(datos.carrousel.palabrasClave.contains("blazers"))
	}

	@Test(expected=ErrorAlEjecutarException)
	def TestFallaEnLaActualizacion() {
		val actualizacion = new ActualizarLocales("C:\\actualizaciones.txt")
		actualizacion.ejecutar
	}
	
	@After
	def void limpiarRepo() {
		Directorio.instancia.limpiar
	}
}
