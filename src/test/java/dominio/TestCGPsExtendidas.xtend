package dominio

import datosExternosCGPs.RangoServicioDTO
import org.junit.Test
import org.junit.Before
import datosExternosCGPs.DatosExternosCGPs
import org.junit.Assert
import dominio.Horarios
import org.joda.time.LocalTime
import datosExternosCGPs.ServicioDTO
import java.util.ArrayList
import java.util.List
import datosExternosCGPs.CentroDTO
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point

class TestCGPsExtendidas {
	
	RangoServicioDTO rangoServicio
	DatosExternosCGPs adapterCGPExterna
	Horarios horario
	ServicioDTO servicioDTO
	Servicio servicioPosta
	CentroDTO centroDTO
	Polygon comuna
	Cgp cgp
	
	
	@Before
	def void setUp(){
		adapterCGPExterna = new DatosExternosCGPs
		
		rangoServicio = new RangoServicioDTO
		rangoServicio.setNumeroDia(1)
		rangoServicio.setHorarioDesde(10)
		rangoServicio.setMinutoDesde(0)
		rangoServicio.setHorarioHasta(13)
		rangoServicio.setMinutoHasta(0)
		
		servicioDTO = new ServicioDTO
		servicioDTO.setNombreDelServicio("kioskoMarita")
		var List<RangoServicioDTO> servicios = new ArrayList<RangoServicioDTO>
		servicios.add(rangoServicio)
		servicioDTO.setRangosServicioDTO(servicios)
		
		centroDTO = new CentroDTO
		centroDTO.setX(1)
		centroDTO.setY(1)
		var List<ServicioDTO> serviciosDTO = new ArrayList<ServicioDTO>
		serviciosDTO.add(servicioDTO)
		centroDTO.setServiciosDTO(serviciosDTO)
		
		horario = adapterCGPExterna.transformarHorario(rangoServicio)
		servicioPosta = adapterCGPExterna.transformarServicio(servicioDTO)
		var List<Point> perimetro = new ArrayList<Point>
		perimetro.add(new Point(0,0))
		perimetro.add(new Point(2,0))
		perimetro.add(new Point(0,2))
		perimetro.add(new Point(2,2))
		comuna = new Polygon(perimetro)
		Directorio.getInstancia.agregarComuna(comuna)
		cgp = adapterCGPExterna.transformar(centroDTO) as Cgp
		
	}
	
	@Test
	def void diasRangoServicioEsConvertidoCorrectamenteAHorario(){		
		Assert.assertTrue(horario.getListaDias.contains(1))
	}
	
	@Test
	def void horaDesdeRangoServicioEsConvertidoCorrectamenteAHorario(){		
		Assert.assertEquals(new LocalTime(10,0,0,0), horario.getHoraDesde)
	}
	
	@Test
	def void horaHastaRangoServicioEsConvertidoCorrectamenteAHorario(){		
		Assert.assertEquals(new LocalTime(13,0,0,0), horario.getHoraHasta)
	}
	
	@Test
	def void nombreServicioDTOEsTransformadoCorrectamenteAServicio(){		
		Assert.assertEquals("kioskoMarita", servicioPosta.getNombreServicio())
	}
	
	@Test
	def void rangoHorariosListaDiasServicioDTOEsTransformadoCorrectamenteAServicio(){		
		Assert.assertTrue(servicioPosta.getListaHorarios.get(0).getListaDias.contains(1))
	}
	
	@Test
	def void rangoHorariosHoraDesdeServicioDTOEsTransformadoCorrectamenteAServicio(){		
		Assert.assertEquals(new LocalTime(10,0,0,0), 
							servicioPosta.getListaHorarios.get(0).getHoraDesde
							)
	}
	
	@Test
	def void rangoHorariosHoraHastaServicioDTOEsTransformadoCorrectamenteAServicio(){		
		Assert.assertEquals(new LocalTime(13,0,0,0), 
							servicioPosta.getListaHorarios.get(0).getHoraHasta
							)
	}
	
	@Test
	def void servicioDTOEsTransformadoCorrectamenteAServicioYTiene1Horario(){		
		Assert.assertEquals(1, servicioPosta.getListaHorarios.size)
	}
	
	@Test
	def void centroDTOesTransformadoACGPySacaSuComunaDeDirectorio(){		
		Assert.assertEquals(comuna, 
							cgp.getComuna
							)
	}
	
	@Test
	def void centroDTOesTransformadoACGPYSusServiciosSonCorrectamenteTransformadosNombre(){		
		Assert.assertEquals("kioskoMarita", 
							cgp.getServicios.get(0).getNombreServicio()
							)
	}
	
	@Test
	def void centroDTOesTransformadoACGPYSusServiciosSonCorrectamenteTransformadosHoraDesde(){		
		Assert.assertEquals(new LocalTime(10,0,0,0), 
							cgp.getServicios.get(0).getListaHorarios.get(0).getHoraDesde
							)
	}
	
	@Test
	def void centroDTOesTransformadoACGPYSusServiciosSonCorrectamenteTransformadosHoraHasta(){		
		Assert.assertEquals(new LocalTime(13,0,0,0), 
							cgp.getServicios.get(0).getListaHorarios.get(0).getHoraHasta
							)
	}
	
	@Test
	def void centroDTOesTransformadoACGPYSusServiciosSonCorrectamenteTransformadosRangoHorarios(){		
		Assert.assertTrue(cgp.getServicios.get(0).getListaHorarios.get(0).getListaDias.contains(1))
	}
	
	@Test
	def void centroDTOesTransformadoACGPYTiene1Servicio(){		
		Assert.assertEquals(1, cgp.getServicios.size)
	}
}