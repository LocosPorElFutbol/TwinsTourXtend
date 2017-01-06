package juegoDeDatosParaTest

import dominio.Cgp
import dominio.Comercio
import dominio.Directorio
import dominio.ParadaDeColectivo
import dominio.SucursalBanco
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AlmacenDeDatos {
	Comercio kioskoDoñaFlorinda
	Comercio libreriaEscolarElCuadernitoDeTito
	Comercio carrousel
	SucursalBanco sucursalBancoNacion
	Cgp cgp	
	ParadaDeColectivo parada114
	ParadaDeColectivo parada115
		
	
	new(){		
	    var BuilderPois builder = new BuilderPois
	    
	    builder.setNombre("Parada del 114")
	    builder.setDireccion("Mozart 2300")
		builder.coordenada(1,1)
		builder.setCantidadParadas(45)
		parada114 = builder.construirParadaDeColectivo
		
		builder = new BuilderPois
		builder.setNombre("Banco Nacion")
		builder.setDireccion("Avenida Corrientes 1235")
		builder.setBarrio("Almagro")
		builder.servicio("cobro de impuestos")
		builder.servicio("pagos")
		sucursalBancoNacion = builder.construirSucursalBanco
		
		builder = new BuilderPois
		builder.setNombre("Parada del 115")
		builder.setDireccion("avenida cordoba 400")
		builder.coordenada(1,2)
		builder.setCantidadParadas(20)
		parada115 = builder.construirParadaDeColectivo
		
	    builder = new BuilderPois
	    builder.setNombre("Donia Florinda")
	    builder.setDireccion("Chacabuco 328")
	    builder.horarioAtencion(10,13)
		builder.rubro("kiosko", 0.2)
		builder.coordenada(2,2)
		kioskoDoñaFlorinda = builder.construirComercio
		
		builder = new BuilderPois
		builder.setNombre("El cuadernito de Tito")
		builder.setDireccion("Avenida de Mayo 601")
		builder.rubro("libreria", 0.5)
		builder.palabrasClave.add("libreria")
		builder.palabrasClave.add("comercial")
		libreriaEscolarElCuadernitoDeTito = builder.construirComercio
		
		Directorio.getInstancia.agregarComuna(builder.comuna5x5)	
		builder = new BuilderPois
		builder.setNombre("CGP Caballito")
		builder.setDireccion("Diaz Velez 468")
		builder.coordenada(3,2)
		builder.servicio("rentas")
		builder.servicio("asesoramiento legal")
		builder.servicio("sesoramiento ilegal")
		builder.setNumeroDeComuna(5)
		cgp = builder.construirCgp	
			
	   	builder = new BuilderPois
	   	builder.setNombre("Carrousel")
	   	builder.setDireccion("Belgrano 7889")
	   	builder.horarioAtencion(17,20)
	   	builder.rubro("escolares", 0.2)
	   	builder.coordenada(2,3)
	   	builder.palabrasClave.add("colegio")
	   	builder.palabrasClave.add("uniformes")
	   	builder.palabrasClave.add("blazers")
	   	carrousel = builder.construirComercio	
	}	
}
