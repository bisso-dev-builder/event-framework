/**
 * new EventQueueBuilder().
 * 
 * @author eduardo.bisso - dev-builder
 */
public class EventQueueBuilder {

    EventQueue event;

    EventQueueRepository repository;

    public EventQueueBuilder() {        
        this.repository = new EventQueueRepository();
        this.event = new EventQueue();
    }
}