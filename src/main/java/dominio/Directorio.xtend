package dominio

import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import juegoDeDatosParaTest.AlmacenDeDatos
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import repositorio.RepoPois

@Accessors
class Directorio {
	private static Directorio instancia = null
	public static RepoPois repoPois = new RepoPois
	private Set<Polygon> comunas = new HashSet<Polygon>
	List<DatosExternos> datosExternos = new ArrayList<DatosExternos>
	List<Terminal> terminales = new ArrayList<Terminal>
	List<Review> reviews = new ArrayList<Review>
	//List<String> usuariosFavoritos = new ArrayList<String>
	
	private new(){
	}
	
	def static getInstancia() {
		if(instancia == null) {
			instancia = new Directorio
			
			val datos = new AlmacenDeDatos
			repoPois.create(datos.parada114)
			repoPois.create(datos.parada115)
			repoPois.create(datos.kioskoDoñaFlorinda)
			repoPois.create(datos.libreriaEscolarElCuadernitoDeTito)
			repoPois.create(datos.cgp)
			repoPois.create(datos.sucursalBancoNacion)
			repoPois.create(datos.carrousel)
		}
		return instancia
	}
		
	def buscar(String nombre) {
		repoPois.searchByExample(nombre)
	}
	
	def void agregarComuna(Polygon unaComuna){
		comunas.add(unaComuna)
	}
	
	def miComuna(Point coordenada){
		comunas.findFirst[ comuna | comuna.isInside(coordenada)]
	}
	
	def void limpiar(){
		comunas.clear
//		this.getObjects.clear
		datosExternos.clear		
	}
	
	def void agregarOrigenDeDatos(DatosExternos origenDeDatos){
		datosExternos.add(origenDeDatos)
	}
	
	def POI searchById(int id){
		repoPois.searchByExample(id).head
	}
	
	def List<POI> allInstances(){
		repoPois.allInstances()
	}
	
	def void create(POI poi) {
		repoPois.create(poi)
	}
	
	def void update(POI poi) {
		repoPois.update(poi)
	}
	
//	def void actualizarPOIs(String palabra) {
//		datosExternos.forEach[ origenDeDatos | 
//			this.objects.addAll(new HashSet(origenDeDatos.buscar(palabra)))
//			]
//		
//		var Set<POI> listaSinRepetidos = this.objects.toSet
//		this.objects = listaSinRepetidos.toList
//	}
	
	def actualizarComercios(String nombre, String[] palabrasClave) {
		repoPois.allInstances.forEach[ unPOI | unPOI.actualizar(nombre, palabrasClave) ]
	}
	
	def agregarTerminal(Terminal terminal) {
		repoPois.create(terminal)
		//this.terminales.add(terminal)
	}
	
	
}
