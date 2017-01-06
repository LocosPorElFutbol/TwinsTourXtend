package datosExternosCGPs

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ServicioDTO {
	String nombreDelServicio
	List<RangoServicioDTO> rangosServicioDTO
}