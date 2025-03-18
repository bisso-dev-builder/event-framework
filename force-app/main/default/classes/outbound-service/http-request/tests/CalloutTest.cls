@isTest
public class CalloutTest {
   

    @isTest
    static void givenValidRequestContentWhenSendThenReturnResponse() {


        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();
        
        EventQueue event = EventQueueFixtureFactory.newEventWithOutboundConfig('GetAddress'
                                                        , 'AbstractOutboundCommandTest.GetAddressResponse');        
        
        Test.setMock(HttpCalloutMock.class, new HttpMock(AbstractOutboundCommandTest.payloadResponse));

        Test.startTest();
            
        Callout callout = new Callout (event);

        Object response = callout.send( AbstractOutboundCommandTest.expectedRequestPayload );
        
        Test.stopTest();

        Assert.isNotNull( response, 'A resposta não deve ser nula.');

        AbstractOutboundCommandTest.GetAddressResponse addressResponse = (AbstractOutboundCommandTest.GetAddressResponse) response;
        
        Assert.areEqual( expectedResponse.logradouro , addressResponse.logradouro , 'Deve retornar o mesmo logradouro');


    }


    @isTest
    static void shouldValidateGettersAndSetters() {

        // Arrange
        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();
        
        EventQueue event = EventQueueFixtureFactory.newEventWithOutboundConfig('GetAddress'
                                                        , 'AbstractOutboundCommandTest.GetAddressResponse');        

        HttpRequestBuilder requestBuilder = new RestRequestBuilder (event);                                                      

        HttpResponseBuilder responseBuilder = new HttpResponseBuilder(event.getOutboundConfig());

        Callout callout = new Callout (event);

        // Act
        callout.setEvent(event);
        callout.setConfig(event.getOutboundConfig());

        callout.setHttpRequestBuilder( requestBuilder );

        callout.setHttpResponseBuilder(responseBuilder);

        // Assert
        Assert.areEqual(event, callout.getEvent(), 'O getter getEvent deve retornar o valor correto.');
        
        Assert.isNotNull(callout.getConfig(), 'O getter getConfig deve retornar o valor correto.');
        
        Assert.areEqual(requestBuilder, callout.getRequestBuilder(), 'O getter getRequestBuilder deve retornar o valor correto.');
        Assert.areEqual(responseBuilder, callout.getResponseBuilder(), 'O getter getResponseBuilder deve retornar o valor correto.');
    }


    public class CalloutMock extends Callout {

        Object response;

        public CalloutMock( Object response, EventQueue event) {
            super( event );
            this.response = response;
        }

        override
        public Object send ( Object requestContent ) {
            return response;
        }

    }

    public class CalloutExceptionMock extends Callout {        

        Exception exceptionToBeThrow;

        public CalloutExceptionMock( EventQueue event , Exception exceptionToBeThrow ) {
            super( event );
            this.exceptionToBeThrow = exceptionToBeThrow;
        }

        override
        public Object send ( Object requestContent ) {

            if (true) {
                throw exceptionToBeThrow;
            }

            return null;
        }

    }




}