/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpMethodBuilder {   
    
    static Map<String, HttpMethodBuilder> builders;

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

        if (builders != null) return;

        builders = new Map<String, HttpMethodBuilder> {
            'GET' => new HttpQueryStringBuilder(),
            'POST' => new HttpPostBuilder(),
            'PATCH' => new HttpRestBodyBuilder(),
            'DELETE' => new HttpQueryStringBuilder()
        };

    }



}