package observer

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class NotificarAdministradorObserver implements Observer{
	List<String> mailsAdministradores
	MailSender mailSender
	
	int demoraMaxima
	String nombre
	
	new(int _demoraMaxima){
		demoraMaxima = _demoraMaxima
		nombre = "Notificar administrador"
	}
	
	override notificar (DatosParaObserver _datosParaObserver){
		if (_datosParaObserver.tiempoDemoraBusqueda > demoraMaxima)
			sendMail()
	}

	def sendMail() {
		mailsAdministradores.forEach[sender|mailSender.SendMail(sender)]
	}
	
}