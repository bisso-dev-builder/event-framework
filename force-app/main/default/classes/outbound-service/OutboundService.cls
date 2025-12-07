/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class OutboundService {

    protected Callout callout;

    protected EventQueue event;

    public OutboundService( String eventName ) {
        this ( new EventQueue(eventName) );
    }

    public OutboundService( EventQueue event ) {
        this (event, new Callout(event) );
    }

    public OutboundService( EventQueue event, Callout callout) {
        this.event = event;
        this.callout = callout;
    }

    virtual
    public Object send (Object data) {

        try {

            return this.callout.send(data);

        } catch (Exception e) {

            event.withError(e);

            throw e;

        }

    }

    
    public Callout getCallout () {
        return this.callout;
    }

    public void setCallout (Callout callout) {
        this.callout = callout;
    }

    public EventQueue getEvent() {
        return this.event;
    }

}