@isTest
public class PurgeEventsJobTest {

    @isTest
    static void shouldPurgeEventsOlderThanDefaultRetentionPeriod() {
        // Given - default is 120 days; create event older than that
        EventQueue__c oldEvent = EventQueueFixtureFactory.createEventQueue('OldEvent');
        Test.setCreatedDate(oldEvent.Id, Datetime.now().addDays(-121));

        // When
        Test.startTest();
        new PurgeEventsJob().execute(null);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id FROM EventQueue__c];
        Assert.areEqual(0, remaining.size(), 'Events older than 120 days should be purged');
    }

    @isTest
    static void shouldNotPurgeEventsWithinDefaultRetentionPeriod() {
        // Given
        EventQueue__c recentEvent = EventQueueFixtureFactory.createEventQueue('RecentEvent');
        Test.setCreatedDate(recentEvent.Id, Datetime.now().addDays(-30));

        // When
        Test.startTest();
        new PurgeEventsJob().execute(null);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id FROM EventQueue__c];
        Assert.areEqual(1, remaining.size(), 'Events within retention period should not be purged');
    }

    @isTest
    static void shouldRespectCustomRetentionDays() {
        // Given
        EventQueue__c event = EventQueueFixtureFactory.createEventQueue('Event');
        Test.setCreatedDate(event.Id, Datetime.now().addDays(-10));

        // When - keep only 5 days, so 10-day-old event should be purged
        Test.startTest();
        new PurgeEventsJob(5).execute(null);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id FROM EventQueue__c];
        Assert.areEqual(0, remaining.size(), 'Events outside custom retention window should be purged');
    }

    @isTest
    static void shouldPurgeOnlyMatchingEventTypesWhenFiltered() {
        // Given
        EventQueue__c eventA = EventQueueFixtureFactory.createEventQueue('TypeA');
        EventQueue__c eventB = EventQueueFixtureFactory.createEventQueue('TypeB');
        Test.setCreatedDate(eventA.Id, Datetime.now().addDays(-130));
        Test.setCreatedDate(eventB.Id, Datetime.now().addDays(-130));

        // When - purge only TypeA
        Test.startTest();
        new PurgeEventsJob(120, new List<String>{ 'TypeA' }).execute(null);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id, EventName__c FROM EventQueue__c];
        Assert.areEqual(1, remaining.size(), 'Only TypeB should remain');
        Assert.areEqual('TypeB', remaining[0].EventName__c);
    }

    @isTest
    static void shouldScheduleJobAtHourOne() {
        // When
        Test.startTest();
        PurgeEventsJob.start();

        // Then
        List<CronTrigger> jobs = [
            SELECT Id, CronExpression
            FROM CronTrigger
            WHERE CronJobDetail.Name LIKE 'PurgeEventsJob%'
        ];
        Assert.isFalse(jobs.isEmpty(), 'PurgeEventsJob should be scheduled');
        Assert.isTrue(jobs[0].CronExpression.startsWith('0 0 1'), 'Job should run at hour 1');

        Test.stopTest();
    }

}
