public class Scheduler {
    
    public static Integer jobCountForTest = 0;

    public static void scheduleIntoNextMinutes ( Schedulable service, Integer minutes ) {

        String templateExpression = '0 {0} {1} * * ?';

        Datetime nextScheduleTime = System.now().addMinutes(minutes);

        String cron = String.format(templateExpression, new List<String> { nextScheduleTime.minute().toString() 
                                                                        , nextScheduleTime.hour().toString() });        

        schedule ( service, cron );

    }  
    
   
    public static void scheduleAtHour ( Schedulable service, Integer hour ) {

        String templateExpression = '0 0 {0} * * ?';

        String cron = String.format(templateExpression, new List<String> { hour.toString() });

        schedule(service, cron);
        
    }


    public static void schedule ( Schedulable service, String cronExpression ) {
        System.schedule( buildJobName ( service, cronExpression) 
                                        , cronExpression 
                                        , service );
    }

    public static void abort (SchedulableContext context) {

        if (context == null) return;

        abort(context.getTriggerId());
    }

    public static void abort (String jobId) {
        System.abortJob(jobId);
    }

    private static String buildJobName ( Schedulable service, String cronExpression ) {
        return getServiceName (service) + ' ' + jobCountForTest + ' ' + cronExpression;
    }

    @TestVisible
    private static String getServiceName( Schedulable service ) {
        return String.valueOf(service).substring(0, String.valueOf(service).indexOf(':'));
    }


}