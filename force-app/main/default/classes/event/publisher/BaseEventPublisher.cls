public virtual class BaseEventPublisher {

    EventQueueRepository repository;

    public BaseEventPublisher() {
        repository = new EventQueueRepository();
    }

    //4 test injection
    public BaseEventPublisher(EventQueueRepository repository) {
        this.repository = repository;
    }    

    public List<EventQueue__c> publish ( String eventName, List<SObject> records ) {
        List<EventQueue__c> events = new List<EventQueue__c>();

        for (SObject record : records ) {
            events.add( buildEvent( eventName, record));
        }

        return repository.save(events);

    }

    virtual
    public EventQueue__c buildEvent (String eventName, SObject record) {        

        return new EventQueue__c ( EventName__c = eventName
            , Status__c = EventQueueStatusType.QUEUED.name() 
            , SalesforceObjectId__c = record.Id
        );

    }

}