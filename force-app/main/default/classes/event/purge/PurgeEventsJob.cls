public class PurgeEventsJob implements Schedulable {

    private Integer keepEventInPeriodDays = 120;
    private List<String> eventsToKill;

    public PurgeEventsJob () {
        keepEventInPeriodDays = 120;
        eventsToKill = new List<String>();
    }

    public PurgeEventsJob (Integer keepEventInPeriodDays) {
        this();
        this.keepEventInPeriodDays = keepEventInPeriodDays;
    }

    public PurgeEventsJob (Integer keepEventInPeriodDays, List<String> eventsToKill) {
        this(keepEventInPeriodDays);
        this.eventsToKill = eventsToKill;
    }

    public void execute(SchedulableContext context) {

        Datetime dateTimeValue = buildDateTime ();

        Database.executeBatch( new PurgeEventQueuesBatch(dateTimeValue, eventsToKill) , 200 );
        
    }

    private Datetime buildDateTime () {
        
        Datetime today = Datetime.newInstance( Date.today() , Time.newInstance(0, 0, 0, 0) );

        return today.addDays( (this.keepEventInPeriodDays * -1) );

    }

    public static void start ()  {
        Scheduler.scheduleAtHour( new PurgeEventsJob(), 1);
    }

}