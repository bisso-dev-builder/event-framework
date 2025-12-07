/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpPostBuilder implements HttpPayloadInjector {

    Map<String,HttpPayloadInjector> postBuilders; 

    public HttpPostBuilder() {
        initialize();
    }

    public void initialize () { 
        this.postBuilders = new Map<String, HttpPayloadInjector> {
            'application/json' => new HttpRestBodyBuilder(),
            'application/x-www-form-urlencoded' => new HttpEncodedParametersBuilder()
        };
    }

    virtual
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        return findBuilderWithHeader(request).injectPayload(payload, request);

    }

    virtual
    protected HttpPayloadInjector findBuilderWithHeader ( HttpRequest request ) {

        String contentType = request.getHeader('Content-Type');

        if (String.isEmpty(contentType) ) return new HttpRestBodyBuilder(); 

        for ( String builders : postBuilders.keySet() ) {

            if ( contentType.contains(builders) ) {
                return postBuilders.get(builders);
            }

        }

        return new HttpRestBodyBuilder();

    }

}