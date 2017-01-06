package dominio

import java.util.List

interface DatosExternos {
	def List<POI> buscar(String palabra)
}