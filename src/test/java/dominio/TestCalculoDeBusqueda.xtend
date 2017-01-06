package dominio

import java.util.List
import juegoDeDatosParaTest.AlmacenDeDatos
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.After

class TestCalculoDeBusqueda {
	
	Directorio directorio
	String texto
	List <POI> listaBusqueda 
	AlmacenDeDatos datos
	
	@Before
	def void setUp() {
		datos = new AlmacenDeDatos

		directorio = Directorio.getInstancia 
		directorio.create(datos.parada114)
		directorio.create(datos.kioskoDoñaFlorinda)
		directorio.create(datos.cgp)
		directorio.create(datos.sucursalBancoNacion)
	}
   @Test
	def void busquedaDeUnaParadaDeColectivo() {
		texto = "114"
		Assert.assertNotNull(directorio.buscar(texto))
		}
		
   @Test
	def void busquedaQueFalle() {
		listaBusqueda = directorio.buscar("ncion")
		Assert.assertEquals(listaBusqueda.size, 0)
		}
		
	@Test
	def void busquedaQueFalle2() {
		listaBusqueda = directorio.buscar("111")
		Assert.assertEquals(listaBusqueda.size, 0)
		}
		
    @Test
	def void busquedaDeUnComercio() {
		texto = "kiosco"
		Assert.assertNotNull(directorio.buscar(texto))
		}
		
	@Test
	def void busquedaDeUnServicio() {
		texto = "rentas"
		Assert.assertNotNull(directorio.buscar(texto))
		}
		
	@Test
	def void busquedaDeUnaPalabraClave() {
		texto = "asesoramiento"
		Assert.assertEquals(1, directorio.buscar(texto).size)
		}
		
	@Test
 	def void preguntoAParadaDeColectivoSiEsDe114YEstaBien() {
 		texto = "114"
 		Assert.assertTrue(datos.parada114.sos(texto))
 	}
 	
 	@Test
 	def void preguntoAParadaDeColectivoSiEsDe115YFalla() {
 		texto = "115"
 		Assert.assertFalse(datos.parada114.sos(texto))
 	}
 	
  	@Test
 	def void lePreguntoAUnBancoSiEsYEstaBien() {
 		texto = "nacion"
 		Assert.assertTrue(datos.sucursalBancoNacion.sos(texto))
 	}
 	
 	@Test
 	def void lePreguntoAUnBancoSiEsYFalla() {
 		texto = "banco nacional"
 		Assert.assertFalse(datos.sucursalBancoNacion.sos(texto))
 	}
 	
 	@Test
 	def void lePreguntoAUnCGPSiTieneUnServicioYEstaBien() {
 		texto = "rentas"
 		Assert.assertTrue(datos.cgp.contieneServicio(texto))
 	}
 	
 	@Test
 	def void lePreguntoAUnCGPSiTieneUnServicioYFalla() {
 		texto = "servicio de rentas"
 		Assert.assertFalse(datos.cgp.contieneServicio(texto))
  	}
  	
  	@Test
  	def void prueboQueUnRubroEsEseYEstaBien(){
  		var Rubro rubro = new Rubro("rubro", 0.5)
  		Assert.assertTrue(rubro.es("rubro"))
  	}
  	
  	@Test
  	def void prueboQueUnRubroEsEseYFalla(){
  		var Rubro rubro = new Rubro("rubro", 0.5)
  		Assert.assertFalse(rubro.es("ru-bro"))
  	}
  	
  	@After
	def void limpiarRepo() {
		Directorio.getInstancia.limpiar
	}
}
