/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class Callout {

    protected EventQueue event;

    protected OutboundEventConfig config;

    protected HttpRequestBuilder requestBuilder;

    protected HttpResponseBuilder responseBuilder;

    public Callout(EventQueue event) {
        this( event, new RestRequestBuilder(event) );
    }

    public Callout(EventQueue event, HttpRequestBuilder requestBuilder) {
        this.event = event;
        this.config = event.getOutboundConfig();
        this.requestBuilder = requestBuilder;
        this.responseBuilder = new HttpResponseBuilder (config);
    }    

    virtual
    public Object send ( Object requestContent ) {

        requestPrepare(requestContent);

        HttpResponse response = new Http().send( this.requestBuilder.build() );

        return responseBuilder.buildResponse(response);

    }

    virtual
    protected void requestPrepare (Object requestContent) {

        if (requestContent == null) return;

        this.requestBuilder.withPayload(requestContent);        
    }

    public EventQueue getEvent() {
        return this.event;
    }

    public void setEvent(EventQueue event) {
        this.event = event;
    }

    public OutboundEventConfig getConfig() {
        return this.config;
    }

    public void setConfig(OutboundEventConfig config) {
        this.config = config;
    }

    public HttpRequestBuilder getRequestBuilder() {
        return this.requestBuilder;
    }

    public HttpResponseBuilder getResponseBuilder() {
        return this.responseBuilder;
    }

    public void setHttpRequestBuilder (HttpRequestBuilder requestBuilder) {
        this.requestBuilder = requestBuilder;
    }

    public void setHttpResponseBuilder (HttpResponseBuilder responseBuilder) {
        this.responseBuilder = responseBuilder;
    }

}