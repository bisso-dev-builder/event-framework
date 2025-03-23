@isTest
public class EventUpdateExecutorTest {

    @isTest
    static void shouldSkipExecuteUpdateForIgnoredEvent() {
        // Arrange
        EventQueue event = EventQueueFixtureFactory.newEvent('TestCommand');
        event.getConfig().commandClassName(null);
        event.withStatus( EventQueueStatusType.IGNORED );

        EventUpdateExecutor executor = new EventUpdateExecutor();

        // Act
        executor.execute(event);

        // Assert
        System.assertEquals(
            EventQueueStatusType.IGNORED.name(),
            event.getStatus(),
            'O evento deve ser marcado como IGNORED quando não possui handler.'
        );
    }

    @isTest
    static void shouldNotMarkDeliveredForCalloutErrorEvent() {

        // Arrange
        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.SuccessOutboundCommandMock ( requestPayload
                                                                                    , expectedResponse );

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);
        event.withStatus(EventQueueStatusType.ERROR);

        // Act
        new EventUpdateExecutor().execute(event);

        // Assert
        Assert.areEqual(
            EventQueueStatusType.ERROR.name(),
            event.getStatus(),
            'O evento deve ser marcado como ERROR quando não possui handler.'
        );

        Assert.isTrue( ((AbstractOutboundCommandTest.SuccessOutboundCommandMock) command).executeUpdateExecuted 
                    , 'Deve ter executado o método executeUpdate' );

    }


    @isTest
    static void shouldMarkDeliveredWithSuccessExecutedEvent() {

        // Arrange
        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.SuccessOutboundCommandMock ( requestPayload
                                                                                    , expectedResponse );

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);

        // Act
        new EventUpdateExecutor().execute(event);

        // Assert
        Assert.areEqual(
            EventQueueStatusType.DELIVERED.name(),
            event.getStatus(),
            'O evento deve ser marcado como DELIVERED quando não possui handler.'
        );

        Assert.isTrue( ((AbstractOutboundCommandTest.SuccessOutboundCommandMock) command).executeUpdateExecuted 
                    , 'Deve ter executado o método executeUpdate' );

    }    

    @isTest
    static void shouldExecuteEventWithDmlExceptionErrorAndDisableRetry () {

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.ExecuteUpdateDmlExceptionOutboundCommandMock ( requestPayload
                                                                                                    , expectedResponse );        

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);

        Test.startTest();
        
        new EventUpdateExecutor().execute(event);
        
        Test.stopTest();

        Assert.areEqual( EventQueueStatusType.ERROR.name(), event.getStatus());
        Assert.areEqual( 0, event.getRetryCount());

    }  

    @isTest
    static void shouldDisableRetryWhenExecuteEventWithIntegrationBusinessException () {

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.ExecuteUpdateOutboundCommandWithExceptionMock ( requestPayload
                                                                                                    , expectedResponse
                                                                                                    , new IntegrationBusinessException ('Unable to process') );        

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);

        Test.startTest();
        
        new EventUpdateExecutor().execute(event);
        
        Test.stopTest();

        Assert.areEqual( EventQueueStatusType.ERROR.name(), event.getStatus());
        Assert.areEqual( 0, event.getRetryCount());

    }  

    @isTest
    static void shouldDecreaseRetryWhenExecuteEventWithException () {

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.ExecuteUpdateOutboundCommandWithExceptionMock ( requestPayload
                                                                                                    , expectedResponse
                                                                                                    , new UnhandledException ('Unable to process') );        

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);

        Test.startTest();
        
        new EventUpdateExecutor().execute(event);
        
        Test.stopTest();

        Assert.areEqual( EventQueueStatusType.ERROR.name(), event.getStatus());
        Assert.areEqual( 9, event.getRetryCount());

    }  

    public class UnhandledException extends Exception {}


}