@isTest
public class EventQueueFilterTest {

    @isTest
    static void shouldFilterByQueuedStatus() {
        // Dado (Given)
        List<EventQueue__c> events = EventQueueFixtureFactory.newEventQueues(
            new List<String>{'QUEUED', 'PROCESSED', 'QUEUED', 'FAILED'}
        );

        // Quando (When)
        EventQueueFilter filter = new EventQueueFilter();
        List<EventQueue__c> queuedEvents = filter.byQueued(events);

        // Então (Then)
        System.assertEquals(2, queuedEvents.size(), 'Deve retornar apenas 2 eventos com status QUEUED');
        for (EventQueue__c event : queuedEvents) {
            System.assertEquals('QUEUED', event.Status__c, 'O status deve ser QUEUED');
        }
    }

    @isTest
    static void shouldFilterBySpecificStatus() {
        // Dado (Given)
        List<EventQueue__c> events = EventQueueFixtureFactory.newEventQueues(
            new List<String>{'QUEUED', 'PROCESSED', 'QUEUED', 'FAILED'}
        );

        // Quando (When)
        EventQueueFilter filter = new EventQueueFilter();
        List<EventQueue__c> processedEvents = filter.byStatus(events, 'PROCESSED');

        // Então (Then)
        System.assertEquals(1, processedEvents.size(), 'Deve retornar apenas 1 evento com status PROCESSED');
        for (EventQueue__c event : processedEvents) {
            System.assertEquals('PROCESSED', event.Status__c, 'O status deve ser PROCESSED');
        }
    }

    @isTest
    static void shouldReturnEmptyListWhenNoMatch() {
        // Dado (Given)
        List<EventQueue__c> events = EventQueueFixtureFactory.newEventQueues(
            new List<String>{'QUEUED', 'PROCESSED', 'QUEUED', 'FAILED'}
        );

        // Quando (When)
        EventQueueFilter filter = new EventQueueFilter();
        List<EventQueue__c> noMatchEvents = filter.byStatus(events, 'NOT_EXISTING_STATUS');

        // Então (Then)
        System.assertEquals(0, noMatchEvents.size(), 'Deve retornar uma lista vazia quando nenhum status corresponder');
    }
}