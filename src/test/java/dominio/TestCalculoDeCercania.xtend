package dominio

import juegoDeDatosParaTest.AlmacenDeDatos
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class TestCalculoDeCercania {
	Point miCoordenadaActual
	AlmacenDeDatos datos
//	Directorio directorio
	
	@Before
	def void setUp() {
		datos = new AlmacenDeDatos
	}
	
	@Test
	def void estoyCercaDeUnaParadaDeColectivo() {
		miCoordenadaActual = new Point(1,1.0005)
		Assert.assertTrue(datos.parada114.calculoDeCercania(miCoordenadaActual))
	}
	
	@Test
	def void estoyLejosDeUnaParadaDeColectivo() {
		miCoordenadaActual = new Point(1,1.9)
		Assert.assertFalse(datos.parada114.calculoDeCercania(miCoordenadaActual))
	}
	
	@Test
	def void estoyCercaDeUnBanco(){
		miCoordenadaActual = new Point(1,1.004)
		Assert.assertTrue(datos.sucursalBancoNacion.calculoDeCercania(miCoordenadaActual))
	} 
	
	@Test
    def void estoyLejosDeUnBanco(){
		miCoordenadaActual = new Point(1,1.006)
		Assert.assertFalse(datos.sucursalBancoNacion.calculoDeCercania(miCoordenadaActual))
	}

	@Test
    def void estoyCercaDeUnKiosco(){
		miCoordenadaActual = new Point(2,2.001)
		Assert.assertTrue(datos.kioskoDoñaFlorinda.calculoDeCercania(miCoordenadaActual))
	} 

	@Test
    def void estoyLejosDeUnKiosco(){
		miCoordenadaActual = new Point(2,2.003)
		Assert.assertFalse(datos.kioskoDoñaFlorinda.calculoDeCercania(miCoordenadaActual))
	} 

	@Test
    def void estoyCercaDeUnaLibreria(){
		miCoordenadaActual = new Point(2,2.003)
		Assert.assertTrue(datos.libreriaEscolarElCuadernitoDeTito.calculoDeCercania(miCoordenadaActual))
	} 
	
	@Test
    def void estoyLejosDeUnaLibreria(){
		miCoordenadaActual = new Point(2,2.007)
		Assert.assertFalse(datos.libreriaEscolarElCuadernitoDeTito.calculoDeCercania(miCoordenadaActual))
	} 
	
	@Test
    def void estoyCercaDeUnCgp(){
		miCoordenadaActual = new Point(2,2)
		// El cgp realiza el calculo de cercania, con la coordenada enviada.
		// Que delega en comuna.Inside (y esto tira error), tener en cuenta que,
		// en almacen de datos se agrega la comuna al directorio.
		
		// El metodo isInside no toma los puntos del perimetro como elementos internos
		Assert.assertTrue(datos.cgp.calculoDeCercania(miCoordenadaActual))		
	} 
	
	@Test
	def void estoyLejosDeUnCgp(){
		//Error Idem punto anterior.
		miCoordenadaActual = new Point(6,4)
		Assert.assertFalse(datos.cgp.calculoDeCercania(miCoordenadaActual))
	} 
	
}
