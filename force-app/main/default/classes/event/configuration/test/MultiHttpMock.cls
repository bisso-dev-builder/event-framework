@isTest
public class MultiHttpMock implements HttpCalloutMock {

    Map<String, HttpMock> mocks;

    public MultiHttpMock() {
        mocks = new Map<String, HttpMock>();
    }

    public MultiHttpMock addMock ( String responseClassName, HttpMock mock) {
        mocks.put(responseClassName, mock);
        return this;
    }

    public HttpResponse respond(HttpRequest request) {

        HttpMock mock = findMock(request);

        if (mock == null) throw new InvalidHttpMockConfigurationException('Unable to find HttpMock for request ' + request.getEndpoint() );

        return mock.respond(request);
    }



    private HttpMock findMock (HttpRequest request) {

        for ( String key: mocks.keySet() ) {
            if ( request.getEndpoint().contains( key ) ) {
                return mocks.get(key);
            }
        }
        return null;
    }

    public class InvalidHttpMockConfigurationException extends Exception {}

}