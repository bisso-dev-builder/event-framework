public virtual class EventExecutor extends AbstractEventExecutor {

    //4 Inject Mock
    @TestVisible
    static EventExecutor executor;

    static {
        executor = new EventExecutor();
    }

    @future(callout=true)
    public static void execute (List<String> eventIds) {
        executor.initializeEvents(eventIds).execute();
    }

    EventConfigurationFilter configFilter;
    
    public EventExecutor() {

        super ( new List<AbstractEventExecutor> {
                            new EventCalloutExecutor()
                            , new EventUpdateExecutor() }
        );
        
        this.configFilter = new EventConfigurationFilter();

    }

    public EventExecutor(List<String> eventIds) {
        this();
        this.events = findEvents(eventIds);
    }

    public EventExecutor(List<EventQueue> events) {
        this();
        this.events = events;
    }

    public EventExecutor initializeEvents(List<String> eventIds) {
        this.events = findEvents(eventIds);
        return this;
    }

    protected List<EventQueue> findEvents (List<String> eventIds) {

        List<EventQueue__c> queues = repository.findByIds(eventIds);

        Map<String, EventConfiguration> configs = configFilter.indexByName ( repository.findConfigByNames ( 
                                                                                    Lists.pullField ( queues, 'EventName__c' )
                                                                            ));
        List<EventQueue> events = new List<EventQueue>();

        for (EventQueue__c queue : queues ) {

            events.add ( new EventQueue ( queue
                                        , configs.get(queue.EventName__c)
                                        , this.repository ) );
        }

        return events;

    }    

}