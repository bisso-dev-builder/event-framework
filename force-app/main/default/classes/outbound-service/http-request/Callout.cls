/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class Callout {

    OutboundEventConfig config;

    HttpRequestBuilder requestBuilder;

    HttpResponseBuilder responseBuilder;

    public Callout(OutboundEventConfig config) {
        this.config = config;
        this.requestBuilder = new RestRequestBuilder(config);
    }

    virtual
    public Object send ( Object requestContent ) {

        HttpResponse response = new Http().send( requestBuilder
                                                    .withPayload(requestContent)
                                                    .build() );

        return responseBuilder.buildReponse(response);

    }

    public void setHttpRequestBuilder (HttpRequestBuilder requestBuilder) {
        this.requestBuilder = requestBuilder;
    }

    public void setHttpResponseBuilder (HttpResponseBuilder responseBuilder) {
        this.responseBuilder = responseBuilder;
    }

}