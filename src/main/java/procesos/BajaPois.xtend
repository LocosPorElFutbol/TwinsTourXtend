package procesos

import dominio.POI
import exepciones.ErrorAlEjecutarException
import java.util.ArrayList
import java.util.LinkedList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BajaPois implements Proceso {

	ConsumoRest consumoRest
	List<ResultadoRestBaja> resultadoRestBaja = new LinkedList<ResultadoRestBaja>()
	List<POI> listaDePois = new ArrayList<POI>()

	new(ArrayList<POI> _listaDePois) {
		listaDePois = _listaDePois
	}

	override ejecutar() {
		try {
			resultadoRestBaja.forEach [ res |
				listaDePois.forEach [ poi |
					if (poi.sos(res.valorBusqueda))
						poi.bajaLogica()
				]
			]
		} catch (Exception ex) {
			throw new ErrorAlEjecutarException("BajaPois.ejecutar() - Error al intentar realizar baja lógica", ex)
		}
	}
}
