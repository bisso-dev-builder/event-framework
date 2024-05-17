/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class OutboundService {

    protected Callout callout;

    protected EventQueue event;

    public OutboundService( EventQueue event ) {
        this.event = event;
        this.callout = getCallout (event);
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

    virtual
    public Callout getCallout (EventQueue event) {
        return new Callout(event.getOutboundConfig());
    }

    public void setCallout (Callout callout) {
        this.callout = callout;
    }

    public EventQueue getEvent() {
        return this.event;
    }

}