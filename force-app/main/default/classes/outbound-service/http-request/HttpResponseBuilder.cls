/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpResponseBuilder {

    EventOutboundConfig__mdt config;

    public HttpResponseBuilder(EventOutboundConfig__mdt config) {
        this.config = config;
    }

    virtual
    public Object buildReponse ( HttpResponse response ) {

        Type classType = Type.forName (this.config.ResponseClassName__c);

        return JSON.deserialize(response.getBody() , classType);

    }


}