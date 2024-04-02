/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpRestBodyBuilder extends HttpMethodBuilder {
    
    virtual
    override
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        request.setBody( JSON.serialize(payload) );
        
        return request;

    }

}