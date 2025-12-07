/**
 * @author eduardo.bisso - dev-builder
 */
public abstract class HttpResponseHandler {

    OutboundEventConfig config;

    public HttpResponseHandler(OutboundEventConfig config) {
        this.config = config;
    }

    public OutboundEventConfig getConfig() {
        return this.config;
    }

    public void setConfig(OutboundEventConfig config) {
        this.config = config;
    }
    
    public abstract Object handle (HttpResponse response);

    public abstract Boolean accept (HttpResponse response);

}