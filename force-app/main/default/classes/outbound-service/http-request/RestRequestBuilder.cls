/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class RestRequestBuilder extends HttpRequestBuilder {
    
    EventOutboundConfig__mdt config;

    public RestRequestBuilder( EventOutboundConfig__mdt config ) {
        super();
        init(config);        
    }
    
    virtual
    public void init (EventOutboundConfig__mdt config) {
        
        this.config = config;

        withEndPoint(this.config.EndPoint__c)
            .withHeaders(this.config.HttpHeaders__c)
            .withMethod (this.config.HttpMethod__c)
            .withTimeout( this.config?.Timeout__c?.intValue() ?? 120000 )
            .withCertificate (this.config.CertificateName__c);
            
    }


}