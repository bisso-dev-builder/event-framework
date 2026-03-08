public virtual class DefaultLoggerAdapter implements ILogger {
	
    virtual
    public void log (Log log) {

        String logMessage = getCurrentStackInfo() + ' - ' + log.getMessage();
        logMessage += '\n' + log.getParameterAsString();
        logMessage += '\n' + log.getExceptionMessageAndStackTrace();
	
        log ( log.getLevel(), logMessage );               

	}	

    protected String getCurrentStackInfo () {       
        return StackTraceCollector.getCurrentStack().toString();
    }

    virtual
    public void log ( LoggingLevel level, String message) {
        System.debug (level, message);               
    }

}