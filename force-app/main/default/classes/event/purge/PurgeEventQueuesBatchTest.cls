@isTest
public class PurgeEventQueuesBatchTest {

    @isTest
    static void shouldPurgeEventsOlderThanCutoffDate() {
        // Given
        EventQueue__c oldEvent = EventQueueFixtureFactory.createEventQueue('OldEvent');
        EventQueue__c recentEvent = EventQueueFixtureFactory.createEventQueue('RecentEvent');
        Test.setCreatedDate(oldEvent.Id, Datetime.now().addDays(-2));

        Datetime cutoffDate = Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));

        // When
        Test.startTest();
        Database.executeBatch(new PurgeEventQueuesBatch(cutoffDate), 200);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id FROM EventQueue__c];
        Assert.areEqual(1, remaining.size(), 'Only the recent event should remain');
        Assert.areEqual(recentEvent.Id, remaining[0].Id);
    }

    @isTest
    static void shouldPurgeOnlySpecifiedEventTypes() {
        // Given
        EventQueue__c oldEventTypeA = EventQueueFixtureFactory.createEventQueue('TypeA');
        EventQueue__c oldEventTypeB = EventQueueFixtureFactory.createEventQueue('TypeB');
        Test.setCreatedDate(oldEventTypeA.Id, Datetime.now().addDays(-2));
        Test.setCreatedDate(oldEventTypeB.Id, Datetime.now().addDays(-2));

        Datetime cutoffDate = Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));

        // When
        Test.startTest();
        Database.executeBatch(new PurgeEventQueuesBatch(cutoffDate, new List<String>{ 'TypeA' }), 200);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id, EventName__c FROM EventQueue__c];
        Assert.areEqual(1, remaining.size(), 'Only TypeB should survive');
        Assert.areEqual('TypeB', remaining[0].EventName__c);
    }

    @isTest
    static void shouldCompleteWithoutErrorsWhenNoEventsMatch() {
        // Given
        EventQueueFixtureFactory.createEventQueue('RecentEvent');
        Datetime cutoffDate = Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));

        // When
        Test.startTest();
        Database.executeBatch(new PurgeEventQueuesBatch(cutoffDate), 200);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id FROM EventQueue__c];
        Assert.areEqual(1, remaining.size(), 'Recent event should not be purged');
    }

    @isTest
    static void shouldPurgeAllEventsWhenNoEventTypeFilterProvided() {
        // Given
        List<EventQueue__c> events = EventQueueFixtureFactory.createEventQueues(3);
        for (EventQueue__c event : events) {
            Test.setCreatedDate(event.Id, Datetime.now().addDays(-5));
        }

        Datetime cutoffDate = Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));

        // When
        Test.startTest();
        Database.executeBatch(new PurgeEventQueuesBatch(cutoffDate), 200);
        Test.stopTest();

        // Then
        List<EventQueue__c> remaining = [SELECT Id FROM EventQueue__c];
        Assert.areEqual(0, remaining.size(), 'All old events should be purged');
    }

}
