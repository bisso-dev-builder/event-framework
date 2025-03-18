@isTest
public class EventQueueBuilderTest {

    @isTest
    static void shouldConvertEventQueueToQueueEvents() {
        // Given: Criar uma lista de EventQueue usando a FixtureFactory
        List<EventQueue> events = EventQueueFixtureFactory.newEvents(3);

        List<EventQueue__c> result =  new EventQueueBuilder().convertToQueueEvents(events);

        // Then: Verificar se os eventos foram convertidos corretamente
        System.assertEquals(3, result.size(), 'O número de eventos convertidos deve ser igual ao número de eventos fornecidos.');
        for (Integer i = 0; i < result.size(); i++) {
            System.assertEquals('Event ' + i, result[i].EventName__c, 'O nome do evento convertido deve corresponder ao evento original.');
            System.assertEquals('QUEUED' , result[i].Status__c, 'O tipo do evento convertido deve corresponder ao evento original.');
        }
    }

    @isTest
    static void shouldHandleEmptyEventQueueList() {
        // Given: Uma lista vazia de EventQueue
        List<EventQueue> eventQueues = new List<EventQueue>();

        // When: Invocar o método convertToQueueEvents
        EventQueueBuilder builder = new EventQueueBuilder();
        List<EventQueue__c> result = builder.convertToQueueEvents(eventQueues);

        // Then: Verificar se o resultado é uma lista vazia
        System.assertEquals(0, result.size(), 'O resultado deve ser uma lista vazia quando nenhuma entrada é fornecida.');
    }
}