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


    public class EventQueueRepositoryConfigMock extends EventQueueRepository {

        override
        public List<EventConfiguration> findConfigByNames (List<String> names) {

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