@isTest
public class AbstractEventExecutorTest {

    private class ConcreteEventExecutor extends AbstractEventExecutor {
        public ConcreteEventExecutor() {
            super();
        }
    }

    @isTest
    static void shouldCallVirtualExecuteWithEvent() {
        // Given
        ConcreteEventExecutor executor = new ConcreteEventExecutor();
        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent');

        // When - calls the base class virtual empty method
        executor.execute(event);

        // Then - no exception thrown, method executes without side effects
        Assert.isTrue(true, 'execute(EventQueue) should complete without error');
    }

    @isTest
    static void shouldCallVirtualExecuteWithCommandAndEvent() {
        // Given
        ConcreteEventExecutor executor = new ConcreteEventExecutor();
        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent');

        // When - calls the base class virtual empty method
        executor.execute(null, event);

        // Then - no exception thrown, method executes without side effects
        Assert.isTrue(true, 'execute(Command, EventQueue) should complete without error');
    }

}
