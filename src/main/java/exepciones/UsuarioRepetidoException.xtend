package exepciones

class UsuarioRepetidoException extends Exception {
	new(String msg) {
        super(msg)
    }
    
	new(String msg, Throwable cause) {
        super(msg, cause)
    }
}