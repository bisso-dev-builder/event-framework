@isTest
public class EventQueueTest {

    @isTest
    static void shouldInitializeEventQueueWithConfig() {
        // Given
        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.createEventQueue ('TestEvent', 'UNHANDLED');
        EventQueueRepository mockRepository = new EventQueueRepository();
        EventConfiguration mockConfig = new EventConfiguration();

        // When
        EventQueue eventQueue = new EventQueue(eventQueueRecord, mockConfig, mockRepository);

        // Then
        System.assertEquals('TestEvent', eventQueue.getSObject().EventName__c);
        System.assertEquals('UNHANDLED', eventQueue.getStatus());
        System.assertEquals(eventQueueRecord.ExternalId__c, eventQueue.getExternalId());
        System.assertEquals(eventQueueRecord.SalesforceObjectId__c, eventQueue.getObjectId());

        Assert.isFalse( eventQueue.useCustomOAuthFlow() );
        
        Assert.isFalse( eventQueue.hasError() );

        Assert.isTrue( eventQueue.isUnhandled() );

        Assert.isFalse( eventQueue.hasHandler() );

        Assert.isNull( eventQueue.getOutboundConfig() );
       
        Assert.isNull( eventQueue.getCommand() , 'Não há handler configurado para esse evento');
                

    }

    @isTest
    public static void shouldInitializeEventByNameWithEmptyConfig () {
        
        EventQueue event = new EventQueue('TestEvent');

        Assert.isNull(event.getConfig());
        
    }

    @isTest
    static void shouldReturnOAuthEvent() {

        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.newEventQueue ('TestEvent', 'UNHANDLED');
                
        EventQueue eventQueue = new EventQueue(eventQueueRecord, 
             EventConfigurationFixtureFactory.newEventConfiguration('TestEvent')
            , new EventQueueRepositoryTest.EventQueueRepositoryConfigMock() );

        EventQueue oauthEvent = eventQueue.getOAuthEvent();

        Assert.isNotNull( oauthEvent , 'É esperado um evento de autenticação' );

    }

     
    @isTest
    static void shouldMarkEventQueueAsDelivered() {
        // Given
        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.newEventQueue('TestEvent', 'UNHANDLED');
        EventQueue eventQueue = new EventQueue(eventQueueRecord);

        // When
        eventQueue.delivered();

        // Then
        System.assertEquals('DELIVERED', eventQueue.getStatus());
        System.assertEquals('', eventQueue.getSObject().DetailedStatus__c);
    }

    @isTest
    static void shouldHandleErrorCorrectly() {
        // Given
        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.newEventQueue('TestEvent', 'UNHANDLED');
        EventQueue eventQueue = new EventQueue(eventQueueRecord);
        IntegrationBusinessException testException = new IntegrationBusinessException('Code','Test Exception');

        // When
        eventQueue.withError(testException);

        // Then
        System.assertEquals('ERROR', eventQueue.getStatus());
        System.assert(eventQueue.getSObject().DetailedStatus__c.contains('Test Exception'));
    }

    @isTest
    static void shouldDecreaseRetryCount() {
        // Given
        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.newEventQueue('TestEvent');
        EventQueue eventQueue = new EventQueue(eventQueueRecord);

        // When
        eventQueue.decreaseRetry();

        // Then
        System.assertEquals(9, eventQueue.getSObject().RetryCount__c);
    }

    @isTest
    static void shouldDisableRetry() {
        // Given
        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.newEventQueue('TestEvent');
        EventQueue eventQueue = new EventQueue(eventQueueRecord);

        // When
        eventQueue.disableRetry();

        // Then
        System.assertEquals(0, eventQueue.getSObject().RetryCount__c);
        System.assertEquals(true, eventQueue.getSObject().IsRetryDisabled__c);
    }

    @isTest
    static void shouldSaveEventQueue() {
        // Given
        EventQueue__c eventQueueRecord = EventQueueFixtureFactory.newEventQueue('TestEvent', 'UNHANDLED');
        EventQueue event = new EventQueue(eventQueueRecord, null, new EventQueueRepository());

        // When
        event.delivered().save();
        
        // Then
        EventQueue__c savedEventQueue = [SELECT Id, EventName__c, Status__c FROM EventQueue__c WHERE Id = :event.getId()];
        System.assertEquals('TestEvent', savedEventQueue.EventName__c);
        System.assertEquals( EventQueueStatusType.DELIVERED.name() , savedEventQueue.Status__c);
    }
}