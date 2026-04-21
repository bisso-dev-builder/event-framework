@isTest(isParallel=true)
public class HttpSuccessResponseHandlerTest {

    static EventQueue newEvent() {
        return EventQueueFixtureFactory.newEventWithOutboundConfig(
            'GetAddress',
            'AbstractOutboundCommandTest.GetAddressResponse'
        );
    }

    static HttpResponse newResponse(Integer statusCode, String body) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(statusCode);
        res.setBody(body);
        return res;
    }

    // HttpResponseHandler base class: getConfig / setConfig

    @isTest
    static void shouldReturnConfigSetInConstructor() {
        EventQueue event = newEvent();
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(event);

        Assert.areEqual(
            event.getOutboundConfig(),
            handler.getConfig(),
            'getConfig should return the config passed via constructor'
        );
    }

    @isTest
    static void shouldUpdateConfigViaSetConfig() {
        EventQueue event = newEvent();
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(event);

        OutboundEventConfig newConfig = new OutboundEventConfig().responseClassName('String');
        handler.setConfig(newConfig);

        Assert.areEqual(newConfig, handler.getConfig(), 'setConfig should update the stored config');
    }

    // HttpSuccessResponseHandler.accept()

    @isTest
    static void shouldAcceptStatusCode200() {
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(newEvent());
        Assert.isTrue(handler.accept(newResponse(200, '')), 'Should accept 200');
    }

    @isTest
    static void shouldAcceptStatusCode299() {
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(newEvent());
        Assert.isTrue(handler.accept(newResponse(299, '')), 'Should accept 299');
    }

    @isTest
    static void shouldAcceptStatusCode201() {
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(newEvent());
        Assert.isTrue(handler.accept(newResponse(201, '')), 'Should accept 201');
    }

    @isTest
    static void shouldRejectStatusCodeBelow200() {
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(newEvent());
        Assert.isFalse(handler.accept(newResponse(199, '')), 'Should reject 199');
    }

    @isTest
    static void shouldRejectStatusCode300() {
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(newEvent());
        Assert.isFalse(handler.accept(newResponse(300, '')), 'Should reject 300');
    }

    @isTest
    static void shouldRejectStatusCode400() {
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(newEvent());
        Assert.isFalse(handler.accept(newResponse(400, '')), 'Should reject 400');
    }

    // HttpSuccessResponseHandler.handle()

    @isTest
    static void shouldDeserializeResponseBodyIntoConfiguredClass() {
        EventQueue event = newEvent();
        HttpSuccessResponseHandler handler = new HttpSuccessResponseHandler(event);

        HttpResponse response = newResponse(200, AbstractOutboundCommandTest.payloadResponse);

        Object result = handler.handle(response);

        Assert.isNotNull(result, 'handle should return a deserialized object');

        AbstractOutboundCommandTest.GetAddressResponse address =
            (AbstractOutboundCommandTest.GetAddressResponse) result;

        AbstractOutboundCommandTest.GetAddressResponse expected =
            AbstractOutboundCommandTest.newDefaultAddressResponse();

        Assert.areEqual(
            expected.logradouro,
            address.logradouro,
            'Deserialized object should match expected response'
        );
    }

}
