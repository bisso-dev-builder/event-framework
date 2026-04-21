@isTest
public class EnqueueEventsJobTest {

    @isTest
    static void shouldEnqueuePendingEventsWhenJobExecutes() {
        // Given
        EventQueueFixtureFactory.createEventQueue('PendingEvent', EventQueueStatusType.SCHEDULED.name());
        Scheduler.jobCountForTest = 1;

        // When
        Test.startTest();
        Scheduler.scheduleIntoNextMinutes(new EnqueueEventsJob(new EnqueuePendingEventsStrategy()), 1);
        Test.stopTest();

        // Then
        EventQueue__c updated = [SELECT Status__c FROM EventQueue__c LIMIT 1];
        Assert.areEqual(EventQueueStatusType.QUEUED.name(), updated.Status__c, 'Event should be QUEUED after job execution');
    }

    @isTest
    static void shouldEnqueueRetryableEventsWhenJobExecutes() {
        // Given
        EventQueue__c errorEvent = EventQueueFixtureFactory.newEventQueue('RetryEvent', EventQueueStatusType.ERROR.name());
        errorEvent.RetryCount__c = 3;
        EventQueueFixtureFactory.save(errorEvent);
        Scheduler.jobCountForTest = 1;

        // When
        Test.startTest();
        Scheduler.scheduleIntoNextMinutes(new EnqueueEventsJob(new EnqueueRetryableEventsStrategy()), 1);
        Test.stopTest();

        // Then
        EventQueue__c updated = [SELECT Status__c FROM EventQueue__c LIMIT 1];
        Assert.areEqual(EventQueueStatusType.QUEUED.name(), updated.Status__c, 'Retryable event should be QUEUED after job execution');
    }

    @isTest
    static void shouldRescheduleItselfAfterExecution() {
        // Given
        Scheduler.jobCountForTest = 1;

        // When
        Test.startTest();
        Scheduler.scheduleIntoNextMinutes(new EnqueueEventsJob(new EnqueuePendingEventsStrategy()), 1);
        Test.stopTest();

        // Then - a new job should have been scheduled by the rescheduling logic
        List<CronTrigger> jobs = [
            SELECT Id
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE 'EnqueueEventsJob%'
        ];
        Assert.isFalse(jobs.isEmpty(), 'Job should reschedule itself after execution');
    }


    @isTest
    static void shouldScheduleJob() {

        Scheduler.jobCountForTest = 10;

        Test.startTest();

        EnqueueEventsJob.start( new EnqueuePendingEventsStrategy() );        
        
        Test.stopTest();

        List<CronTrigger> jobs = [
            SELECT Id
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE 'EnqueueEventsJob%'
        ];

        
        Assert.isFalse(jobs.isEmpty(), 'Job should reschedule itself after execution');
    }


}
