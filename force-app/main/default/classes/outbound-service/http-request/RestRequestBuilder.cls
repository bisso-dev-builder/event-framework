/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class RestRequestBuilder extends HttpRequestBuilder {
    
    OutboundEventConfig config;

    public RestRequestBuilder( OutboundEventConfig config ) {
        super();
        init(config);        
    }
    
    virtual
    public void init (OutboundEventConfig config) {
        
        this.config = config;

        withEndPoint(this.config.getEndPointUrl())
            .withHeaders(this.config.getHttpHeaders())
            .withMethod (this.config.getHttpMethod())
            .withTimeout( this.config.getTimeout() )
            .withCertificate (this.config.getCertificateName());
            
    }


}