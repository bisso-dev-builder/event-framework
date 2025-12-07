@isTest
public class BaseEventPublisherTest {

    @isTest
    static void shouldMockPublishEventsSuccessfully() {
        
        List<Account> accounts = new List<Account> {
            AccountFixtureFactory.newWithFakeId(StringGenerator.text(10))
        };

        String eventName = 'SyncAccountOutbound';

        
        EventQueueRepository repositoryMock = new EventQueueRepositoryTest.EventQueueRepositoryMock();

        BaseEventPublisher publisher = new BaseEventPublisher(repositoryMock);
        
        List<EventQueue__c> events = publisher.publish(eventName,accounts);

        Assert.areEqual('QUEUED', events.get(0).Status__c);
        Assert.isNotNull( events.get(0).Id );

    }

    @isTest
    static void shouldPublishEventsSuccessfully() {
        
        List<Account> accounts = new List<Account> {
            AccountFixtureFactory.newWithFakeId(StringGenerator.text(10))
        };

        String eventName = 'SyncAccountOutbound';

        BaseEventPublisher publisher = new BaseEventPublisher();
        
        List<EventQueue__c> events = publisher.publish(eventName,accounts);
        
        Assert.areEqual('QUEUED', events.get(0).Status__c);
        Assert.isNotNull( events.get(0).Id );

    }

}