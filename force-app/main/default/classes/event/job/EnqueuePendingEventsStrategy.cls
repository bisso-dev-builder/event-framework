public inherited sharing class EnqueuePendingEventsStrategy extends AbstractEnqueueEventsStrategy {
   
    private static final List<String> PENDING_EVENT_STATUS = new List<String> { EventQueueStatusType.SCHEDULED.name() };

    override
    public List<EventQueue__c> findEvents () {

        return getRepository().findByStatus ( PENDING_EVENT_STATUS
                                            , EventExecutorLimits.REPROCESS_CHUCK_SIZE );

    }
        
    override
    public Integer getJobInterval () {
        return 5;
    }

}