package procesos

import org.eclipse.xtend.lib.annotations.Accessors
import java.io.File
import java.io.BufferedReader
import java.io.FileReader
import dominio.Directorio
import java.io.FileNotFoundException
import exepciones.ErrorAlEjecutarException
import java.io.IOException

@Accessors
class ActualizarLocales implements Proceso {

	String archivoActualizacion

	new(String archivo) {
		archivoActualizacion = archivo
	}

	override ejecutar() {
		val File archivo = new File(archivoActualizacion)
		var BufferedReader in
		var String lineaLeida
		try {
			in = new BufferedReader(new FileReader(archivo))
			while ((lineaLeida = in.readLine()) != null) {
				if (lineaLeida.contains(";")) {
					val String[] partes = lineaLeida.split(";", 2)
					Directorio.instancia.actualizarComercios(partes.get(0).trim, partes.get(1).trim.split("[ ]+"))
				}
			}
		} catch (FileNotFoundException e) {
			throw new ErrorAlEjecutarException("No existe el archivo " + archivoActualizacion, e)
		} catch (IOException e) {
			throw new ErrorAlEjecutarException("Error de Lectura/Escritura en " + archivoActualizacion, e)
		} finally {
			if (in != null)
				in.close
		}
	}
}
