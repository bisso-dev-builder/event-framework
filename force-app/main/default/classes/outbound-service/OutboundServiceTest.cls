@isTest(isParallel=true)
public class OutboundServiceTest {
    

    @isTest
    public static void shouldSendHttpRequest () {

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();
        
        EventQueue event = EventQueueFixtureFactory.newEventWithOutboundConfig('GetAddress', 'AbstractOutboundCommandTest.GetAddressResponse');    
        
        Test.setMock(HttpCalloutMock.class, new HttpMock(AbstractOutboundCommandTest.payloadResponse));

        Test.startTest();
        
        OutboundService service = new OutboundService(event);
        
        Object response = service.send(AbstractOutboundCommandTest.expectedRequestPayload);
        
        Test.stopTest();
        
        Assert.isNotNull(response, 'Response must not be null.');

        AbstractOutboundCommandTest.GetAddressResponse addressResponse = (AbstractOutboundCommandTest.GetAddressResponse) response;

        Assert.areEqual( expectedResponse.logradouro, addressResponse.logradouro, 'Should return the same street from expected response.');

        
    }


    @isTest
    public static void shouldThrowExceptionWhenSend () {

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();
        
        EventQueue event = EventQueueFixtureFactory.newEventWithOutboundConfig('GetAddress', 'AbstractOutboundCommandTest.GetAddressResponse');    
        
        Test.startTest();
        
        OutboundService service = new OutboundService('GetAddress'); // 4 coverage
        service = new OutboundService(event);
        service.setCallout( new CalloutTest.CalloutExceptionMock(event) );
        
        try {

            Object response = service.send(AbstractOutboundCommandTest.expectedRequestPayload);
            
            Assert.fail('Exception expected');

        } catch (Exception e) {
            
            Assert.areEqual('Unable to process request', e.getMessage());

            Assert.areEqual( EventQueueStatusType.ERROR.name() , service.getEvent().getStatus() );

        }
        
        
        Test.stopTest();
        
        
    }



}