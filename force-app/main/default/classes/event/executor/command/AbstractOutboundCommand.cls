public abstract class AbstractOutboundCommand implements Command {

    EventQueue event;

    Callout callout;

    Object response;

    public AbstractOutboundCommand() {
    }

    public EventQueue getEvent() {
        return this.event;
    }

    public Callout getCallout() {
        return this.callout;
    }

    public void setCallout (Callout callout) {
        this.callout = callout;
    }
    
    public Object getResponse () {
        return this.response;
    }

    virtual
    public void setResponse (Object response) {
        this.response = response;
    }

    virtual
    public void setup(EventQueue event) {
        this.event = event;
        this.callout = new Callout(event);
    }

    virtual
    public void callout (EventQueue event) {
        
        setup(event);
        
        setResponse(send());
    }

    virtual
    public Object send () {
        return this.callout.send(transform());
    }

    public abstract Object transform();


    virtual
    public void executeUpdate (EventQueue event) {        

        Savepoint savepoint = Database.setSavepoint();

        try {

            executeUpdate();

        } catch (Exception e) {
            Database.rollback(savepoint);
            throw e;
        }

    }

    public abstract void executeUpdate ();

}