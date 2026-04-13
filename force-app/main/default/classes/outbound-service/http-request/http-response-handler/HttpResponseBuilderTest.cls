@isTest
public class HttpResponseBuilderTest {

    @isTest
    static void shouldThrowIntegrationExceptionWhenResponseHasError() {
        // Given
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setStatusCode(400);
        httpResponse.setBody('{"error": "Bad Request"}');

        OutboundEventConfig config = new OutboundEventConfig();
        HttpResponseBuilder builder = new HttpResponseBuilder(config);

        // When / Then
        try {
            builder.buildResponse(httpResponse);
            Assert.fail('Should have thrown IntegrationException');
        } catch (IntegrationException e) {
            Assert.isTrue(e.getMessage().contains('400'), 'Exception message should contain status code');
        }
    }

    @isTest
    static void shouldReturnTrueWhenStatusCodeIndicatesSuccess() {
        // Given
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setStatusCode(200);
        httpResponse.setBody('"ok"');

        OutboundEventConfig config = new OutboundEventConfig().responseClassName('String');
        HttpResponseBuilder builder = new HttpResponseBuilder(config);

        // When
        builder.buildResponse(httpResponse);

        // Then
        Assert.isTrue(builder.isSuccess(), 'isSuccess should return true for 200 status');

        Assert.areEqual( '"ok"' ,builder.toString());
        
    }

    @isTest
    static void shouldReturnFalseForIsSuccessWhenStatusCodeIsError() {
        // Given
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setStatusCode(500);
        httpResponse.setBody('{"error":"Internal Server Error"}');

        OutboundEventConfig config = new OutboundEventConfig();
        HttpResponseBuilder builder = new HttpResponseBuilder(config);

        try {
            builder.buildResponse(httpResponse);
        } catch (IntegrationException e) {
            // expected - now response is set on builder
        }

        // Then
        Assert.isFalse(builder.isSuccess(), 'isSuccess should return false for 500 status');
    }

}
