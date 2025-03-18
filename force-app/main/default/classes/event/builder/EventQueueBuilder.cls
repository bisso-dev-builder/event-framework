/** 
 * @author eduardo.bisso - dev-builder
 */
public class EventQueueBuilder {

    public List<EventQueue__c> convertToQueueEvents (List<EventQueue> events) {

        List<EventQueue__c> queues = new List<EventQueue__c>();

        for (EventQueue event : events) {
            queues.add(event.getSObject());
        }

        return queues;

    }

}