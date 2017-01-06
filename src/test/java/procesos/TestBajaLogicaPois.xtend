package procesos

import juegoDeDatosParaTest.AlmacenDeDatos
import org.junit.Before
import dominio.Directorio
import org.junit.Test
import org.junit.After
import java.util.ArrayList
import org.joda.time.LocalDate
import org.junit.Assert
import dominio.POI

class TestBajaLogicaPois {
	AlmacenDeDatos datos
	ArrayList<ResultadoRestBaja> lista = new ArrayList<ResultadoRestBaja>()
	ArrayList<POI> listaPoi = new ArrayList<POI>()

	@Before
	def void setUp() {
		datos = new AlmacenDeDatos
		listaPoi.add(datos.parada114)
		listaPoi.add(datos.kioskoDoñaFlorinda)
		listaPoi.add(datos.libreriaEscolarElCuadernitoDeTito)
		listaPoi.add(datos.carrousel)

		lista.add(new ResultadoRestBaja("114", LocalDate.now))
	}

	@Test
	def TestBajLogicaDeUnPoi() {
		var BajaPois bajaPois = new BajaPois(listaPoi);
		bajaPois.resultadoRestBaja = lista;

		bajaPois.ejecutar()

		var listaActualizada = listaPoi.filter[p|p.isActivo == true].toList
		Assert.assertEquals(listaActualizada.size, 3)
	}

	@After
	def void limpiarRepo() {
		Directorio.instancia.limpiar
	}
}
