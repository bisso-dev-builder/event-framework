public virtual class Log {
    
    String tag;

    String message;

    Exception exceptionInfo;

    LoggingLevel level;

    Map<String, Object> parameters;

    public Log() {
        parameters = new Map<String, Object>();
        level = LoggingLevel.INFO;
    }

    public String getTag() {
        return this.tag;
    }

    virtual
    public String getMessage() {
        return this.message;
    }

    public Exception getExceptionInfo() {
        return this.exceptionInfo;
    }

    public LoggingLevel getLevel() {
        return this.level;
    }

    public Map<String,Object> getParameters() {
        return this.parameters;
    }

    virtual
    public Log tag(String tag) {
        this.tag = tag;
        return this;
    }

    public Log message(String message) {
        this.message = message;
        return this;
    }

    public Log exception(Exception e) {
        this.level = LoggingLevel.ERROR;
        this.exceptionInfo = e;
        return this;
    }

    public Log level(LoggingLevel level) {
        this.level = level;
        return this;
    }

    public Log parameters(Map<String,Object> parameters) {
        this.parameters = parameters;
        return this;
    }

    public Log addParameter( String key, Object value ) {
        this.parameters.put ( key, value );
        return this;
    }

    public Boolean hasError () {
        return this.exceptionInfo != null;
    }
    
    public String getErrorMessage () {

        if (!hasError()) return '';

        if (exceptionInfo instanceOf DmlException) {
            return ((DmlException) exceptionInfo).getDmlMessage(0);
        }
	
        return this.exceptionInfo.getMessage();
    }

	public String getParameterAsString() {

        return !Maps.isEmpty( parameters) ? JSON.serialize(parameters) : '';

    }
	
    public String getExceptionMessageAndStackTrace() {

        if (!hasError()) return '';
        
        String error = getErrorMessage();

        return error + '\n Stack Trace \n' + exceptionInfo.getStackTraceString();

    }

    public Log log ( List<String> messages ) {        
        return message ( String.join (messages, '\n') );
    }

}