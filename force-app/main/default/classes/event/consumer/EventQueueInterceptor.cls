public class EventQueueInterceptor {

    public static Integer totalOfRecordsInFutureCall = EventExecutorLimits.FUTURE_CALL_LIMIT * EventExecutorLimits.FUTURE_CALL_SIZE;

    public EventQueueInterceptor onBatchOrFutureAutoScheduleEvents (List<EventQueue__c> events) {

        if (!System.isBatch() && !System.isFuture()) {
            return this;
        }

        applyStatusOnEvents (events, EventQueueStatusType.SCHEDULED.name());

        return this;

    }

    public EventQueueInterceptor onFutureLimitClosedAutoScheduleEvents (List<EventQueue__c> events) {
                   
        if (Lists.isEmpty(events)) return this;                       

        if ( EventExecutorLimits.TOTAL_RECORDS_IN_FUTURE >= events.size() 
             && EventDequeuer.executedFutureCalls <= EventExecutorLimits.FUTURE_CALL_LIMIT ) {
            
            return this;
        }

        if ( EventDequeuer.executedFutureCalls >= EventExecutorLimits.FUTURE_CALL_LIMIT) {
            totalOfRecordsInFutureCall = 0;
        }
        
        for (Integer i = totalOfRecordsInFutureCall; i < events.size(); i++) {
            events.get(i).Status__c = EventQueueStatusType.SCHEDULED.name();            
        }

        return this;

    }


    private void applyStatusOnEvents (List<EventQueue__c> events, String status) {

        for (EventQueue__c event : events) {
            event.Status__c = status;
        }

    }

}