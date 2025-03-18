@isTest
public class EnqueueEventsInBatchTest implements Database.Batchable<SObject> {

    public EnqueueEventsInBatchTest() {
    }

    public Database.QueryLocator start(Database.BatchableContext context) {
        // Retorna uma consulta fictícia apenas para simular o Batch
        return Database.getQueryLocator([SELECT Id FROM User]);
    }

    public void execute(Database.BatchableContext context, List<SObject> scope) {

        EventQueueFixtureFactory.createEventQueues(2);

    }

    public void finish(Database.BatchableContext context) {

    }


    @isTest
    static void shouldChangeStatusToScheduledInBatchContext() {

        // Simula o contexto de Batch
        Test.startTest();

        Database.executeBatch(new EnqueueEventsInBatchTest());
    
        Test.stopTest();

        List<EventQueue__c> events = [ SELECT Id, Status__c FROM EventQueue__c];

        Assert.areEqual( 2, events.size(), 'Expected two events');

        // Então (Then)
        for (EventQueue__c event : events) {
            System.assertEquals(
                EventQueueStatusType.SCHEDULED.name(),
                event.Status__c,
                'Status should be updated to Scheduled in Batch context'
            );
        }
    }


}