/**
 * @author eduardo.bisso - dev-builder
 */
public class HttpQueryStringBuilder extends HttpEncodedParametersBuilder {
    
    virtual
    override
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        String endPoint = buildStartQueryStringUrl(request) + buildQueryParameters( deserializePayload(payload) );

        request.setEndpoint(endpoint);

        return request;

    }

    @TestVisible
    private String buildStartQueryStringUrl (HttpRequest request) {

        if (request.getEndpoint().indexOf('?') == -1) return '?';

        if (!request.getEndpoint().endsWith('&')) return '&';

        return '';
    }

}