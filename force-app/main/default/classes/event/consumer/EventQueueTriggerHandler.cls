public with sharing class EventQueueTriggerHandler extends TriggerHandler {

    List<EventQueue__c> newEvents;
    Map<Id, EventQueue__c> oldEvents;

    EventQueueFilter filter;

    EventQueueInterceptor interceptor;

    EventDequeuer consumer;

    public EventQueueTriggerHandler() {
        this ( (List<EventQueue__c>) Trigger.new
              , (Map<Id, EventQueue__c>) Trigger.oldMap );
    }


    public EventQueueTriggerHandler( List<EventQueue__c> newEvents
                                , Map<Id, EventQueue__c> oldEvents) {
        this.newEvents = newEvents;
        this.oldEvents = oldEvents;
        this.filter = new EventQueueFilter();
        this.interceptor = new EventQueueInterceptor();
        this.consumer = new EventDequeuer();
    }

    override
    public void beforeInsert() {
        autoScheduleEvents();
    }

    override
    public void beforeUpdate() {
        autoScheduleEvents();
    }

    override
    public void afterInsert() {
        dequeue();
    }

    override
    public void afterUpdate() {
        dequeue();
    }

    //rethink name
    private void autoScheduleEvents () {

        List<EventQueue__c> queuedEvents = filter.byQueued(newEvents);

        if (queuedEvents.isEmpty()) { return; }

        this.interceptor
            .onBatchOrFutureAutoScheduleEvents(queuedEvents)
            .onFutureLimitClosedAutoScheduleEvents( queuedEvents );
    }

    private void dequeue() {

        List<EventQueue__c> queuedEvents = filter.byQueued(newEvents);

        if (queuedEvents.isEmpty()) { return; }

        this.consumer.dequeue(queuedEvents);        
    }

}