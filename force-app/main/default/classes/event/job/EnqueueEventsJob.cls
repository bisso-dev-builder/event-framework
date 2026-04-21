public without sharing class EnqueueEventsJob implements Schedulable {
    
    AbstractEnqueueEventsStrategy strategy;

    public EnqueueEventsJob(AbstractEnqueueEventsStrategy strategy) {
        this.strategy = strategy; 
    }

    public void execute (SchedulableContext context) {

        abort( context );
        
        strategy.enqueue();

        reSchedule ();
    }


    private void abort (SchedulableContext context) {
        Scheduler.abort(context);
    }

    private void reSchedule () {
        Scheduler.scheduleIntoNextMinutes( this 
                                        , strategy.getJobInterval());
    }

    public static void start (AbstractEnqueueEventsStrategy strategy) {
        Scheduler.scheduleIntoNextMinutes( new EnqueueEventsJob(strategy) 
                                        , strategy.getJobInterval());
    }

}