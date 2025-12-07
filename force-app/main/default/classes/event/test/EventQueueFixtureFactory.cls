@isTest
public class EventQueueFixtureFactory {

    public static EventConfiguration newBaseConfig (String eventName) {
        return EventConfigurationFixtureFactory.newEventConfiguration(eventName);
    }

    public static EventQueue__c newEventQueue (String name) {
        return new EventQueue__c(
            EventName__c = name,
            Status__c = EventQueueStatusType.QUEUED.name(),
            RetryCount__c = 10,
            ExternalId__c = StringGenerator.text(10),
            SalesforceObjectId__c = IdGenerator.generate ( new Order() ).Id            
        );
    }

    public static EventQueue__c newEventQueue (String name, String status) {
        
        EventQueue__c event = newEventQueue(name);
        event.Status__c = status;

        return event;
    }
    
    public static List<EventQueue__c> newEventQueues(Integer count) {

        List<EventQueue__c> events = new List<EventQueue__c>();
        for (Integer i = 0; i < count; i++) {
            events.add(newEventQueue('Event ' + i));
        }
        return events;
    }

    public static List<EventQueue__c> newEventQueues(List<String> statuses) {

        List<EventQueue__c> eventQueues = new List<EventQueue__c>();

        Integer i = 0;

        for (String status : statuses) {
            eventQueues.add(newEventQueue( 'Event ' + i, status));
            i++;
        }

        return eventQueues;
    }

    public static List<EventQueue__c> createEventQueues(Integer count) {
        return save ( newEventQueues(count) );
    }
    
    public static EventQueue__c createEventQueue (String eventName) {
        return save ( newEventQueue(eventName) );
    }

    public static EventQueue__c createEventQueue (String eventName, String status) {
        return save ( newEventQueue(eventName, status) );
    }

    public static EventQueue newEvent (String name, String commandClassName) {   

        EventConfiguration config = newBaseConfig(name)
                                        .commandClassName (commandClassName);

        return new EventQueue( newEventQueue(name) )
                    .withConfiguration( config );
    }

    public static EventQueue newEvent (String name, Command command) {   
        return new EventQueue( newEventQueue(name) )
                    .withConfiguration(newBaseConfig(name))
                    .withCommand(command);
    }

    public static EventQueue newEvent (String name) {   
        return new EventQueue( newEventQueue(name) )
                    .withConfiguration(newBaseConfig(name));
    }

    public static EventQueue newEventWithOutboundConfig (String name, String responseClasseName) {   
                return new EventQueue( newEventQueue(name) )
                    .withConfiguration( 
                        EventConfigurationFixtureFactory.newEventConfigurationForOutbound(name, responseClasseName)
                    );
    }    

    public static List<EventQueue> newEvents(Integer size) {
        
        List<EventQueue> eventQueues = new List<EventQueue>();
        
        for (Integer i = 0; i < size; i++) {
            eventQueues.add( newEvent ('Event ' + i));
        }

        return eventQueues;
    }

    public static List<EventQueue__c> save (List<EventQueue__c> events) {
        upsert events;
        return events;
    }

    public static EventQueue__c save (EventQueue__c event) {
        save(new List<EventQueue__c> {event});
        return event;
    }

}