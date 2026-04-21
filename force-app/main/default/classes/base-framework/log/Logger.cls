public class Logger {

    @TestVisible
    ILogger adapter;    

    static Logger instance;

    private Logger() {
        this(new DefaultLoggerAdapter());
    }


    private Logger(ILogger adapter) {
        this.adapter = adapter;
    }

    public static Logger getLogger () {
        
        if (instance == null) instance = new Logger();

        return instance;
    }

    public static Logger getLogger (ILogger adapter) {
        
        if (instance == null) instance = new Logger(adapter);

        return instance;
    }

    public void log ( String message ) {
        log ( LoggingLevel.INFO, message);
    }

    public void log ( String message, Map<String, Object> payload ) {
        log ( new Log().level(LoggingLevel.INFO).message(message).parameters(payload) );
    }

    public void error ( String message ) {
        log (LoggingLevel.ERROR, message);        
    }

    public void error ( String message, Exception ex ) {
        log ( new Log().exception(ex).message(message) );
    }

    public void error ( String message, Exception ex, Map<String, Object> payload ) {
        log ( new Log().exception(ex).message(message).parameters(payload) );
    }

    public void debug ( String message ) {
        log ( LoggingLevel.DEBUG, message);        
    }

    public void warn ( String message ) {
        log ( LoggingLevel.WARN, message );
    }

    private void log ( LoggingLevel level, String message ) {
        log ( new Log().level(level).message(message) );
    }

    public void log ( Log log ) {
        adapter.log(log);
    }

}