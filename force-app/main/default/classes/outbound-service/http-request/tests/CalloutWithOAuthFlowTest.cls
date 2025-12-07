@isTest
public class CalloutWithOAuthFlowTest {
    
    @isTest
    static void givenValidOAuthEventWhenSendThenAuthenticateAndSendRequest() {
        // Arrange (Given)
        EventQueue eventQueue = CalloutWithOAuthFlowFixtureFactory.newEventQueue();
        CalloutWithOAuthFlow callout = CalloutWithOAuthFlowFixtureFactory.newCalloutWithOAuthFlow();

        // Mock OAuth Callout
        Test.setMock(HttpCalloutMock.class, new HttpMock(JSON.serialize(CalloutWithOAuthFlowFixtureFactory.newBaseAuthToken())));

        // Act (When)
        Test.startTest();
        Object response = callout.send('Test Request Content');
        Test.stopTest();

        // Assert (Then)
        System.assertNotEquals(null, response, 'Expected a valid response');
    }

    @isTest
    static void givenInvalidOAuthEventWhenAuthenticateThenThrowException() {
        // Arrange (Given)
        EventQueue eventQueue = CalloutWithOAuthFlowFixtureFactory.newEventQueue();
        CalloutWithOAuthFlow callout = CalloutWithOAuthFlowFixtureFactory.newCalloutWithOAuthFlow();

        // Mock OAuth Callout with error
        Test.setMock(HttpCalloutMock.class, new HttpMock('{"error": "invalid_client"}'));

        // Act & Assert (When & Then)
        try {
            Test.startTest();
            callout.send('Test Request Content');
            Test.stopTest();
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('invalid_client'), 'Expected invalid_client error');
        }
    }
}