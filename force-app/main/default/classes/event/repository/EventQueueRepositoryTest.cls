@isTest
public class EventQueueRepositoryTest {
    @isTest
    static void shouldFindEventQueueById() {
        // Given
        EventQueue__c expectedEvent = EventQueueFixtureFactory.createEventQueue('TestEvent');

        // When
        EventQueue__c actualEvent = new EventQueueRepository().findById(expectedEvent.Id);

        // Then
        System.assertNotEquals(null, actualEvent, 'EventQueue should not be null');
        System.assertEquals(expectedEvent.Id, actualEvent.Id, 'EventQueue Id should match');
    }

    @isTest
    static void shouldFindEventQueueByIds() {
        // Given
        EventQueue__c event1 = EventQueueFixtureFactory.createEventQueue('Event1');
        EventQueue__c event2 = EventQueueFixtureFactory.createEventQueue('Event2');

        // When
        EventQueueRepository repository = new EventQueueRepository();
        List<EventQueue__c> events = repository.findByIds(new List<String>{event1.Id, event2.Id});

        // Then
        System.assertEquals(2, events.size(), 'Should return 2 events');
    }

    @isTest
    public static void shouldFindEventsToPurgeByDate () {

        EventQueue__c expectedEvent = EventQueueFixtureFactory.createEventQueue('TestEvent');
        
        EventQueue__c todayEvent = EventQueueFixtureFactory.createEventQueue('TestEvent01');

        Test.setCreatedDate(expectedEvent.Id, Datetime.now().addDays(-2));

        EventQueueRepository repository = new EventQueueRepository();

        Datetime tmpVar1 = Datetime.newInstance( Date.today(), Time.newInstance(0, 0, 0, 0) );

        Database.QueryLocator queryLocator = repository.findByLessThanDate(tmpVar1);

        String query = queryLocator.getQuery();

        List<EventQueue__c> events = Database.query(query);

        Assert.areEqual(1, events.size(), 'Expected one record');

        Assert.areEqual(expectedEvent.Id , events.get(0).Id);     

    }

    @isTest
    public static void shouldFindEventsByStatus () {
        
        EventQueue__c expectedEvent = EventQueueFixtureFactory.createEventQueue('CREATE_ORDER', EventQueueStatusType.SCHEDULED.name());

        EventQueueRepository repository = new EventQueueRepository();

        List<EventQueue__c> events = repository.findByStatus ( new List<String> {EventQueueStatusType.SCHEDULED.name()}, 2);

        Assert.areEqual(1, events.size());

        Assert.areEqual(expectedEvent.Id, events.get(0).Id);
        Assert.areEqual( EventQueueStatusType.SCHEDULED.name(), events.get(0).Status__c);
        
    }

    @isTest
    public static void shouldFindEventsToPurgeByDateAndEventName () {

        List<EventQueue__c> expectedEvents = EventQueueFixtureFactory.createEventQueues(2);
        
        Test.setCreatedDate(expectedEvents.get(0).Id, Datetime.now().addDays(-2));

        String eventName = expectedEvents.get(0).EventName__c;

        EventQueueRepository repository = new EventQueueRepository();

        // --- tmpVar is needed to QueryLocator dynamic Query

        Datetime tmpVar1 = Datetime.newInstance( Date.today(), Time.newInstance(0, 0, 0, 0) );

        List<String> tmpVar2 = new List<String> {eventName};

        Database.QueryLocator queryLocator = repository.findByLessThanDateAndEventType( tmpVar1, tmpVar2 );

        String query = queryLocator.getQuery();

        List<EventQueue__c> events = Database.query(query);

        Assert.areEqual(1, events.size(), 'Expected one record');

        Assert.areEqual(expectedEvents.get(0).Id , events.get(0).Id);

    }


    @isTest
    public static void shouldSaveWithExternalId () {

        EventQueue__c event = EventQueueFixtureFactory.newEventQueue('Event1');
        event.ExternalId__c = StringGenerator.text(10);

        EventQueueRepository repository = new EventQueueRepository();
        
        repository.save(event, EventQueue__c.ExternalId__c.getDescribe().getSObjectField() );

        Assert.isNotNull(event.Id, 'Expected Event Creation');

    }


    @isTest
    public static void shouldFindAllEventsPendingRetry () {

        EventQueue__c expectedEvent = EventQueueFixtureFactory.newEventQueue('CREATE_ORDER', EventQueueStatusType.ERROR.name());
        expectedEvent.RetryCount__c = 3;
        EventQueueFixtureFactory.save (expectedEvent);

        EventQueueRepository repository = new EventQueueRepository();

        List<EventQueue__c> events = repository.findByPendingRetry(2);

        Assert.areEqual(1, events.size());

        Assert.areEqual(expectedEvent.Id, events.get(0).Id);
        Assert.areEqual( EventQueueStatusType.ERROR.name(), events.get(0).Status__c);
        
    }

    public class EventQueueRepositoryConfigMock extends EventQueueRepository {

        List<EventConfiguration> configs;
        
        public EventQueueRepositoryConfigMock () {
            configs = new List<EventConfiguration> ();
        } 

        public EventQueueRepositoryConfigMock (List<EventConfiguration> configs) {
            this.configs = configs;
        } 
        
        override
        public List<EventConfiguration> findConfigByNames (List<String> names) {

            if (!Lists.isEmpty(configs) )  { return configs; }

            return EventConfigurationFixtureFactory.newEventConfigurations(names);

        }

        override
        public EventConfiguration findConfigByName (String name) {
            return findConfigByNames (new List<String> {name}).get(0);
        }

    }


    public virtual class EventQueueRepositoryMock extends EventQueueRepository {


        virtual
        override
        public List<Database.UpsertResult> uppsert ( List<SObject> aggregates ) {
            
            IdGenerator.generate(aggregates);     

            return generateUpsertResult(aggregates);
           
        }
        
        virtual
        override
        public List<Database.UpsertResult> uppsert ( List<SObject> aggregates
                                                        , Schema.SObjectField field ) {
            
            IdGenerator.generate(aggregates);     
                 
            return generateUpsertResult(aggregates);
           
        }

        virtual    
        protected List<Database.UpsertResult> generateUpsertResult (List<SObject> aggregates) {
            
            List<Map<String,Object>> results = new List<Map<String,Object>>(); 

            for ( SObject aggregate : aggregates ) {

                results.add ( new Map<String,Object> { 
                    'id' => aggregate.Id,
                    'success' => true,
                    'created' => true,
                    'errors' => new List<Database.Error>()
                 });
            }

            return ( List<Database.UpsertResult> ) JSON.deserialize ( JSON.serialize(results) , List<Database.UpsertResult>.class )  ;

        }


    }
 
}