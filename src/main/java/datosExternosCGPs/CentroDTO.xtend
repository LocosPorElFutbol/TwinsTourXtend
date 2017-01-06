package datosExternosCGPs

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class CentroDTO {
	double x
	double y
	String tipo
	String nombreCompleto
	int numeroDeComuna
	String barriosQueIncluye
	String nombreDelDirector
	String domicilioCompleto
	String telefono
	List<ServicioDTO> serviciosDTO
}