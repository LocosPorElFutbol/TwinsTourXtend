package juegoDeDatosParaTest

import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import java.util.Collection
import dominio.Servicio
import org.eclipse.xtend.lib.annotations.Accessors
import dominio.Cgp
import java.util.ArrayList
import java.util.List
import dominio.Horarios
import org.joda.time.LocalTime
import dominio.Rubro
import dominio.Comercio
import dominio.ParadaDeColectivo
import dominio.SucursalBanco
import dominio.Review

@Accessors
class BuilderPois {
	String nombre
	String direccion
	String tipo
	Point coordenada
	Double distanciaCercana
	Collection<Servicio> servicios = new ArrayList<Servicio>
	List<Horarios> horarioAtencion = new ArrayList<Horarios>
	List<String> palabrasClave = new ArrayList<String>
	List<Review> reviews = new ArrayList<Review>
	Rubro rubro
	String barrio
	int numeroDeComuna
	int cantidadParadas
	
	
	def coordenada(double x, double y) {
		coordenada = new Point(x,y)
	}
	
	def horarioAtencion(int horaApertura, int horaCierre){
	   	horarioAtencion.add(new Horarios(new LocalTime(horaApertura, 0, 0, 0), new LocalTime(horaCierre, 0, 0, 0), #[1,2,3,4,5]))
	}
	
	def servicio(String nombre) {
		servicios.add(new Servicio(nombre, horarioAtencion))
	}
	
	def review() {
		reviews.add(new Review("", "", 0))
	}
	

	def comuna5x5(){
		var List<Point> puntosPoligono= new ArrayList<Point>
		puntosPoligono.add(new Point(1,1))
		puntosPoligono.add(new Point(1,5))
		puntosPoligono.add(new Point(5,5))
		puntosPoligono.add(new Point(5,1))
		new Polygon(puntosPoligono)
	}
	
	def construirCgp(){		
		new Cgp(nombre, direccion, tipo, coordenada, servicios, reviews, numeroDeComuna)
	}
	
	def rubro(String nombre, Double radioCercania) {
		rubro = new Rubro(nombre, radioCercania)
	}
	
	def construirComercio() {
		new Comercio(nombre, direccion, coordenada, rubro, horarioAtencion, reviews)
	}
	
	def construirParadaDeColectivo() {
		new ParadaDeColectivo(nombre, direccion, coordenada, reviews, cantidadParadas)
	}
	
	def construirSucursalBanco() {
		new SucursalBanco(nombre, direccion, coordenada, reviews, barrio, servicios)
	}
}