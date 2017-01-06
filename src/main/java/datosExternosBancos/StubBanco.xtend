package datosExternosBancos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import com.google.gson.Gson

@Accessors
class StubBanco {
	String banco
	double x
	double y
	String sucursal
	String gerente
	List<String> servicios
	
	List<StubBanco> listaATransformar = new ArrayList<StubBanco>

	def String buscarBanco(String nombreBanco) {
		var lista = listaATransformar.filter[banco | banco.banco.equalsIgnoreCase(nombreBanco)].toList
		transformarAJson(lista)
	}
	
	def String transformarAJson(List<StubBanco> lista) {
		return new Gson().toJson(lista)
	}
	
}