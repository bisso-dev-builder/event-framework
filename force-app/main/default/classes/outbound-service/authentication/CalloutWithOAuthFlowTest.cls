@isTest
public class CalloutWithOAuthFlowTest {

    


    @isTest
    static void givenValidRequestContentWhenSendThenExecuteOAuthFlowAndReturnResponse() {

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        EventQueue event = EventQueueFixtureFactory.newEventWithOutboundConfig('GetAddress', 'AbstractOutboundCommandTest.GetAddressResponse');        
        
        EventQueue oAuthEvent = EventQueueFixtureFactory.newOAuthEventWithOutboundConfig('TestOAuthEvent', 'BaseAuthToken');        
                
        CalloutWithOAuthFlow callout = new CalloutWithOAuthFlow(event);
        callout.setOAuthEvent(oAuthEvent);
        callout.setOAuthCallout( new Callout(oAuthEvent) );

        MultiHttpMock mocks = new MultiHttpMock()
                                .addMock('AbstractOutboundCommandTest.GetAddressResponse', new HttpMock(AbstractOutboundCommandTest.payloadResponse))
                                .addMock('BaseAuthToken', new HttpMock(buildFakeAuthorizationPayload ()));

        Test.setMock(HttpCalloutMock.class, mocks);

        Test.startTest();

        Object response = callout.send(AbstractOutboundCommandTest.expectedRequestPayload);

        Test.stopTest();

        Assert.isNotNull(response, 'Response must not be null.');

        AbstractOutboundCommandTest.GetAddressResponse addressResponse = (AbstractOutboundCommandTest.GetAddressResponse) response;

        Assert.areEqual( expectedResponse.logradouro, addressResponse.logradouro, 'Should return the same street from expected response.');

        //Assert.areEqual(2,  mock.callCount, 'Should perform two HTTP callouts (OAuth + business).' );

        //Assert.isNotNull(mock.businessAuthorizationHeader,'Business request must contain Authorization header.');

        
    }


    public static String buildFakeAuthorizationPayload () {

        return new BaseAuthToken ()
                .accessToken(StringGenerator.text(10))
                .toString();

    }

    /*
    @isTest
    static void givenNullRequestContentWhenSendThenAuthenticateAndReturnResponse() {
        AbstractOutboundCommandTest.GetAddressResponse expectedResponse =
            AbstractOutboundCommandTest.newDefaultAddressResponse();

        EventQueue event = CalloutWithOAuthFlowFixtureFactory.newEvent();

        OAuthHttpMock mock = new OAuthHttpMock();
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        CalloutWithOAuthFlow callout = new CalloutWithOAuthFlow(event);
        Object response = callout.send(null);
        Test.stopTest();

        Assert.isNotNull(response, 'Response must not be null.');

        AbstractOutboundCommandTest.GetAddressResponse addressResponse =
            (AbstractOutboundCommandTest.GetAddressResponse) response;

        Assert.areEqual(
            expectedResponse.logradouro,
            addressResponse.logradouro,
            'Should return the same street from expected response even with null payload.'
        );

        Assert.areEqual(
            2,
            mock.callCount,
            'Should perform two HTTP callouts (OAuth + business) even with null payload.'
        );

        Assert.isNotNull(
            mock.businessAuthorizationHeader,
            'Business request must contain Authorization header even with null payload.'
        );

        Assert.isTrue(
            mock.businessAuthorizationHeader.contains('TOKEN123'),
            'Authorization header must contain the access token.'
        );
    }

    private class OAuthHttpMock implements HttpCalloutMock {
        public Integer callCount = 0;
        public String businessAuthorizationHeader;

        public HttpResponse respond(HttpRequest request) {
            callCount++;

            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);

            if (callCount == 1) {
                response.setBody(CalloutWithOAuthFlowFixtureFactory.defaultOAuthTokenPayload());
            } else {
                businessAuthorizationHeader = request.getHeader('Authorization');
                response.setBody(AbstractOutboundCommandTest.payloadResponse);
            }

            return response;
        }
    }

    */
}