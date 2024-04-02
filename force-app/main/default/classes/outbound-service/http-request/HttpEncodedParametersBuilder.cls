/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpEncodedParametersBuilder extends HttpMethodBuilder {

    
    virtual
    override
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        request.setBody( buildQueryParameters( deserializePayload(payload) ) );        
        
        return request;

    }


    virtual
    public Map<String,String> deserializePayload (Object payload) {
        
        return (Map<String, String>) JSON.deserialize( JSON.serialize (payload), Map<String, String>.class );
        
    }

    virtual
    public String buildQueryParameters (Map<String, String> parameters) {

        String queryParameters = '';
        
        for ( String parameter : parameters.keySet() ) {

            if (parameters.get( parameter ) == null) continue;

            queryParameters += parameter + '=' + EncodingUtil.urlEncode( parameters.get( parameter ), 'UTF-8') + '&';
        }

        return queryParameters;

    }

}