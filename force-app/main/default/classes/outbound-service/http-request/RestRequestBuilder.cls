/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class RestRequestBuilder extends HttpRequestBuilder {

    EventQueue event;
    
    OutboundEventConfig config;

    public RestRequestBuilder( EventQueue event ) {
        super();
        this.event = event;
        this.config = event.getOutboundConfig();
        setup();        
    }
    
    virtual
    public void setup () {

        if (config == null) {return;}

        withEndPoint(this.config.getEndPointUrl())
            .withHeaders(this.config.getHttpHeaders())
            .withMethod (this.config.getHttpMethod())
            .withTimeout( this.config.getTimeout() )
            .withCertificate (this.config.getCertificateName());
            
    }

}