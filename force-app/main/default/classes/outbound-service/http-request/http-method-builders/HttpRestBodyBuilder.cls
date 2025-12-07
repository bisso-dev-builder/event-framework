/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpRestBodyBuilder implements HttpPayloadInjector {
    
    virtual
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        request.setBody( JSON.serialize(payload) );
        
        return request;

    }

}