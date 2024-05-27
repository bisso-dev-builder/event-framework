/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class Callout {

    EventQueue event;

    OutboundEventConfig config;

    HttpRequestBuilder requestBuilder;

    HttpResponseBuilder responseBuilder;

    public Callout(EventQueue event) {
        this( event, new RestRequestBuilder(event) );
    }

    public Callout(EventQueue event, HttpRequestBuilder requestBuilder) {
        this.event = event;
        this.config = event.getOutboundConfig();
        this.requestBuilder = requestBuilder;
    }    

    virtual
    public Object send ( Object requestContent ) {

        requestPrepare(requestContent);

        HttpResponse response = new Http().send( this.requestBuilder.build() );

        return responseBuilder.buildReponse(response);

    }

    virtual
    protected void requestPrepare (Object requestContent) {
        this.requestBuilder.withPayload(requestContent);        
    }

    public void setHttpRequestBuilder (HttpRequestBuilder requestBuilder) {
        this.requestBuilder = requestBuilder;
    }

    public void setHttpResponseBuilder (HttpResponseBuilder responseBuilder) {
        this.responseBuilder = responseBuilder;
    }

}