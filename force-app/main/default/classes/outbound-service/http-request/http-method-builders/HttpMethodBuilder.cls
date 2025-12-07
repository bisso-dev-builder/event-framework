/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpMethodBuilder implements HttpPayloadInjector {   
    
    virtual
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        HttpPayloadInjector builder = HttpMethodBuilders.get (request.getMethod());

        return builder.injectPayload(payload, request);

    }

}