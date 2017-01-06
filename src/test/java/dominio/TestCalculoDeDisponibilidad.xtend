package dominio

import juegoDeDatosParaTest.AlmacenDeDatos
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.joda.time.LocalTime
import org.joda.time.LocalDate

class TestCalculoDeDisponibilidad {
	
	AlmacenDeDatos datos
    LocalDate FECHA_DOMINGO = new LocalDate(2016, 4, 10) //(año,mes,dia)
    LocalDate FECHA_LUNES = new LocalDate(2016, 4, 4)
    LocalTime HORA_11_30_AM = new LocalTime(11, 30, 0, 0)
    LocalTime HORA_22_15_PM = new LocalTime(22, 15, 0, 0)
    LocalDate fechaDeConsulta
    LocalTime horaDeConsulta
    String servicio
	
	@Before
	def void setUp() {
		datos = new AlmacenDeDatos
	}
	
	@Test
	def void estaDisponibleUnaParadaDeColectivo(){
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_DOMINGO
		Assert.assertTrue(datos.parada114.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void estaDisponibleUnaParadaDeColectivo2(){
		horaDeConsulta = HORA_22_15_PM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertTrue(datos.parada114.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void estaDisponibleUnBanco(){
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertTrue(datos.sucursalBancoNacion.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void noEstaDisponibleUnBancoPorHora(){
		horaDeConsulta = HORA_22_15_PM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertFalse(datos.sucursalBancoNacion.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void noEstaDisponibleUnBancoPorDia(){
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_DOMINGO
		Assert.assertFalse(datos.sucursalBancoNacion.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void estaDisponibleUnComercio(){
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertTrue(datos.carrousel.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void noEstaDisponibleUnComercioporDia(){
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_DOMINGO
		Assert.assertFalse(datos.carrousel.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void noEstaDisponibleUnComercioporHora(){
		horaDeConsulta = HORA_22_15_PM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertFalse(datos.carrousel.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test 
	def void estaDisponibleUnCgp(){
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertTrue(datos.cgp.disponibilidad(fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void estaDisponibleUnCgpConRentas(){
		servicio = "rentas"
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertTrue(datos.cgp.disponibilidad(servicio, fechaDeConsulta, horaDeConsulta))
	}
	@Test 
	def void noEstaDisponibleUnCgpConRentasPorHora(){
		servicio = "rentas"
		horaDeConsulta = HORA_22_15_PM
        fechaDeConsulta = FECHA_LUNES
		Assert.assertFalse(datos.cgp.disponibilidad(servicio, fechaDeConsulta, horaDeConsulta))
	}
	@Test
	def void noEstaDisponibleUnCgpConRentasPorDia(){
		servicio = "rentas"
		horaDeConsulta = HORA_11_30_AM
        fechaDeConsulta = FECHA_DOMINGO
		Assert.assertFalse(datos.cgp.disponibilidad(servicio, fechaDeConsulta, horaDeConsulta))
	}
	
}
