@isTest
public class EventCalloutExecutorTest {

    @isTest
    static void shouldMarkEventAsUnhandledWhenNoHandlerExists() {
        // Arrange
        EventQueue event = EventQueueFixtureFactory.newEvent('TestCommand');
        event.getConfig().commandClassName(null);

        EventCalloutExecutor executor = new EventCalloutExecutor();

        // Act
        executor.execute(event);

        // Assert
        System.assertEquals(
            EventQueueStatusType.UNHANDLED.name(),
            event.getStatus(),
            'O evento deve ser marcado como UNHANDLED quando não possui handler.'
        );
    }

    @isTest
    static void shouldMarkEventAsIgnoredWhenConfigIsDisabled() {
        
        // Arrange
        EventQueue event = EventQueueFixtureFactory.newEvent('TestCommand');
        event.getConfig().disabled(true);

        EventCalloutExecutor executor = new EventCalloutExecutor();

        // Act
        executor.execute(event);

        // Assert
        System.assertEquals(
            EventQueueStatusType.IGNORED.name(),
            event.getStatus(),
            'O evento deve ser marcado como IGNORED quando a configuração está desabilitada.'
        );
    }

}