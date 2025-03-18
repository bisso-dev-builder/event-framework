public abstract class AbstractEventExecutor {
    
    protected EventQueueRepository repository;

    protected List<EventQueue> events;

    List<AbstractEventExecutor> executors;

    public AbstractEventExecutor() {
    }

    public AbstractEventExecutor (List<AbstractEventExecutor> executors) {
        this.repository = new EventQueueRepository();

        this.executors = executors;
    }


    public void execute () {

        for (AbstractEventExecutor executor : executors ) {
            executor.execute(events);
        }
                
        repository.save( new EventQueueBuilder().convertToQueueEvents (events) );

    }

    public void execute (List<EventQueue> events) {
        
        for (EventQueue event : events) {
            execute(event);
        }

    }

    virtual
    public void execute (EventQueue event) {
    }

    virtual
    public void execute (Command command, EventQueue event) {
    }

    public void setRepository (EventQueueRepository repository) {
        this.repository = repository;
    }

}