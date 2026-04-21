@isTest
public class SchedulerTest {

    @isTest
    static void shouldReturnServiceNameFromSchedulable() {
        // Given
        MockSchedulable mock = new MockSchedulable();

        // When
        String name = Scheduler.getServiceName(mock);

        // Then
        Assert.areEqual('MockSchedulable', name);
    }

    @isTest
    static void shouldScheduleAtSpecificHour() {
        // When
        Test.startTest();
        Scheduler.scheduleAtHour(new MockSchedulable(), 3);

        // Then
        List<CronTrigger> jobs = [
            SELECT Id, CronExpression
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE 'MockSchedulable%'
        ];
        Assert.isFalse(jobs.isEmpty(), 'Expected a scheduled job');
        Assert.isTrue(jobs[0].CronExpression.startsWith('0 0 3'), 'Expected cron to start at hour 3');

        Test.stopTest();
    }

    @isTest
    static void shouldScheduleIntoNextMinutes() {
        // Given
        Integer minutes = 5;
        Datetime expectedTime = System.now().addMinutes(minutes);

        // When
        Test.startTest();
        Scheduler.scheduleIntoNextMinutes(new MockSchedulable(), minutes);

        // Then
        List<CronTrigger> jobs = [
            SELECT Id, CronExpression
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE 'MockSchedulable%'
        ];
        Assert.isFalse(jobs.isEmpty(), 'Expected a scheduled job');
        Assert.isTrue(
            jobs[0].CronExpression.contains(String.valueOf(expectedTime.minute())),
            'Cron expression should contain the expected minute'
        );

        Test.stopTest();
    }

    @isTest
    public static void shouldAbortJob () {
        
        String cronExpr = '0 0 12 * * ? 2063';

        String jobId = System.schedule( 'SchedulerTest.AbortableScheduleJob()'
                    , cronExpr
                    , new SchedulerTest.AbortableScheduleJob() );
        

        Scheduler.abort(jobId);
    
    }

    @isTest
    static void shouldScheduleWithCustomCronExpression() {
        // Given
        String cronExpr = '0 0 12 * * ?';

        // When
        Test.startTest();
        Scheduler.schedule(new MockSchedulable(), cronExpr);

        // Then
        List<CronTrigger> jobs = [
            SELECT Id, CronExpression
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE 'MockSchedulable%'
        ];
        Assert.isFalse(jobs.isEmpty(), 'Expected a scheduled job');
        Assert.areEqual(cronExpr, jobs[0].CronExpression);

        Test.stopTest();
    }

    public class MockSchedulable implements Schedulable {
        public void execute(SchedulableContext ctx) {}
    }


    public class AbortableScheduleJob implements Schedulable {

        public AbortableScheduleJob () {
            System.debug('AbortableScheduleJob created....');
        }

        public void execute(SchedulableContext context) {
            System.debug('Executed....');
            Scheduler.abort(context);
        }
    }

    private static List<CronTrigger> findByName (String name) {
         return [
            SELECT Id, CronExpression
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE :name
        ];
    }

    
}
