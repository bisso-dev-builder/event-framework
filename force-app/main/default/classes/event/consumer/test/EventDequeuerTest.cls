
@isTest
public class EventDequeuerTest {

    @isTest
    public static void shouldSplitEventsInChunks () {

        List<EventQueue__c> events = EventQueueFixtureFactory.newEventQueues(300);

        EventDequeuerMock dequeuer = new EventDequeuerMock();

        dequeuer.dequeue(events);
        
        Map<Integer, List<String>> chuncks = dequeuer.chuncks;

        Assert.areEqual( 45 , chuncks.size() );

        Assert.areEqual( 5 , chuncks.get(1).size() );
        
    }

    public class EventDequeuerMock extends EventDequeuer {

        @TestVisible
        Map<Integer, List<String>> chuncks = new Map<Integer, List<String>>();

        override
        public void processEvents (List<String> eventIds) {
            chuncks.put ( chuncks.size(), eventIds );
        }

    }

}