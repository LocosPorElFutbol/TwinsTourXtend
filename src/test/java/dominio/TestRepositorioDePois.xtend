package dominio

import juegoDeDatosParaTest.AlmacenDeDatos
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

//import java.util.Set

class TestRepositorioDePois {
	
	Directorio repo = Directorio.getInstancia
	AlmacenDeDatos datos
	
	@Before
	def void setUp(){
		datos = new AlmacenDeDatos
		
		repo.create(datos.parada114)
		repo.create(datos.kioskoDoñaFlorinda)
		repo.create(datos.cgp)
		repo.create(datos.sucursalBancoNacion)
//		repo.delete(datos.cgp)
	}
	
	@Test
	def void testPrueboQuePOISeCreoConUnId(){
		Assert.assertNotNull(datos.kioskoDoñaFlorinda.id)
	}
	
	@Test(expected=RuntimeException)
	def void testCuandoEliminoUnPoiYLoBuscoMeLanzaUnaExcepcion(){
		Assert.assertNull(repo.searchById(-2))
	}
	
	@Test
	def void directorioSeCargaCorrectamente(){
		Assert.assertEquals(4, repo.allInstances.size) // Espera 4 elementos porque el delete no lo saca del repo
		repo.create(datos.carrousel)
		Assert.assertEquals(5, repo.allInstances.size)
	}
	
	@Test
	def void directorioSeLimpiaCorrectamente(){
		repo.limpiar
		Assert.assertEquals(0, repo.allInstances.size)
	}
	
//	@Test
//	def void testBuscoPOIPorId(){
//		var POI poiResultado = repo.searchById(datos.sucursalBancoNacion.id)
//		Assert.assertTrue(poiResultado.equals(datos.sucursalBancoNacion))
//	}
	
	@Test
	def void testModificoUnPoi(){
		Assert.assertEquals("114", datos.parada114.nombre)
		datos.parada114.nombre = "p114"
		repo.update(datos.parada114)
		Assert.assertEquals("p114", datos.parada114.nombre)
	}
	
//	@Test
//	def void TestNoSeAgreganRepetidos() {
//		var List<POI> lista = new ArrayList<POI>
//		var List<Servicio> servicio = new ArrayList<Servicio>
//		var List<Horarios> horario = new ArrayList<Horarios>
//		horario.add(new Horarios(new LocalTime(10,0,0,0), new LocalTime(13,0,0,0), #[1]))
//		servicio.add(new Servicio("wololo", horario))
//		var Cgp cgp = new Cgp(new Point(1,1), servicio)
//		lista.add(cgp)
//		lista.add(cgp)
//		
//		Assert.assertEquals(2, lista.size)
//	}
	
//	@Test
//	def void wololo2() {
//		var List<POI> l = new ArrayList<POI>
//		var List<Servicio> s= new ArrayList<Servicio>
//		var List<Horarios> h = new ArrayList<Horarios>
//		h.add(new Horarios(new LocalTime(10,0,0,0), new LocalTime(13,0,0,0), #[1]))
//		s.add(new Servicio("wololo", h))
//		var Cgp cgp = new Cgp(new Point(1,1), s)
//		var Set<POI> l2 = l.toSet
//		l2.add(cgp)
//		l2.add(cgp)
//		
//		l = l2.toList
//		
//		
//		Assert.assertEquals(1, l.size)
//	}
	
	@After
	def void limpiarRepo() {
		Directorio.getInstancia.limpiar
	}
}
