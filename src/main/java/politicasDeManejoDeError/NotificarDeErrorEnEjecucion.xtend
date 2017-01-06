package politicasDeManejoDeError

import observer.MailSender
import procesos.ResultadoDeEjecucion
import procesos.ConsolaDeProcesos

class NotificarDeErrorEnEjecucion extends PoliticaDeManejoDeError{
	MailSender mailSender
	
	new(ConsolaDeProcesos _consola, MailSender _mailSender) {
		super.consola = _consola
		mailSender = _mailSender
	}

	override politiquiar(ResultadoDeEjecucion ejecucion) {
		mailSender.SendMail(ejecucion.usuario.mail + "Error al ejecutar un proceso")
	}
	
}
