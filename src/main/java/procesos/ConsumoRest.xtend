package procesos

import java.util.ArrayList

interface ConsumoRest {
	ArrayList<ResultadoRestBaja> resultadoRestBaja = null
	def void ConsumirRestBaja(ArrayList<ResultadoRestBaja> lista)
}
