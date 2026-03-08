public abstract class AbstractEventExecutor {
    
    protected EventQueueRepository repository;

    @TestVisible
    protected List<EventQueue> events;

    List<AbstractEventExecutor> executors;

    @SupperssWarnings('PMD')
    public AbstractEventExecutor() {
        this.repository = new EventQueueRepository();
    }

    public AbstractEventExecutor (List<AbstractEventExecutor> executors) {
        this();        
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

    @SupperssWarnings('PMD')
    virtual
    public void execute (EventQueue event) {
    }

    @SupperssWarnings('PMD')
    virtual
    public void execute (Command command, EventQueue event) {
    }

    public void setRepository (EventQueueRepository repository) {
        this.repository = repository;
    }

}