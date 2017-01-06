package datosExternosBancos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import dominio.SucursalBanco
import com.google.gson.JsonParser
import com.google.gson.JsonObject
import com.google.gson.JsonArray
import com.google.gson.JsonElement
import org.uqbar.geodds.Point
import java.util.ArrayList
import dominio.DatosExternos
import dominio.POI

@Accessors
class BancoAdapter implements DatosExternos{
	StubBanco stub = new StubBanco
	List<SucursalBanco> sucursalBancoList = new ArrayList<SucursalBanco>
				
	override List<POI> buscar(String nombre) {
		var String jsonResultado = stub.buscarBanco(nombre)	
		transformarBusquedaABanco(jsonResultado)
	} 
		
	def List<POI> transformarBusquedaABanco(String jsonResultante) {
		var JsonParser parser = new JsonParser
		var JsonArray obj = parser.parse(jsonResultante).asJsonArray
		obj.forEach[json | obtenerBancoDesdeJSON(json)]
		new ArrayList<POI>(sucursalBancoList)
	}
	
	def obtenerBancoDesdeJSON(JsonElement jsonElement) {
		var JsonObject objeto = jsonElement.asJsonObject
		var Point coordenada = new Point(objeto.get("x").asDouble, objeto.get("y").asDouble)
		sucursalBancoList.add(new SucursalBanco(objeto.get("banco").asString, objeto.get("direccion").asString, coordenada, null/*objeto.get("barrio").asString*/, null, null))  //decia sucursal, es banco
	}
}
