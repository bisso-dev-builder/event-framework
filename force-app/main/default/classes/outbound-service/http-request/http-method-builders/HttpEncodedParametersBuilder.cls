/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpEncodedParametersBuilder implements HttpPayloadInjector {

    
    virtual
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        if ( payload == null ) {
            return request;
        }

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

            String value = parameters.get( parameter );
            if ( value == null ) {
                continue;
            } 

            queryParameters += parameter + '=' + endode(value) + '&';
        }

        return queryParameters;

    }

    private String endode (String value) {

        if (isBindVariable(value)) {
            return value;
        }

        return EncodingUtil.urlEncode( value, 'UTF-8');
    }

    private Boolean isBindVariable (String value) {
        return !String.isEmpty(value) && value.indexOf('$Credential') > 0;
    }

}