/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpPostBuilder  extends HttpMethodBuilder {

    Map<String,HttpMethodBuilder> postBuilders; 

    public HttpPostBuilder() {
        initialize();
    }

    public void initialize () { 
        this.postBuilders = new Map<String, HttpMethodBuilder> {
            'application/json' => new HttpRestBodyBuilder(),
            'application/x-www-form-urlencoded' => new HttpEncodedParametersBuilder()
        };
    }

    virtual
    override
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        return findBuilderWithHeader(request).injectPayload(payload, request);

    }

    virtual
    protected HttpMethodBuilder findBuilderWithHeader ( HttpRequest request ) {

        String contentType = request.getHeader('Content-Type');

        if (String.isEmpty(contentType)) new HttpRestBodyBuilder(); 

        for ( String builders : postBuilders.keySet() ) {

            if ( contentType.contains(builders) ) {
                return postBuilders.get(builders);
            }

        }

        return new HttpRestBodyBuilder();

    }

}