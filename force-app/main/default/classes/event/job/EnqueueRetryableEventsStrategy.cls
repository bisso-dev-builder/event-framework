public inherited sharing class EnqueueRetryableEventsStrategy extends AbstractEnqueueEventsStrategy {
   
    override
    public List<EventQueue__c> findEvents () {

        return getRepository().findByPendingRetry ( EventExecutorLimits.REPROCESS_CHUCK_SIZE );

    }
        
    override
    public Integer getJobInterval () {
        return 8;
    }


}