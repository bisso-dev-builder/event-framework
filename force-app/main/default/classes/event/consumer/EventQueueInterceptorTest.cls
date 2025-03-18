@isTest
public class EventQueueInterceptorTest {

    @isTest
    static void shouldNotChangeStatusWhenNotInBatchOrFutureContext() {
                
        List<EventQueue__c> events = EventQueueFixtureFactory.newEventQueues(3);

        new EventQueueInterceptor().onBatchOrFutureAutoScheduleEvents(events);

        for (EventQueue__c event : events) {
            Assert.areEqual( EventQueueStatusType.QUEUED.name()
                            , event.Status__c
                            , 'Status should remain unchanged when not in Batch or Future context');
        }

    }

    @isTest
    static void shouldChangeToScheduleEnqueuedEventsCloseLimits () {
        
        EventDequeuer.executedFutureCalls = 40;

        List<EventQueue__c> events = EventQueueFixtureFactory.newEventQueues(300);

        new EventQueueInterceptor().onFutureLimitClosedAutoScheduleEvents(events);

        Filter filter = new Filter();
        
        List<EventQueue__c> queuedEvents = filter.byValue(events, 'Status__c', EventQueueStatusType.QUEUED.name());

        List<EventQueue__c> scheduledEvents = filter.byValue(events, 'Status__c', EventQueueStatusType.SCHEDULED.name());
        
        Assert.areEqual(75, scheduledEvents.size());

        Assert.areEqual(225, queuedEvents.size());

    }

}