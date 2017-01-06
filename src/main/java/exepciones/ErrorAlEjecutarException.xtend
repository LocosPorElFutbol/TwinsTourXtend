package exepciones

class ErrorAlEjecutarException extends Exception{
	
	new(String msg) {
        super(msg)
    }
    
	new(String msg, Throwable cause) {
        super(msg, cause)
    }
}