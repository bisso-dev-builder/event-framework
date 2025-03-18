public class EventQueueFilter extends Filter {

    public List<EventQueue__c> byQueued (List<EventQueue__c> events) {
        return byStatus(events, EventQueueStatusType.QUEUED.name());
    }

    public List<EventQueue__c> byStatus (List<EventQueue__c> events, String status) {
        return byValue(events, 'Status__c', status);
    }

}