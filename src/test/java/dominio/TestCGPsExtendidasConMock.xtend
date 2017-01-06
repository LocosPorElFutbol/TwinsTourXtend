package dominio

import datosExternosCGPs.BaseDeDatosCGPs
import datosExternosCGPs.CentroDTO
import datosExternosCGPs.DatosExternosCGPs
import datosExternosCGPs.RangoServicioDTO
import datosExternosCGPs.ServicioDTO
import java.util.ArrayList
import java.util.List
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.mockito.Mockito

class TestCGPsExtendidasConMock {
	
	BaseDeDatosCGPs baseDeDatosExternosMock
	String texto
	List<CentroDTO> listaDeDTO
	CentroDTO cgpExterno
	ServicioDTO servicioExterno
	RangoServicioDTO horarioExterno
	DatosExternosCGPs datosExternos
	
	@Before
	def void setUp() {
		cgpExterno = new CentroDTO
		servicioExterno = new ServicioDTO 
		horarioExterno = new RangoServicioDTO 
		datosExternos = new DatosExternosCGPs
		
		inicializarRangoHorario(horarioExterno)
		inicializarServicioExterno(servicioExterno, horarioExterno)
		inicializarCentro(cgpExterno, servicioExterno)
		
		texto = "banco"
		listaDeDTO = new ArrayList<CentroDTO>
		listaDeDTO.add(cgpExterno)
		baseDeDatosExternosMock = Mockito.mock(typeof(BaseDeDatosCGPs))
		
		Mockito.when(baseDeDatosExternosMock.buscar(texto)).thenReturn(listaDeDTO)
		
		datosExternos.datosExternos = baseDeDatosExternosMock
	}
	
	
	def inicializarRangoHorario(RangoServicioDTO dto) {
		dto.numeroDia = 3
		dto.horarioDesde = 9
		dto.minutoDesde = 00
		dto.horarioHasta = 18
		dto.minutoHasta = 00
	}
	
	def inicializarServicioExterno(ServicioDTO dto, RangoServicioDTO rDto) {
		var List<RangoServicioDTO> horarios = new ArrayList<RangoServicioDTO>
		horarios.add(rDto)
		
		dto.nombreDelServicio = "servicio externo"
		dto.rangosServicioDTO = horarios
	}
	def inicializarCentro(CentroDTO dto, ServicioDTO servicio) {
		var List<ServicioDTO> servicios = new ArrayList<ServicioDTO>
		servicios.add(servicio)
		
		dto.x = 1.2
		dto.y = 1.3
		dto.numeroDeComuna = 4
		dto.barriosQueIncluye = "caba"
		dto.nombreDelDirector = "Jorge"
		dto.domicilioCompleto = "calle viva 123"
		dto.telefono = "40000000"
		dto.serviciosDTO = servicios
	}
	
	@Test
	def void testBuscarCentroDTODevuelveListaConCentroDTO() {
		val String texto = "banco"
		val List<CentroDTO> listaFinal = baseDeDatosExternosMock.buscar(texto)
		
		Assert.assertEquals(listaFinal.get(0).class, CentroDTO)
	}
	
	@Test
	def void testTransformoResultadoDeBusquedaCentroDTOenListaDePOIs() {
		texto = "banco"
		val List<POI> cgp = datosExternos.transformarBusquedaAPOIs(baseDeDatosExternosMock.buscar(texto))
		Assert.assertEquals(cgp.get(0).class, Cgp)
	}
	
	@Test
	def void testTransformoCentroDTOenPOI() {
		texto = "banco"
		val POI cgp = datosExternos.transformar(baseDeDatosExternosMock.buscar(texto).get(0))
		Assert.assertTrue(cgp.sos("servicio externo")) 
	}
	
	@Test
	def void testTransformoServicioDTOenServicio() {
		texto = "banco"
		val Servicio servicio = datosExternos.transformarServicio(servicioExterno)
		Assert.assertTrue(servicio.nombreServicio.equals("servicio externo"))
	}
	
	@Test
	def void testTransformoRangoHorarioDTOenHorarios() {
		texto = "banco"
		val Horarios horario = datosExternos.transformarHorario(horarioExterno)
		Assert.assertTrue(horario.listaDias.contains(3))
	}
	
//	@Test
//	def void testDirectorioActualizaListaDePois() {
//		texto = "banco"
//		Directorio.instancia.agregarOrigenDeDatos(datosExternos)
//		Assert.assertEquals(0, Directorio.instancia.allInstances.size)
//		Directorio.instancia.actualizarPOIs(texto)
//		Assert.assertEquals(1, Directorio.instancia.allInstances.size)
//	}
//	
//	@Test
//	def void testDirectorioActualizaListaDePoisSinRepetidos() {
//		texto = "banco"
//		val String texto2 = "servicio externo"
//		Directorio.instancia.agregarOrigenDeDatos(datosExternos)
//		Assert.assertEquals(0, Directorio.instancia.allInstances.size)
//		Directorio.instancia.actualizarPOIs(texto)
//		Directorio.instancia.actualizarPOIs(texto2)
//		Assert.assertEquals(1, Directorio.instancia.allInstances.size)
//	}
	
	@After
	def void limpiarRepo() {
		Directorio.instancia.limpiar
	}
}









