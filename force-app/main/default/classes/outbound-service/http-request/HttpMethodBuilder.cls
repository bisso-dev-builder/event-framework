/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpMethodBuilder {   
    
    Map<String, HttpMethodBuilder> builders;

    public HttpMethodBuilder() {
        loadBuilders();
    }

    virtual
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        HttpMethodBuilder builder = builders.get (request.getMethod());

        return builder.injectPayload(payload, request);

    }

    virtual
    public void loadBuilders() {
        builders = new Map<String, HttpMethodBuilder> {
            'GET' => new HttpQueryStringBuilder(),
            'POST' => new HttpRestBodyBuilder(),
            'PATCH' => new HttpRestBodyBuilder(),
            'DELETE' => new HttpQueryStringBuilder()
        };
    }



}