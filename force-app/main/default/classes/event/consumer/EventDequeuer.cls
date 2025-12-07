public virtual class EventDequeuer {
    
    public static Integer executedFutureCalls = 0;

    public void dequeue (List<EventQueue__c> events) {

        if (events.isEmpty()) return;

        List<String> eventIds = new List<String>();

        Integer i = 0;

        for (EventQueue__c event : events) {
    
            if (executedFutureCalls == EventExecutorLimits.FUTURE_CALL_LIMIT) break;
            
            if (i == EventExecutorLimits.FUTURE_CALL_SIZE) {      
                processEvents(eventIds);
                eventIds = new List<String>();
                i = 0;
                executedFutureCalls ++;
            }
            
            eventIds.add (event.Id);
            i++;
        }

        if (executedFutureCalls >= EventExecutorLimits.FUTURE_CALL_LIMIT) {
            return;
        }
        
        if (!eventIds.isEmpty()) {
            processEvents(eventIds);
            executedFutureCalls ++;
        }

    }

    virtual
    public void processEvents (List<String> eventIds) {
        EventExecutor.execute(eventIds);
    }

}