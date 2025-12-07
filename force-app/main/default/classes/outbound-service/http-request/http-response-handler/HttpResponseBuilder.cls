/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpResponseBuilder {

    OutboundEventConfig config;

    HttpResponse response;

    public HttpResponseBuilder(OutboundEventConfig config) {
        this.config = config;
    }

    virtual
    public Object buildResponse ( HttpResponse response ) {

        this.response = response;

        onErrorThrowException ();

        Type classType = Type.forName (this.config.getResponseClassName());

        return JSON.deserialize(response.getBody() , classType);

    }

    virtual
    public void onErrorThrowException () {
        if (hasError () ) {
            throw new IntegrationException(response);
        }
    }

    virtual
    public Boolean isSuccess () {
        return this.response.getStatusCode() >= 200 
                    && this.response.getStatusCode() <= 300;
    }


    virtual
    public Boolean hasError () {
        return this.response.getStatusCode() >= 400;
    }

}