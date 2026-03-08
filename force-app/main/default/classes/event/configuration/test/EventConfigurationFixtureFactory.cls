@isTest (isParallel=true)
public class EventConfigurationFixtureFactory {

    public static EventConfiguration__mdt newEventConfigurationMdt(String developerName) {
        return new EventConfiguration__mdt(
            DeveloperName = developerName,
            CommandClassName__c = 'CommandFixtureFactory.FakeCommand',
            Retry__c = 5,
            EnableTraceLog__c = true,
            OAuthEventName__c = 'TestOAuthEvent',
            Disabled__c = false            
        );
    }

    public static EventConfiguration newEventConfiguration(String developerName) {
        return new EventConfiguration(newEventConfigurationMdt(developerName));
    }


    public static EventConfiguration newEventConfigurationForOutbound (String developerName
                                                                        , String responseClassName) {
        return new EventConfiguration(newEventConfigurationMdt(developerName))
                        .outboundConfig( OutboundEventConfigFixtureFactory.newOutboundConfig(responseClassName));

    }

    public static EventConfiguration newOAuthEventConfigurationForOutbound (String developerName
                                                                         , String responseClassName) {
        
        
        EventConfiguration config = newEventConfigurationForOutbound (developerName, responseClassName);

        config.getOutboundConfig().httpMethod('POST')
                    .clientIdCredentialVariable(StringGenerator.text(10))
                    .clientSecretCredentialVariable(StringGenerator.text(10));
        
        return config;

    }
   
    public static List<EventConfiguration> newEventConfigurations(List<String> eventNames) {

        List<EventConfiguration> eventConfigs = new List<EventConfiguration>();

        for (String eventName : eventNames) {
            eventConfigs.add(newEventConfiguration(eventName));
        }
        
        return eventConfigs;
    }


}