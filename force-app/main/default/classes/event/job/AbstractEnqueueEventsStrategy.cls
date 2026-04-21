public inherited sharing abstract class AbstractEnqueueEventsStrategy {

    private EventQueueRepository repository;

    public AbstractEnqueueEventsStrategy() {
        repository = new EventQueueRepository();
    }

    public void enqueue () {

        List<EventQueue__c> events = findEvents();

        for (EventQueue__c event : events) {
            event.Status__c = EventQueueStatusType.QUEUED.name();
        }

        repository.save(events);

    }

    public abstract List<EventQueue__c> findEvents ();

    public abstract Integer getJobInterval ();

    public EventQueueRepository getRepository () {
        return repository;
    }

}