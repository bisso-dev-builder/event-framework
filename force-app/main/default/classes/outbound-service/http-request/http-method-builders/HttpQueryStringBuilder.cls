/**
 * @author eduardo.bisso - dev-builder
 */
public class HttpQueryStringBuilder extends HttpEncodedParametersBuilder {
    

    virtual
    override
    public HttpRequest injectPayload (Object payload, HttpRequest request) {

        Map<String,String> requestContent = deserializePayload(payload);

        String endPoint = request.getEndpoint() + buildStartQueryStringUrl(request) + buildQueryParameters( requestContent );

        endPoint = HttpRequestUrlBinder.bind(endPoint, requestContent);

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