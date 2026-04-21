public without sharing class PurgeEventQueuesBatch implements Database.Batchable<SObject> {
    
    String query;

    Datetime killEventsBeforeDate;
    
    List<String> eventsToKill;

    EventQueueRepository repository;

    ContentDocumentRepository contentRepository;

    public PurgeEventQueuesBatch () {
        eventsToKill = new List<String>();
        this.repository = new EventQueueRepository();
        this.contentRepository = new ContentDocumentRepository();
    }

    public PurgeEventQueuesBatch (Datetime killEventsBeforeDate) {
        this();
        this.killEventsBeforeDate = killEventsBeforeDate;
    }

    public PurgeEventQueuesBatch (Datetime killEventsBeforeDate, List<String> eventsToKill) {
        this(killEventsBeforeDate);
        this.eventsToKill = eventsToKill;
    }

    public Database.QueryLocator start(Database.BatchableContext context) {

        if (!eventsToKill.isEmpty()) {            
            return repository.findByLessThanDateAndEventType (killEventsBeforeDate, eventsToKill);
        }

        return repository.findByLessThanDate(killEventsBeforeDate);
    }
  
    public void execute(Database.BatchableContext context, List<EventQueue__c> scope){
        
        purgeContentDocuments (scope);
        
        removeAll (scope);

    }
  
    public void finish(Database.BatchableContext context){
    }


    private void purgeContentDocuments (List<EventQueue__c> events) {

        List<ContentVersion> versions = contentRepository.findFirstPublishLocationIds( Lists.toIds(events) );

        removeAll (versions);

    }

    private void removeAll ( List<SObject> records ) {

        if (records.isEmpty()) return;

        repository.remove (records);
        DataBase.emptyRecycleBin(records);
    }

}