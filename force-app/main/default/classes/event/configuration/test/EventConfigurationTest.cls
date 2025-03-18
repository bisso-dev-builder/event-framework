@isTest
public class EventConfigurationTest {

    @isTest
    static void shouldCreateEventConfigurationWithDefaultValues() {
        // Given
        EventConfiguration eventConfig = new EventConfiguration();

        // Then
        System.assertEquals(10, eventConfig.getRetry(), 'Default retry should be 10');
        System.assertEquals(false, eventConfig.isDisabled(), 'Default disabled should be false');
        System.assertEquals(true, eventConfig.isEnableTraceLog(), 'Default enableTraceLog should be true');
    }

    @isTest
    static void shouldCreateEventConfigurationFromMdt() {
        // Given
        EventConfiguration__mdt config = EventConfigurationFixtureFactory.newEventConfigurationMdt('TestEvent');

        // When
        EventConfiguration eventConfig = new EventConfiguration(config);

        // Then
        System.assertEquals('TestEvent', eventConfig.getEventName(), 'Event name should match');
        System.assertEquals('CommandFixtureFactory.FakeCommand', eventConfig.getCommandClassName(), 'Command class name should match');
        System.assertEquals(5, eventConfig.getRetry(), 'Retry count should match');
        System.assertEquals(true, eventConfig.isEnableTraceLog(), 'EnableTraceLog should match');
        System.assertEquals('TestOAuthEvent', eventConfig.getOAuthEventName(), 'OAuthEventName should match');
        System.assertEquals(false, eventConfig.isDisabled(), 'Disabled should match');
        System.assertEquals(null, eventConfig.getOutboundConfig(), 'Expected null outbound config');
    }

    @isTest
    static void shouldBuildConfigsFromMdtList() {
        // Given
        List<EventConfiguration__mdt> configs = new List<EventConfiguration__mdt>{
            EventConfigurationFixtureFactory.newEventConfigurationMdt('Event1'),
            EventConfigurationFixtureFactory.newEventConfigurationMdt('Event2')
        };

        // When
        List<EventConfiguration> eventConfigs = EventConfiguration.buildConfigs(configs);

        // Then
        System.assertEquals(2, eventConfigs.size(), 'Should create two EventConfigurations');
        System.assertEquals('Event1', eventConfigs[0].getEventName(), 'First event name should match');
        System.assertEquals('Event2', eventConfigs[1].getEventName(), 'Second event name should match');
    }

    @isTest
    static void shouldReturnCommandInstanceWhenCommandHandlerExists() {
        // Given
        EventConfiguration eventConfig = EventConfigurationFixtureFactory.newEventConfiguration('TestEvent');

        // When
        Boolean hasCommandHandler = eventConfig.hasCommandHandler();
        Command command = eventConfig.getCommand();

        // Then
        System.assertEquals(true, hasCommandHandler, 'Should have a command handler');
        System.assertNotEquals(null, command, 'Command instance should not be null');
    }

    @isTest
    static void shouldHandleNullMdtGracefully() {
        // When
        EventConfiguration eventConfig = new EventConfiguration(null);

        // Then
        System.assertEquals(10, eventConfig.getRetry(), 'Default retry should be 10');
        System.assertEquals(false, eventConfig.isDisabled(), 'Default disabled should be false');
        System.assertEquals(true, eventConfig.isEnableTraceLog(), 'Default enableTraceLog should be true');
    }
}