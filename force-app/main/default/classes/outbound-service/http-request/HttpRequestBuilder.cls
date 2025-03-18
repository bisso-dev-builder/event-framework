/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpRequestBuilder {
    
    protected HttpRequest request;

    protected HttpMethodBuilder httpMethodBuilder;

    public HttpRequestBuilder() {
        request = new HttpRequest();
        httpMethodBuilder = new HttpMethodBuilder ();
    }

    virtual
    public HttpRequestBuilder withEndPoint(String endpoint) {
        this.request.setEndpoint(endpoint);
        return this;
    }
    
    public String getEndPoint () {
        return this.request.getEndpoint();
    }

    public HttpRequestBuilder withTimeout(Integer timeout) {
        this.request.setTimeout(timeout);
        return this;
    }

    public HttpRequestBuilder withMethod(String method) {
        this.request.setMethod(method);
        return this;
    }  

    public HttpRequestBuilder withHeaders (String headersPayload ) {

        Map<String, String> headers = (Map<String, String>) JSON.deserialize(headersPayload
                                                                        , Map<String, String>.class);

        return withHeaders(headers);

    }

    public HttpRequestBuilder withHeaders(Map<String, String> headers) {

        for (String header : headers.keySet()) {
            withHeader(header, headers.get(header));
        }
        
        return this;
    }
    
    public HttpRequestBuilder withHeader(String key, String value) {
        this.request.setHeader(key, value);
        return this;
    }
    
    public HttpRequestBuilder withCertificate(String name) {
        if (String.isEmpty(name)) return this;
        this.request.setClientCertificateName(name);
        return this;
    }

    virtual 
    public HttpRequestBuilder withPayload (Object payload) {
        
        this.httpMethodBuilder.injectPayload ( payload , this.request );
        
        return this;
    }

    public HttpRequest build () {
        return this.request;
    }




}