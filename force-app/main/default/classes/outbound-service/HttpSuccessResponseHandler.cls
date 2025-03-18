/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpSuccessResponseHandler extends HttpResponseHandler {
    
    EventQueue event;

    Integer startHttpStatusCode;
    Integer endHttpStatusCode;

    public HttpSuccessResponseHandler(EventQueue event) {
        super(event.getOutboundConfig());
        startHttpStatusCode = 200;
        endHttpStatusCode = 299;
    }

    override
    public Object handle(HttpResponse response) {        
        
        Type classType = Type.forName (this.getConfig().getResponseClassName());

        return JSON.deserialize(response.getBody() , classType);
        
    }

    override
    public Boolean accept (HttpResponse response) {

        return response.getStatusCode() >= startHttpStatusCode
                && response.getStatusCode () <= endHttpStatusCode;

    }    


}