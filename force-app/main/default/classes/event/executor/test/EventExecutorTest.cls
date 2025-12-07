@isTest
public class EventExecutorTest {


    @isTest
    static void shouldExecuteEventWithRetryableError () {

        EventExecutor.executor.setRepository ( new EventQueueRepositoryTest.EventQueueRepositoryConfigMock() );

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.CalloutExceptionOutboundCommandMock ( requestPayload, expectedResponse);        

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);

        Test.startTest();
        
        new EventExecutor(new List<EventQueue> {event}).execute();
        
        Test.stopTest();

        Assert.areEqual( EventQueueStatusType.ERROR.name(), event.getStatus());
        Assert.areEqual( 9, event.getRetryCount());

    }        


    @isTest
    static void shouldExecuteEventWithBusinessError () {

        EventExecutor.executor.setRepository ( new EventQueueRepositoryTest.EventQueueRepositoryConfigMock() );

        AbstractOutboundCommandTest.GetAddressResponse expectedResponse = AbstractOutboundCommandTest.newDefaultAddressResponse();

        String requestPayload =  JSON.serialize(AbstractOutboundCommandTest.expectedRequestPayload);

        Command command = new AbstractOutboundCommandTest.CalloutExceptionOutboundCommandMock ( requestPayload, expectedResponse, new IntegrationBusinessException ('O Cep informado não existe'));

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', command);

        Test.startTest();
        
        new EventExecutor(new List<EventQueue> {event}).execute();
        
        Test.stopTest();

        Assert.areEqual( EventQueueStatusType.ERROR.name(), event.getStatus());
        Assert.areEqual( 0, event.getRetryCount());

    }        



    @isTest
    static void shouldExecuteEventsSuccessfully() {
        
        EventExecutor.executor.setRepository ( new EventQueueRepositoryTest.EventQueueRepositoryConfigMock() );
        
        String eventName = 'TestEvent';
        
        EventQueue__c eventQueue = EventQueueFixtureFactory.createEventQueue(eventName);

        List<String> eventIds = new List<String>{eventQueue.Id};

        // Act
        Test.startTest();

        EventExecutor.execute(eventIds);

        Test.stopTest();

        // Assert
        List<EventQueue__c> updatedQueues = [SELECT Id, Status__c FROM EventQueue__c WHERE Id = :eventQueue.Id];
        
        System.assertEquals(1, updatedQueues.size(), 'The event queue should be updated.');

        System.assertEquals(EventQueueStatusType.DELIVERED.name()
                            , updatedQueues[0]
                            . Status__c, 'The event queue status should be updated to "DELIVERED".');
    }

    @isTest
    static void shouldHandleEmptyEventIds() {
        // Arrange
        List<String> eventIds = new List<String>();

        // Act
        Test.startTest();
        EventExecutor.execute(eventIds);
        Test.stopTest();

        // Assert
        // No exception should be thrown, and no processing should occur.
        System.assert(true, 'Execution should complete without errors.');
    }

    @isTest
    public static void shouldFindEventByListOfIds () {
        
        EventQueue__c event = EventQueueFixtureFactory.createEventQueue('Test');

        EventExecutor executor = new EventExecutor(new List<String> {event.Id});

        Assert.areEqual( 1 , executor.events.size() );

    }

}